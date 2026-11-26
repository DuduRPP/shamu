# Shamu

Shamu is a starter repository for agent-assisted development with Orca, Codex, and GitHub. Use Orca for agent sessions and Git worktrees. Keep issues, decisions, and verification evidence in GitHub so work can resume across sessions.

## Start a project

1. After the starter files are on Shamu's default branch, enable **Template repository** in GitHub settings. Use **Use this template** to create a project. [GitHub template guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository)
2. Record the project's conventions and verification commands in [agent instructions](AGENTS.md). Set up the required checks for the new repo. [CI setup](docs/ci.md)
3. Open the project in Orca. Start Codex at the project root using the requirements profile, then ask for a feature. [Model routing](AGENTS.md#model-routing)

> Develop Create Task.

Shamu interviews you, opens the issues, and starts a design session in a dedicated Orca worktree. Keep planning in the original session. Approve the architecture and test specification together in the feature’s interactive Orca question to start implementation. Shamu commits verified slices and updates the issues and linked Project as work progresses. Once the tests, CI, and independent review pass, review the PR before deciding whether to merge. [Feature workflow](docs/workflow.md) · [Feature progress](docs/progress.md)

To adopt Shamu in an existing repository, add the files in a pull request and merge the guidance into the project's existing instructions.

## Starter files

| File | Purpose |
| --- | --- |
| [Agent instructions](AGENTS.md) | Conventions, approval checkpoints, and project checks |
| [Feature workflow](docs/workflow.md) | The steps from requirements through merge, including how to resume work |
| [Design and test skill](.agents/skills/design-and-test/SKILL.md) | Architecture and test proposal generated in the design session |
| [Test-first skill](.agents/skills/test-first/SKILL.md) | Implementation and verification after plan approval |
| [Feature spec](templates/feature-spec.md) | Scope and observable acceptance criteria |
| [Architecture template](templates/architecture.md) and [test specification](templates/test-spec.md) | The pair of documents reviewed before implementation |
| [Orca coordination](docs/orca.md) | Background worktree launch, interactive approval, and independent review |
| [CI setup](docs/ci.md) | Starter check, project checks, and required GitHub status |
| [Review skill](.agents/skills/review-feature/SKILL.md) | Independent review of a specific diff |
| [GitHub issue template](.github/ISSUE_TEMPLATE/feature.md) | The task, dependencies, and links to decisions |
| [GitHub pull request template](.github/pull_request_template.md) | The change, verification results, and review notes |

## Install a skill

Run this from the folder that should own the skill, substituting the source repository and skill name.

```powershell
gh skill install OWNER/REPO SKILL-NAME --dir .\.agents\skills
```

Start Codex from that folder to use the skill. [GitHub CLI skill install](https://cli.github.com/manual/gh_skill_install) · [Codex skill discovery](https://learn.chatgpt.com/docs/build-skills)
