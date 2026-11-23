# Repository instructions

## Working agreements

- Use the [feature workflow](docs/workflow.md) for changes to product behavior. Start with the issue and the documents it links.
- Work in the assigned branch or worktree. Preserve existing changes and keep the diff within the task's scope.
- Before feature implementation, complete the [issue readiness check](docs/workflow.md#check-readiness-before-implementation). Surface any pending approval or unresolved blocker before starting the affected work.
- Link the issue, relevant decisions, and verification results in the pull request. The human maintainer makes the merge decision.

## Verification

Run the relevant project checks and report the commands, results, and any checks still pending. For documentation changes, check edited links and run `git diff --check`.

When adopting this template, record the project's install, lint, test, and build commands here.
