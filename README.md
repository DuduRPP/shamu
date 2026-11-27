# Shamu

Shamu is a starter repository for agent-assisted development with Orca, Codex, and GitHub. Use Orca for agent sessions and Git worktrees. Keep issues, decisions, and verification evidence in GitHub so work can resume across sessions.

## Start a project

1. After the starter files are on Shamu's default branch, enable **Template repository** in GitHub settings. Use **Use this template** to create a project. [GitHub template guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository)
2. Record the project's conventions and verification commands in [agent instructions](AGENTS.md). Set up the required checks for the new repo. [CI setup](docs/ci.md)
3. Open the project in Orca. Start Codex at the project root using the requirements profile, then ask for a feature. [Model routing](AGENTS.md#model-routing)

> Develop Create Task.

Shamu interviews you, opens the issues, and starts a design session in a dedicated Orca worktree. Keep planning in the original session. Approve the architecture and test specification together in the feature’s interactive Orca question to start implementation. Shamu commits verified slices and updates the issues and linked Project as work progresses. Once the tests, CI, and independent review pass, review the PR before deciding whether to merge. [Feature workflow](docs/workflow.md) · [Feature progress](docs/progress.md)

To adopt Shamu in an existing repository, add the files in a pull request and merge the guidance into the project's existing instructions.

## Workflow guides

- [Feature workflow](docs/workflow.md) for requirements, background worktrees, approvals, and review.
- [Architecture template](templates/architecture.md) and [test specification](templates/test-spec.md) for the two documents the maintainer approves.
- [Orca coordination](docs/orca.md) and [CI setup](docs/ci.md) to run the workflow in a new project.
- [README maintenance skill](.agents/skills/readme-maintenance/SKILL.md) for keeping setup, screenshots, and feature details current.

## License

[MIT](LICENSE)
