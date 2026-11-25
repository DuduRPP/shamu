# Repository instructions

## Feature requests

- When asked to build, add, or implement a product feature, follow the [feature workflow](docs/workflow.md). Inspect the checkout and resume matching work from its current stage. For a new feature, start with the [requirements skill](.agents/skills/grill-requirements/SKILL.md). This applies to plain-language requests such as “Develop Create Task.”
- A full feature request covers creating or updating the feature's issues, starting its Orca design session, and pushing the feature branch and opening a draft PR in this checkout's verified GitHub repository. Start implementation when the specific design and test plan is approved and the work is ready. The human maintainer decides when to merge.
- Honor narrower requests such as a draft, design only, or local work.

## Working agreements
- Work in the assigned branch or worktree. Preserve existing changes and keep the diff within the task's scope.
- Before feature implementation, complete the [issue readiness check](docs/workflow.md#check-readiness-before-implementation). Surface any pending approval or unresolved blocker before starting the affected work.
- Link the issue, relevant decisions, and verification results in the pull request. The human maintainer makes the merge decision.

## Verification

Run the relevant project checks and report the commands, results, and any checks still pending. For documentation changes, check edited links and run `git diff --check`.

When adopting this template, record the project's install, lint, test, and build commands here.
