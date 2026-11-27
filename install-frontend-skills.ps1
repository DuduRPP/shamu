[CmdletBinding()]
param(
    [string] $Destination = '.optional-skills',
    [string[]] $Skill,
    [switch] $List
)

$ErrorActionPreference = 'Stop'

# Each revision pins the complete upstream skill directory, including its resources.
$anthropic = 'e4bb5d960d87126ff3b3a8af1a104b7db67560ba'
$emil = '64eb3deb9a5fbfa041faf783e0bc3fd635872e9c'
$pstack = 'b7b93c36be9bcc36a74db438e0fd385d660bc559'
$catalog = [ordered]@{
    'frontend-design'               = @('anthropics/skills', 'skills/frontend-design', $anthropic)
    'ui-ux-pro-max'                  = @('nextlevelbuilder/ui-ux-pro-max-skill', '.claude/skills/ui-ux-pro-max', '11ca2b3bdd555649f278ee348c32a9302b24dcf1')
    'impeccable'                     = @('pbakaus/impeccable', '.agents/skills/impeccable', '2fc5e1459efbbf06d92c7306517c286bf12490cf')
    'web-design-guidelines'          = @('vercel-labs/agent-skills', 'skills/web-design-guidelines', '53b6e3ddf96b3fa83af97b1783ed805b582ad3a7')
    'webapp-testing'                 = @('anthropics/skills', 'skills/webapp-testing', $anthropic)
    'pick-ui-library'                = @('emilkowalski/skills', 'skills/pick-ui-library', $emil)
    'break-ui'                       = @('emilkowalski/skills', 'skills/break-ui', $emil)
    'mobile-native'                  = @('emilkowalski/skills', 'skills/mobile-native', $emil)
    'review-animations'              = @('emilkowalski/skills', 'skills/review-animations', $emil)
    'principle-type-system-discipline' = @('cursor/plugins', 'pstack/skills/principle-type-system-discipline', $pstack)
    'typescript-best-practices'      = @('cursor/plugins', 'pstack/skills/typescript-best-practices', $pstack)
    'react-best-practices'           = @('vercel-labs/agent-skills', 'skills/react-best-practices', '5a37a6329fbad3666c3207392a6a7c0110e92efb')
}

if ($List) {
    foreach ($name in $catalog.Keys) {
        Write-Output "$name [$($catalog[$name][0])]"
    }
    return
}

if (-not $Skill.Count) {
    $Skill = @($catalog.Keys)
}
$Skill = @($Skill | ForEach-Object { $_.ToLowerInvariant() })
foreach ($name in $Skill) {
    if (-not $catalog.Contains($name)) {
        throw "Unknown skill '$name'. Run with -List to see your options."
    }
}
if ($Skill -contains 'typescript-best-practices') {
    $Skill = @('principle-type-system-discipline') + $Skill
}

Get-Command gh -ErrorAction Stop | Out-Null
$target = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
[IO.Directory]::CreateDirectory($target) | Out-Null
$inventory = gh skill list --dir $target --json skillName,sourceURL,version
if ($LASTEXITCODE -ne 0) {
    throw 'GitHub CLI could not list the destination. Use a recent version with gh skill support.'
}
$installed = $inventory | ConvertFrom-Json
$pending = @()
foreach ($name in ($Skill | Select-Object -Unique)) {
    $repo, $path, $revision = $catalog[$name]
    $folder = Join-Path $target $name
    if (-not (Test-Path -LiteralPath $folder)) {
        $pending += $name
        continue
    }
    $samePin = $installed | Where-Object {
        $_.skillName -eq $name -and $_.sourceURL -eq "https://github.com/$repo" -and
        $_.version -eq $revision
    }
    if (-not $samePin) {
        throw "A different '$name' already exists in $target. Use another destination or move that skill before retrying."
    }
    Write-Output "Already installed: $name"
}
if (-not $pending.Count) {
    return
}

# Stage beside the destination skills so a failed download cannot leave a partial skill.
$stage = Join-Path $target ('.frontend-install-' + [guid]::NewGuid().ToString('N'))
[IO.Directory]::CreateDirectory($stage) | Out-Null
try {
    foreach ($name in $pending) {
        $repo, $path, $revision = $catalog[$name]
        $argsForInstall = @('skill', 'install', $repo, "$path/SKILL.md@$revision", '--dir', $stage)
        if ($path.StartsWith('.')) {
            $argsForInstall += '--allow-hidden-dirs'
        }
        Write-Output "Installing $name from $repo..."
        $details = & gh @argsForInstall
        if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath (Join-Path $stage "$name/SKILL.md") -PathType Leaf)) {
            throw "Could not install '$name' from $repo at ${revision}.`n$($details -join `"`n`")"
        }
    }
    foreach ($name in $pending) {
        [IO.Directory]::Move((Join-Path $stage $name), (Join-Path $target $name))
    }
}
finally {
    $resolved = (Resolve-Path -LiteralPath $stage).ProviderPath
    if ([IO.Directory]::GetParent($resolved).FullName -eq (Resolve-Path -LiteralPath $target).ProviderPath -and
        [IO.Path]::GetFileName($resolved) -match '^\.frontend-install-[0-9a-f]{32}$') {
        Remove-Item -LiteralPath $resolved -Recurse -Force
    }
}
Write-Output "Installed $($pending.Count) skill(s) in $target."
