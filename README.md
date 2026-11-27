# Shamu frontend skills

Install a pinned set of upstream frontend skills into the folder that owns the UI. The default destination is `.optional-skills/`. From there, use a skill by asking the agent to read its `SKILL.md`. A regular feature prompt does not load the pack.

## Install

From the app root or the frontend package in a monorepo, download the release installer with an authenticated GitHub CLI that has `gh skill` support. The script installs skill folders. Individual skills may require runtimes or tools when used.

```powershell
$installer = Join-Path ([IO.Path]::GetTempPath()) 'shamu-frontend-skills-v0.2.0.ps1'
gh api -H 'Accept: application/vnd.github.raw+json' 'repos/DuduRPP/shamu/contents/install-frontend-skills.ps1?ref=frontend-skills-v0.2.0' > $installer
& $installer -List
& $installer
```

Install only the skills you choose by passing their names. Set `-Destination` to install in a different folder.

```powershell
& $installer -Skill frontend-design,webapp-testing
```

## Pick a skill

| Skill | Use it for |
| --- | --- |
| [Anthropic Frontend Design](https://github.com/anthropics/skills/tree/main/skills/frontend-design) | Design direction for a new screen. |
| [UI/UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | Searchable design-system recommendations. Its search tool uses Python. |
| [Impeccable](https://github.com/pbakaus/impeccable) | A scoped critique or polish pass. Use the installed skill folder as its base directory and the project's browser tools as needed. |
| [Vercel Web Design Guidelines](https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines) | Review source for accessibility, interaction, and responsive-layout issues. |
| [Anthropic Webapp Testing](https://github.com/anthropics/skills/tree/main/skills/webapp-testing) | Test a running app using Python Playwright. |
| [Emil Kowalski's skills](https://github.com/emilkowalski/skills) | Pick a UI library, test extreme inputs with `break-ui`, improve mobile interactions with `mobile-native`, or review motion with `review-animations`. |
| [PStack TypeScript Best Practices](https://github.com/cursor/plugins/tree/main/pstack/skills/typescript-best-practices) | Review TypeScript types and boundaries. The installer includes the companion `principle-type-system-discipline`. |
| [Vercel React Best Practices](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) | Review React rendering, data fetching, and performance. |

Start with one skill for the phase you are in. For example:

> Develop Edit Task. Use `.optional-skills/frontend-design/SKILL.md` for the visual direction, then use `.optional-skills/webapp-testing/SKILL.md` for browser verification.

For Orca, install in the feature worktree or make the selected skill folders available on its base. When selecting PStack TypeScript guidance, give the worker the paths to both the TypeScript skill and its companion principle. If you want standing frontend instructions, adapt the [optional AGENTS.md template](templates/AGENTS.frontend.md) to the package.

The installer pins each skill to a commit and fetches it directly from its upstream repository. The [Shamu license](LICENSE) covers this branch's original files. Upstream skills are governed by their own terms.
