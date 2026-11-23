# Feature workflow

Use one GitHub issue per verifiable unit of work to connect its approved scope, implementation, and review. Keep the documents proportionate to the size of the change.

## 1. Define and approve the feature

For a rough brief or unresolved product decision, use [`$grill-requirements`](../.agents/skills/grill-requirements/SKILL.md) to check existing project facts, ask decision questions, and draft the [feature spec](../templates/feature-spec.md). Clarify domain terms when their meaning changes behavior. Capture settled choices and leave open questions visible.

Have the human project owner approve the requirements revision before planning implementation. Then draft one task for a small feature or verifiable slices for larger work. Each draft identifies the outcome, acceptance criteria it covers, how to observe that outcome, and actual blocking dependencies.

Record approvals in a GitHub issue comment from the human decision maker or in a review on a documentation pull request. Identify the revision the decision covers.

### Review the ticket breakdown

For a multi-issue feature, show a numbered breakdown before preparing issue previews. Each ticket should deliver a small, independently verifiable behavior and name the acceptance criteria it covers. Ask the owner whether any tickets should be split or combined and which dependencies actually prevent work from starting. Resolve dependency cycles and confirm the breakdown with the owner. For a single task, review the scope in its issue preview.

### Publish task drafts to GitHub

1. Show the target repository in `OWNER/REPO` form and preview each exact title and body using the [feature issue template](../.github/ISSUE_TEMPLATE/feature.md). Include the approved spec revision, criteria, verification, and any blockers. Link the approval record when it is on GitHub. If the decision was made in chat, identify the approved revision and ask the human to record that approval in GitHub before implementation.
2. Preview the GitHub relationships alongside the bodies. Use draft numbers for issues that have yet to be created. Use an existing spec issue as a parent when it serves as the common spec for the batch. Wait for explicit authorization covering the repository, titles, bodies, and relationships. If any of those change, show the revised preview and obtain authorization for it. Confirm the repository identity and that issues are enabled.
3. Create blockers first. As each issue is verified, map its draft number to its GitHub URL. Use those URLs to create the approved native blocking links and use the approved parent for sub-issues. Read back each issue and confirm its repository, title, body, and intended relationships before continuing. Keep the confirmed issue numbers and URLs with the tasks.
4. If creation or readback fails, check the returned URL first. If there is no URL, inspect recent open and closed issues in the target repository for the same task and approved spec revision. Reuse a confirmed match and add only missing relationships covered by the authorization. Read the issue back again before continuing. Resolve any uncertainty before attempting another creation and retain the links already confirmed.

With GitHub CLI, set `$issueRepo` and `$issueTitle` from the approved preview and `$approvedIssueBodyFile` to a temporary file containing the exact approved body. Set `$blockedByIssueUrls` to the verified URLs for the approved blockers, or `@()` when absent. Set `$parentIssueUrl` to the approved parent URL, or `$null` when absent. Run this for each authorized draft in dependency order.

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

Compare the JSON with the approved content and resolved relationships. [GitHub CLI issue creation](https://cli.github.com/manual/gh_issue_create) · [Issue dependencies](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies) · [Sub-issues](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues)

## 2. Agree on the design and tests

Use the [design and test plan](../templates/design-and-test.md) to identify the affected parts of the project and map acceptance criteria to test scenarios. Identify where each important behavior is observable, such as a browser interaction, API response, or CLI result. Include the commands or manual checks that will verify the change. Ask for human approval of the plan before implementation. If a change revises approved behavior or test expectations, record approval for the affected revision before proceeding with that part.

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
