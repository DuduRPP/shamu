# Shamu frontend skills

Install the complete frontend toolkit from GitHub. Run this from the app root, or from the UI package in a monorepo.

```powershell
gh skill install DuduRPP/shamu --all --pin frontend-skills-v0.3.0 --dir ./.optional-skills
```

Ask the frontend worker to read the installed skill it needs. For example:

> Develop Edit Task. Use `.optional-skills/frontend-design/SKILL.md` for visual direction.

The optional directory keeps the skills out of normal discovery. In Orca, install in the feature worktree or ensure the skill files are available in its base. When using PStack's TypeScript guidance, pass the paths to both PStack skill files. For standing conventions, adapt the [optional frontend AGENTS.md template](templates/AGENTS.frontend.md).

## Included skills

| Skill | Pinned source |
| --- | --- |
| [frontend-design](skills/frontend-design/SKILL.md) | [`e4bb5d9`](https://github.com/anthropics/skills/tree/e4bb5d960d87126ff3b3a8af1a104b7db67560ba/skills/frontend-design) |
| [webapp-testing](skills/webapp-testing/SKILL.md) | [`e4bb5d9`](https://github.com/anthropics/skills/tree/e4bb5d960d87126ff3b3a8af1a104b7db67560ba/skills/webapp-testing) |
| [ui-ux-pro-max](skills/ui-ux-pro-max/SKILL.md) | [`11ca2b3`](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill/tree/11ca2b3bdd555649f278ee348c32a9302b24dcf1/.claude/skills/ui-ux-pro-max) |
| [impeccable](skills/impeccable/SKILL.md) | [`2fc5e14`](https://github.com/pbakaus/impeccable/tree/2fc5e1459efbbf06d92c7306517c286bf12490cf/.agents/skills/impeccable) |
| [pick-ui-library](skills/pick-ui-library/SKILL.md) | [`64eb3de`](https://github.com/emilkowalski/skills/tree/64eb3deb9a5fbfa041faf783e0bc3fd635872e9c/skills/pick-ui-library) |
| [break-ui](skills/break-ui/SKILL.md) | [`64eb3de`](https://github.com/emilkowalski/skills/tree/64eb3deb9a5fbfa041faf783e0bc3fd635872e9c/skills/break-ui) |
| [mobile-native](skills/mobile-native/SKILL.md) | [`64eb3de`](https://github.com/emilkowalski/skills/tree/64eb3deb9a5fbfa041faf783e0bc3fd635872e9c/skills/mobile-native) |
| [review-animations](skills/review-animations/SKILL.md) | [`64eb3de`](https://github.com/emilkowalski/skills/tree/64eb3deb9a5fbfa041faf783e0bc3fd635872e9c/skills/review-animations) |
| [typescript-best-practices](skills/typescript-best-practices/SKILL.md) | [`b7b93c3`](https://github.com/cursor/plugins/tree/b7b93c36be9bcc36a74db438e0fd385d660bc559/pstack/skills/typescript-best-practices) |
| [principle-type-system-discipline](skills/principle-type-system-discipline/SKILL.md) | [`b7b93c3`](https://github.com/cursor/plugins/tree/b7b93c36be9bcc36a74db438e0fd385d660bc559/pstack/skills/principle-type-system-discipline) |
| [vercel-react-best-practices](skills/vercel-react-best-practices/SKILL.md) | [`5a37a63`](https://github.com/vercel-labs/agent-skills/tree/5a37a6329fbad3666c3207392a6a7c0110e92efb/skills/react-best-practices) |
| [web-design-guidelines](skills/web-design-guidelines/SKILL.md) | [`53b6e3d`](https://github.com/vercel-labs/agent-skills/tree/53b6e3ddf96b3fa83af97b1783ed805b582ad3a7/skills/web-design-guidelines) |

Each skill folder retains its applicable license and notices. Shamu provides the Web Design Guidelines entrypoint around Vercel's MIT-licensed rules snapshot. Impeccable and UI/UX Pro Max include their upstream resources. Use the skill folder as the base for relative tool paths.

[License for Shamu files](LICENSE)
