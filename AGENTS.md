# Repository instructions

## Feature requests

- When asked to build, add, or implement a product feature, use the [feature workflow](docs/workflow.md). Resume matching work or start the [requirements interview](.agents/skills/grill-requirements/SKILL.md) from a request such as “Develop Create Task.”
- In the main conversation, coordinate the feature, publish its issues, and dispatch the design session in a dedicated Orca worktree. Return after Orca confirms delivery so the user can plan more work. Delegate product code changes to an implementation agent. A delegated session follows the role in its brief.
- A full feature request covers its issues, updates to the linked GitHub Project, feature worktree, worker sessions, and draft PR in the verified project repository. Implementation requires interactive approval of both the architecture and test specification. The human maintainer decides when to merge.
- Honor narrower requests such as a draft, design only, or local work.

## Working agreements

- Preserve existing changes. Keep each worktree within its assigned scope and check active work for shared dependencies or conflicting edits before implementation.
- Commit verified slices as work progresses. Use [Conventional Commits and feature progress](docs/progress.md) to keep the branch, issues, and linked Project current.
- Prefer small interfaces, clear ownership, and existing patterns. Add abstractions for a concrete need. Use comments for non-obvious reasoning or constraints.
- Apply the [writing skill](.agents/skills/unslop/SKILL.md) before sharing specs, architecture, tests, issues, PRs, or other documentation. Preserve confirmed decisions, exact requirements, and reviewer evidence.

## Verification

Run the project’s relevant checks. Use the [CI guide](docs/ci.md) to add missing checks to the existing pipeline or establish one. Require successful checks and independent review of the proposed commit before marking a PR ready.

When adopting this template, record the project's install and verification commands here.
