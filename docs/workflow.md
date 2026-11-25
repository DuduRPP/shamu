# Feature workflow

Use one GitHub issue per verifiable unit of work to connect its approved scope, implementation, and review. Keep the documents proportionate to the size of the change.

## 1. Grill the feature and start design

Use [`$grill-requirements`](../.agents/skills/grill-requirements/SKILL.md) to check project facts and settle the product decisions that affect behavior. Capture the agreed scope, decision details, and testable criteria in the [feature spec](../templates/feature-spec.md). A request for a draft ends with the draft.

When the user has authorized issue creation and the design handoff for this feature in the named repo, proceed once the interview decisions settle the scope. Otherwise, close the interview with one short summary of the scope, target repo, and planned design handoff. Ask for one go-ahead that confirms the scope and authorizes both actions. Use the decisions from the interview and confirm any unresolved material choice before proceeding.

Give the settled spec a revision and record the human's actual confirmation and its source with that revision in the issue. Link an issue comment, documentation review, or interview reference when available. Ask for an updated decision when scope changes materially.

### Prepare and publish the issues

1. Use the [feature issue template](../.github/ISSUE_TEMPLATE/feature.md). A small feature gets one issue with the scope, agreed decisions, acceptance criteria, and verification. For larger work, draft numbered, independently verifiable outcomes and identify real blockers. Include consequential splits and proposed parent or blocker links in the same closeout if they still need a decision. Resolve dependency cycles before publishing.
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

As soon as the issue is verified, launch a fresh Codex session in the current Orca worktree so it can inspect the same checkout. Use one session for the feature. Give it the verified issue URL or URLs, the settled requirements revision, and any relevant local context. Ask for an architecture proposal and acceptance tests using the [design and test template](../templates/design-and-test.md). The assignment ends with a plan for the user to review.

Load the version-matched launch guide with `orca skills get orca-cli` using the Orca CLI resolved for the session. With `orca` as the executable, set `$designBrief` to a short prompt containing the issue links, revision, and design-only scope, then launch from the issue's project.

```powershell
orca agent launch --agent codex --worktree current --prompt $designBrief --json
```

Report the issue link and the new session handle after the launch receipt confirms prompt delivery. If launch is unavailable or the reply is lost, retain the verified issue link and follow Orca's recovery instructions for that same launch. Resume the handoff from the existing issue. [Orca CLI handoffs](https://github.com/stablyai/orca/blob/main/skill-guides/orca-cli.md#full-handoffs)

## 2. Agree on the design and tests

In the design session, use the [design and test plan](../templates/design-and-test.md) to identify the affected parts of the project and map acceptance criteria to test scenarios. Identify where each important behavior is observable, such as a browser interaction, API response, or CLI result. Include the commands or manual checks that will verify the change. Ask for human approval of the plan before implementation. If a change revises approved behavior or test expectations, record approval for the affected revision before proceeding with that part.

### Check readiness before implementation

Start from the issue and its linked decisions. Check all three conditions before starting implementation.

- The current requirements revision has recorded human approval.
- The design and test plan for that revision has recorded human approval.
- Every blocking issue has been resolved.

If a check is pending, surface the specific approval or blocker. When authorized to update the issue, use its Handoff section to record what is pending or mark it ready and record the next action.

## 3. Implement in a worktree

Start an Orca session in an assigned worktree. Give Codex the issue and its approved documents. For behavior covered by automated tests, write the tests first and confirm they fail for the expected reason. Implement the feature, rerun the tests, and run the project's relevant checks.

## 4. Review and merge

Open a draft pull request using the [pull request template](../.github/pull_request_template.md). Link the issue and decisions and report what passed or needs follow-up. Give a fresh review session the approved requirements revision, the exact diff, and verification results for the code under review. Ask for findings tied to requirements, regressions, or missing evidence. Resolve findings and rerun affected checks. The human maintainer decides when to merge and verifies that the issue reflects the outcome.

## Resume work

Start a fresh session with the issue link. The issue should point to the current approved revisions, the active branch or pull request, and any blocker. If work is interrupted, record the latest verification result and the next action so the session can continue from GitHub.
