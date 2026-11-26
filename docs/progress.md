# Feature progress

## Commit as work progresses

Use `type(scope): description`, or omit the scope when it adds no context. Describe the change in the imperative. Use `feat` for new behavior, `fix` for a bug, `docs` for documentation, `test` for test-only changes, `ci` for pipeline changes, or `chore` for maintenance. Follow the project’s existing Conventional Commits types and scopes. [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/)

- Commit each self-contained, verified slice or review fix in the feature worktree. A documentation or CI change can be its own commit. Include implementation and tests for the slice together once the checks pass. Keep the expected failing test result in the evidence.
- Stage only the assigned changes and inspect the staged diff. The feature coordinator verifies each worker’s result, then pushes the commit to the current feature branch for GitHub work. Continue using that branch and its PR on subsequent slices.
- Each implementation dispatch covers one independently verifiable slice or review fix. Return the exact commit SHA, covered criteria, verification, and any blocker to the feature coordinator through the completion receipt. Refer to the issue in the commit body when it helps trace the change. Reserve closing links for the PR that completes the issue.

Examples include `feat(tasks): add a task from its title`, `fix(tasks): keep the title on failed submission`, and `ci(checks): run the task integration tests`.

## Record milestones

The main coordinator records the issue and dispatch. The feature coordinator then owns status updates. Workers report evidence to that coordinator. Keep one current progress comment per active issue and link it from Handoff. Title it **Feature progress** so it can be found if the link is missing. Update it at these milestones and when a blocker changes.

| Milestone | What to record |
| --- | --- |
| Issue published or reused | Requirements revision, dependencies, and the next action. |
| Design dispatched | Branch, base ref, Orca session, and assigned write scope. |
| Design awaiting approval or revised | Exact architecture and test specification links and the pending decision. Record the user’s approval with the revisions it covers. |
| Implementation started or a slice verified | Current slice or covered criteria, verified commit link, check results, and next step. When blocked, identify the dependency or decision needed. |
| Draft PR opened or review advances | PR link, head commit, CI and independent review state, and blocking findings or fixes. |
| Merge verified | Merge reference, delivered scope, and any remaining work. Mark only completed issues done. |

Keep the approval and shared ownership records intact when updating progress. Read the current issue and its progress before resuming. Reuse its existing branch, PR, and progress comment. If the existing comment belongs to a different account, add a successor update and link it in Handoff. If an update fails or returns no receipt, read it back before retrying. If GitHub is unavailable, keep the evidence in the feature worktree and sync the latest state when access returns. For local-only work, keep the same milestones with the local spec or plan.

## Sync a linked GitHub Project

Use the project configured in the repo or already linked to the issue. If there is no explicit target, use the repository’s single linked project when it is unambiguous. Verify the target, issue membership, and existing status options. Let existing project automations handle transitions they cover. Add the issue once if it is missing, and update the applicable field when the stage changes. Use the board’s existing names for work in progress, review, blocked work, and done. Keep details in the issue when the board has no matching option.

Check whether project status options sync with issues or trigger closing automations before setting them. Choose a status that keeps open work open during implementation, review, and CI. Use a completion option only after verifying the issue is resolved by the merge. Verify the resulting project value and issue state. Keep issue progress current if the board is missing, ambiguous, or inaccessible. Report a pending sync for a known board and retry at the next milestone. [GitHub Project automation](https://docs.github.com/en/issues/planning-and-tracking-with-projects/automating-your-project/using-the-built-in-automations)

With GitHub CLI, resolve the owner and number of the verified project. Use `gh issue view --json projectItems` and `gh project field-list` to check membership and available options. Use `gh project item-add` with the issue URL if the item is missing. A current CLI accepts the project number, owner, issue URL, field, and existing option name for `gh project item-edit`. [GitHub CLI project item editing](https://cli.github.com/manual/gh_project_item-edit)
