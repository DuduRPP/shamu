# Shamu

Shamu is a starter repository for agent-assisted development with Orca, Codex, and GitHub. Use Orca for agent sessions and Git worktrees. Keep issues, decisions, and verification evidence in GitHub so work can resume across sessions.

## Start a project

1. After the starter files are on Shamu's default branch, enable **Template repository** in GitHub settings. Use **Use this template** to create a project. [GitHub template guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository)
2. Update the project's [agent instructions](AGENTS.md) with its conventions and verification commands. Configure CI to run the project's checks.
3. Open the project in Orca, start Codex at the project root, and ask for a feature.

> Develop Create Task.

Shamu guides you through the requirements, opens the issues, and hands off to a design session. Approve the design and test plan there to start test-first implementation. Review the draft PR before deciding whether to merge. [Feature workflow](docs/workflow.md)

To adopt Shamu in an existing repository, add the files in a pull request and merge the guidance into the project's existing instructions.

## Starter files

| File | Purpose |
| --- | --- |
| [Agent instructions](AGENTS.md) | Conventions, approval checkpoints, and project checks |
| [Feature workflow](docs/workflow.md) | The steps from requirements through merge, including how to resume work |
| [Design and test skill](.agents/skills/design-and-test/SKILL.md) | Architecture and test proposal generated in the design session |
| [Test-first skill](.agents/skills/test-first/SKILL.md) | Implementation and verification after plan approval |
| [Feature spec](templates/feature-spec.md) | Scope and observable acceptance criteria |
| [Design and test plan](templates/design-and-test.md) | Proposed changes and verification scenarios |
| [GitHub issue template](.github/ISSUE_TEMPLATE/feature.md) | The task, dependencies, and links to decisions |
| [GitHub pull request template](.github/pull_request_template.md) | The change, verification results, and review notes |

## Install a skill

Run this from the folder that should own the skill, substituting the source repository and skill name.

```powershell
gh skill install OWNER/REPO SKILL-NAME --dir .\.agents\skills
```

Start Codex from that folder to use the skill. [GitHub CLI skill install](https://cli.github.com/manual/gh_skill_install) · [Codex skill discovery](https://learn.chatgpt.com/docs/build-skills)
