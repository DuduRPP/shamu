# Feature workflow

A request to build a feature starts this workflow under the [repository instructions](../AGENTS.md). Use one issue per verifiable unit of work and keep the documents proportionate to the change.

Inspect the checkout first. Use a supplied issue from the project's GitHub repository or look there for matching work when it is reachable. Resume at the first unfinished stage, reusing recorded approvals, the existing design session, and the feature branch or PR when available. Start requirements from the checkout when issue lookup is unavailable. Resolve and verify the GitHub destination from the configured remotes before publishing.

For a draft or design-only request, stop at the requested artifact. For local work, keep the requirements, plan, and approvals in the checkout and continue without GitHub writes.

## 1. Grill the feature and start design

Use [`$grill-requirements`](../.agents/skills/grill-requirements/SKILL.md) to settle the decisions that affect behavior and capture confirmed domain terms and architecture decisions as they emerge. Use that language for the scope and criteria in the [feature spec](../templates/feature-spec.md).

The user's confirmed decisions can settle the scope. If material scope or ticket boundaries still need confirmation, ask about those together in one recap. Once the scope is settled, publish and verify the issues and start design as part of the full workflow.

Give the settled spec a revision and record the human's actual confirmation and its source with that revision in the issue. Link an issue comment, documentation review, or interview reference when available. Ask for an updated decision when scope changes materially.

### Prepare and publish the issues

1. Use the [feature issue template](../.github/ISSUE_TEMPLATE/feature.md). A small feature gets one issue with the scope, agreed decisions, acceptance criteria, and verification. For larger work, use the numbered ticket slices from the requirements skill. Include consequential splits and proposed parent or blocker links in the same closeout if they still need a decision. Resolve dependency cycles before publishing. Link relevant domain documents that readers can access and summarize any essential decisions from local documents in the issue.
2. Check that issues are enabled in the verified repository. Reuse matching issues and create any missing blockers first. Map the draft numbers to the resulting issue URLs and set agreed parent and blocker links using GitHub relationships. Read the issues back to confirm the agreed content and links before handing them off.
3. If creation or readback fails, check any returned URL or look for the same task and spec revision in the target repository. Resume from verified issues and complete any missing agreed relationships. Resolve an ambiguous result before trying another create.

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

Load the version-matched launch guide with `orca skills get orca-cli` using the Orca CLI resolved for the current session. Set `$verifiedIssueUrls` and `$settledSpecRevision` from the verified issue. Set `$domainContextPaths` to the relevant repository-relative glossary and decision record paths, or `@()`. Set `$continueAfterPlanApproval` to `$true` for a full feature request, or `$false` for a design-only handoff. With `orca` as the resolved executable, launch from the issue's project.

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
if ($continueAfterPlanApproval) {
    $designBrief += ' Continue the full feature workflow after the user approves this plan revision. Record approval, check readiness, and proceed through test-first implementation and draft PR review in the verified project repository.'
}
orca agent launch --agent codex --worktree current --prompt $designBrief --json
```

Report the verified issues and new session handle after the launch receipt confirms prompt delivery. If the reply is lost, retain the issue links and use Orca's recovery instructions before retrying. If Orca is unavailable, present the design proposal in the current session and report where the handoff stopped. [Orca CLI handoffs](https://github.com/stablyai/orca/blob/main/skill-guides/orca-cli.md#full-handoffs)

## 2. Review the design and tests

The design session uses the [design and test template](../templates/design-and-test.md) to present one proposal. It identifies responsibilities and state ownership, maps criteria to public tests, and orders the first test-first slices. Include a diagram when it clarifies a design question.

Ask for one review of the design and tests. In the full workflow, put the user's approval on the issue or link to the approved plan from it. Link shared approval to the affected issues. For local work, keep the approval in the plan. After recording approval of the presented revision, continue with the next ready slice. Revisions to the proposal return to review for the affected decisions and tests.

### Check readiness before implementation

Start from the issue and its linked decisions, or the local requirements and plan for local work. Apply these checks to each slice and begin with a ready slice in the planned order.

- The current requirements revision has recorded human approval.
- The design and test plan for that revision has recorded human approval.
- Every blocker for the slice has been resolved.

If a check is pending, surface the specific approval or blocker. Use the issue's Handoff section when updating the tracker to record what is pending or what can proceed.

## 3. Implement in a worktree

Use [`$test-first`](../.agents/skills/test-first/SKILL.md) with the approved requirements and plan. Continue in the feature worktree or create a feature branch if needed. Implement one observable behavior at a time. Confirm the expected failure, make the smallest change that passes, rerun the relevant checks, and carry the evidence to review.

## 4. Review and merge

After verification in the full workflow, commit the feature changes and push the branch to the verified repository. Open a draft PR or update the existing PR using the [pull request template](../.github/pull_request_template.md). Link the issue and decisions and report what passed or needs follow-up. Give a fresh review session the approved requirements revision, the exact diff, and verification results for the code under review. Ask for findings tied to requirements, regressions, or missing evidence. Resolve findings and rerun affected checks. The human maintainer decides when to merge and verifies that the issue reflects the outcome.

## Resume work

A request like “Continue issue #12” resumes the feature workflow at its current stage. The issue should point to the current approved revisions, the active branch or pull request, and any blocker. If work is interrupted, record the latest verification result and the next action so the session can continue from GitHub.
