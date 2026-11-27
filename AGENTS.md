# Repository instructions

## Feature requests

- When asked to build, add, or implement a product feature, use the [feature workflow](docs/workflow.md). Resume matching work or start the [requirements interview](.agents/skills/grill-requirements/SKILL.md) from a request such as “Develop Create Task.”
- In the main conversation, coordinate the feature, publish its issues, and dispatch the design session in a dedicated Orca worktree. Return after Orca confirms delivery so the user can plan more work. Delegate product code changes to an implementation agent. A delegated session follows the role in its brief.
- A full feature request covers its issues, updates to the linked GitHub Project, feature worktree, worker sessions, and a PR marked ready for maintainer review in the verified project repository. Implementation requires interactive approval of both the architecture and test specification. The human maintainer decides when to merge.
- Honor narrower requests such as a draft, design only, or local work.

## Frontend skills

When the user asks to install frontend skills, follow the [pack install guide](docs/install-frontend-skills.md) in the requested folder and checkout. Install on request only.

## Working agreements

- Preserve existing changes. Keep each worktree within its assigned scope and check active work for shared dependencies or conflicting edits before implementation.
- Make routine, reversible decisions within the settled scope and continue to the next workflow checkpoint. Use the [human input rules](docs/workflow.md#when-to-ask-the-user) for decisions reserved for the user and blockers that require their action.
- Commit verified slices as work progresses. Use [Conventional Commits and feature progress](docs/progress.md) to keep the branch, issues, and linked Project current.
- Prefer small interfaces, clear ownership, and existing patterns. Add abstractions for a concrete need. Use comments for non-obvious reasoning or constraints.
- Read the instructions for your stage and follow links as needed. Reuse [recorded decisions and verification](docs/workflow.md#reuse-feature-context).
- Use the [writing skill](.agents/skills/unslop/SKILL.md) when editing project artifacts. Reuse it during the session.

## Model routing

Use these defaults for feature work. Apply any model choices the project or user has already specified.

| Stage | Orca agent | Model ID | Effort |
| --- | --- | --- | --- |
| Requirements and coordination | codex | `gpt-6.2-sol` | low |
| Architecture, tests, and approval | codex | `gpt-6.2-sol` | low for contained features, medium otherwise |
| Frontend-only implementation | antigravity | `gemini-4-hydrogen-low` | Set by model ID |
| Other implementation | codex | `gpt-6.2-sol` | low for contained slices, medium otherwise |
| Independent review | codex | `gpt-6.2-sol` | low for contained diffs, medium otherwise |

Use [Orca launch arguments](docs/orca.md#select-an-agent-for-the-stage) for workers. Choose effort by scope, then raise it for a concrete difficulty. Use the requirements profile for the main session.

## Verification

Run the project’s relevant checks. Use the [CI guide](docs/ci.md) to add missing checks to the existing pipeline or establish one. Require successful checks and independent review of the proposed commit before marking a PR ready.

When adopting this template, record the project's install and verification commands here.
