# Feature workflow

A request to build a feature starts this workflow under the [repository instructions](../AGENTS.md). Use one main coordinating session per project and keep it available for requirements and coordination. The feature’s design session coordinates its implementation and review.

Inspect the checkout first. Find matching work in the project’s GitHub repository when reachable. Use existing issues, approvals, sessions, branches, and pull requests to resume at the first incomplete stage. If lookup is unavailable, start requirements locally. Verify the GitHub repository from the configured remotes before publishing.

Follow [feature progress](progress.md) from issue creation through merge. For local work, keep the artifacts, approvals, and status in the feature worktree and use the same interactive gate for implementation. Draft-only and design-only requests stop at the requested artifact.

## When to ask the user

Use the workflow's interactive checkpoints, including requirements confirmation and approval of the architecture and test specification. Pause for any decision the user explicitly reserved, a material change to settled requirements or approved design, or a blocker only the user can resolve after safe recovery attempts. Otherwise choose a reversible option within scope, record consequential choices in the appropriate progress update, and keep going. A required host permission uses the host's permission mechanism.

Use the [Orca question tool](orca.md#ask-for-human-input) when human input is needed. A worker that cannot open a card sends the decision and options to the user-facing coordinator. Continue independent work while the affected step is paused.

## 1. Settle requirements and dispatch design

Use [`$grill-requirements`](../.agents/skills/grill-requirements/SKILL.md) and the [feature spec](../templates/feature-spec.md). Inspect existing behavior, then ask every remaining question whose answer affects what must be built or verified. Confirm material decisions and ticket boundaries together. Record the settled revision and actual user decisions.

### Publish the issues

1. Use the [feature issue template](../.github/ISSUE_TEMPLATE/feature.md) and the settled requirements. Use one issue for a small feature. For larger work, use numbered, verifiable slices with real dependencies. Link the approval record and any published domain documents. Include essential content from local files in the issue or handoff.
2. Check that issues are enabled in the verified repository. Reuse matching issues and publish missing blockers first. Map draft numbers to the resulting URLs. Use native GitHub parent and dependency links when applicable. Verify the content and relationships before dispatch.
3. On an ambiguous result, check the returned issue URL or look for the same feature and requirements revision before retrying. Resume from verified issues and complete any missing agreed relationships.

For GitHub CLI, set the verified `$issueRepo` and agreed `$issueTitle`. Write the issue body to `$approvedIssueBodyFile`. Set `$blockedByIssueUrls` and `$parentIssueUrl` from the verified dependency URLs, using an empty list and `$null` when absent. Run once for each missing issue in dependency order.

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

[GitHub CLI issue creation](https://cli.github.com/manual/gh_issue_create) · [Issue dependencies](https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies)

### Start the feature worktree

Use the [Orca launch steps](orca.md#launch-design-in-a-worktree) to give a fresh designer its own worktree, the settled requirements, and relevant domain decisions. Record the worktree, branch, session, and expected areas of change in the issue’s Handoff section. Record the handoff milestone. The feature session owns progress updates after handoff. Report verified delivery and return to the user.

Use one worktree per feature. Independent features can run in parallel. Track true dependencies in the issues. Before dispatch, the main coordinator checks active issues and PRs and records the feature’s write scope in its Handoff. Cover shared files, interfaces, schemas, and architecture docs. Only the main coordinator grants ownership of shared edits. A designer can propose an expanded scope, then keeps it in the feature proposal until ownership is confirmed. Only the assigned owner edits shared files, including domain and architecture documents. Sequence overlapping writes or assign the shared change to a single prerequisite owner. A blocked feature can plan from the agreed interfaces. Refresh its base and recheck the design after the prerequisite lands.

## 2. Approve both design documents

Use [`$design-and-test`](../.agents/skills/design-and-test/SKILL.md) in the feature session to prepare the [architecture](../templates/architecture.md) and the [test specification](../templates/test-spec.md). Include the relevant shared architecture changes and project checks. Make both versions readable from Orca mobile and record the pending decision in the issue progress before calling the [interactive approval gate](orca.md#request-interactive-approval).

One selection can approve both named revisions. Record the human’s actual answer, question or session reference, and the requirements and document revisions it covers. Revisions requested by the user must receive a new interactive review. Reuse earlier approvals if they still cover the exact requirements, architecture, and test specification, including an older combined plan that covers both documents.

### Check readiness before implementation

Check readiness for each slice, using the issue and linked records or the local equivalents.

- The current requirements have recorded human confirmation.
- The architecture and test specification have recorded interactive approval for their current versions.
- Every dependency needed by the slice is resolved and present in the base. Shared edits have a confirmed owner.

Resolve routine readiness problems before escalating. If Git reports that an untracked file would be overwritten, inspect the file and the verified prerequisite commit. Integrate and verify the prerequisite in a clean, isolated worktree or replaceable checkout while keeping the original working files intact. If the file contains work the feature needs, preserve and account for that work before switching the active checkout. Continue after rechecking the approved documents against the new base. Request input only if safe recovery is unavailable or the choice materially affects the approved scope.

Keep the slice paused while a check is pending. Record the reason and what must happen next. When a decision or changed base affects the approved behavior or design, return the affected documents for review.

## 3. Delegate test-first implementation

The feature session dispatches each ready slice to the implementation worker as its own task in the feature worktree. Pass the approval record, exact documents, dependencies, assigned paths, and commands to verify. The worker verifies readiness and uses [`$test-first`](../.agents/skills/test-first/SKILL.md). It should implement the smallest behavior at a time, commit its changes, and return failing-before and passing-after evidence. Record each verified milestone with its commit, evidence, and next step. Recheck readiness for the next slice after its prerequisites land. Use the existing approvals when their scope still covers the slice.

Use the [CI guide](ci.md) to reuse or set up relevant checks. For UI work, verify behavior in Orca’s browser or the coding agent’s browser in addition to automated tests. Record the scenarios and observations from the running app.

## 4. Review and merge

In the full GitHub workflow, open or update the draft PR from the implementation commit so CI runs in the verified repository. Link the issues, both approved documents, and verification results in the [PR template](../.github/pull_request_template.md).

The feature session delegates independent review to a fresh [review worker](../.agents/skills/review-feature/SKILL.md) with the exact base and head, approved documents, and evidence. Send blocking findings to the implementation worker. Run the affected checks again and review the new head. Repeat until the current commit has no blocking findings.

Mark a PR ready and merge only after independent review and required checks pass for the proposed commit. The maintainer decides when to merge. For local work, use the same pinned review and fix loop. Record the reviewed commit and local verification in the worktree. Complete the local feature after its checks and review pass.

## Resume work

“Continue issue #12” resumes from its Handoff and latest progress update. Check the requirements, approvals, dependencies, worktree and session, PR, and checked commit to find the next action. The feature session owns continuation after a worker reports. Inspect existing receipts when an action’s outcome is uncertain.
