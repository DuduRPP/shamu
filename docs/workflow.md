# Feature workflow

Use one GitHub issue per verifiable unit of work to connect its approved scope, implementation, and review. Keep the documents proportionate to the size of the change.

## 1. Grill the feature and start design

Use [`$grill-requirements`](../.agents/skills/grill-requirements/SKILL.md) to settle the decisions that affect behavior and capture confirmed domain terms and relevant architecture decisions as they emerge. Use that language for the scope and criteria in the [feature spec](../templates/feature-spec.md). A request for a draft ends with the draft.

When the user has authorized issue creation and the design handoff for this feature in the named repo, proceed once the interview decisions settle the scope. Otherwise, close the interview with one short summary of the scope, target repo, and planned design handoff. Ask for one go-ahead that confirms the scope and authorizes both actions. Use the decisions from the interview and confirm any unresolved material choice before proceeding.

Give the settled spec a revision and record the human's actual confirmation and its source with that revision in the issue. Link an issue comment, documentation review, or interview reference when available. Ask for an updated decision when scope changes materially.

### Prepare and publish the issues

1. Use the [feature issue template](../.github/ISSUE_TEMPLATE/feature.md). A small feature gets one issue with the scope, agreed decisions, acceptance criteria, and verification. For larger work, use the numbered ticket slices from the requirements skill. Include consequential splits and proposed parent or blocker links in the same closeout if they still need a decision. Resolve dependency cycles before publishing. Link relevant domain documents that readers can access and summarize any essential decisions from local documents in the issue.
2. Confirm the authorized target repository and that issues are enabled. Create blockers first, map their draft numbers to the returned issue URLs, and use approved native GitHub relationships for dependencies and any parent. Read the issues back to confirm the agreed content and links before handing them off.
3. If creation or readback fails, check any returned URL or look for the same task and spec revision in the target repository. Resume from verified issues and complete missing authorized relationships. Resolve an ambiguous result before trying another create.

With GitHub CLI, set `$issueRepo` and `$issueTitle` from the settled scope and `$approvedIssueBodyFile` to a temporary file containing the issue body. Set `$blockedByIssueUrls` to the verified URLs for any approved blockers, or `@()`. Set `$parentIssueUrl` to the approved parent URL, or `$null`. Run this for each authorized issue in dependency order.

```powershell
$createIssueArgs = @('issue', 'create', '--repo', $issueRepo, '--title', $issueTitle, '--body-file', $approvedIssueBodyFile)
if ($blockedByIssueUrls.Count -gt 0) {
    $createIssueArgs += @('--blocked-by', ($blockedByIssueUrls -join ','))
}
if ($parentIssueUrl) {
    $createIssueArgs += @('--parent', $parentIssueUrl)
}

$issueUrl = gh @createIssueArgs
$createExit = $LASTEXITCODE
if ($issueUrl) {
    Write-Output $issueUrl
}
if ($createExit -ne 0 -or -not $issueUrl) {
    throw 'Issue creation or linking could not be confirmed. Check GitHub before retrying.'
}
gh issue view $issueUrl --repo $issueRepo --json 'number,url,title,body,parent,blockedBy'
if ($LASTEXITCODE -ne 0) {
    throw 'Check the returned issue URL before retrying.'
}
```

Compare the JSON with the agreed content and resolved relationships. [GitHub CLI issue creation](https://cli.github.com/manual/gh_issue_create) · [Issue dependencies](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies) · [Sub-issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues)

### Hand off to a new Orca session

After verifying the issues, launch a fresh Codex session in the current Orca worktree. Use one session for the feature. Give it the verified issue URLs, the settled requirements revision, and the paths of relevant local glossary and decision records. Start [`$design-and-test`](../.agents/skills/design-and-test/SKILL.md) in that session so it can inspect the checkout and draft the architecture and test plan immediately.

Load the version-matched launch guide with `orca skills get orca-cli` using the Orca CLI resolved for the current session. Set `$verifiedIssueUrls` and `$settledSpecRevision` from the verified issue. Set `$domainContextPaths` to the relevant repository-relative glossary and decision record paths, or `@()`. Set `$authorizedFollowUp` to any actions explicitly authorized after plan approval, or an empty string. With `orca` as the resolved executable, launch from the issue's project.

```powershell
if (-not $verifiedIssueUrls -or -not $settledSpecRevision) {
    throw 'A verified issue and settled requirements revision are required for design handoff.'
}
$designBrief = @(
    'Use $design-and-test to draft the architecture and test plan for review.'
    "Verified issues $($verifiedIssueUrls -join ', ')."
    "Settled requirements revision $settledSpecRevision."
    'Inspect this checkout, including relevant local context. Present one proposal for review.'
) -join ' '
if ($domainContextPaths) {
    $designBrief += " Local domain documents $($domainContextPaths -join ', ')."
}
if ($authorizedFollowUp) {
    $designBrief += " Authorized after plan approval: $authorizedFollowUp"
}
orca agent launch --agent codex --worktree current --prompt $designBrief --json
```

Report the verified issue and new session handle after the launch receipt confirms prompt delivery. If launch is unavailable or the reply is lost, retain the issue link and follow Orca's recovery instructions for the same launch. [Orca CLI handoffs](https://github.com/stablyai/orca/blob/main/skill-guides/orca-cli.md#full-handoffs)

## 2. Review the design and tests

The design session uses the [design and test template](../templates/design-and-test.md) to present one proposal. It identifies responsibilities and state ownership, maps criteria to public tests, and orders the first test-first slices. Include a diagram when it clarifies a design question.

Review the proposal in that session. One response can approve the plan and authorize recording the decision and starting implementation. Reuse any authorization already given. Record the specific approved plan revision in the issue or design document as authorized. For a plan that spans multiple issues, link the shared approval to the affected issues when authorized. A request to revise the plan returns only the affected decisions and tests for review.

### Check readiness before implementation

Start from the issue and its linked decisions. Apply these checks to each issue and begin with a ready issue in the planned order.

- The current requirements revision has recorded human approval.
- The design and test plan for that revision has recorded human approval.
- Every blocking issue has been resolved.

If a check is pending, surface the specific approval or blocker. When authorized to update the issue, use its Handoff section to record what is pending or mark it ready and record the next action.

## 3. Implement in a worktree

Use [`$test-first`](../.agents/skills/test-first/SKILL.md) in the assigned worktree with the issue and approved plan. Implement one observable behavior at a time. Confirm the expected failure, make the smallest change that passes, rerun the relevant checks, and carry the evidence to review.

## 4. Review and merge

Open a draft pull request using the [pull request template](../.github/pull_request_template.md). Link the issue and decisions and report what passed or needs follow-up. Give a fresh review session the approved requirements revision, the exact diff, and verification results for the code under review. Ask for findings tied to requirements, regressions, or missing evidence. Resolve findings and rerun affected checks. The human maintainer decides when to merge and verifies that the issue reflects the outcome.

## Resume work

Start a fresh session with the issue link. The issue should point to the current approved revisions, the active branch or pull request, and any blocker. If work is interrupted, record the latest verification result and the next action so the session can continue from GitHub.
