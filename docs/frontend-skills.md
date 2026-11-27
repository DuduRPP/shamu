# Optional frontend skills

Choose a skill for a specific frontend task. Shamu loads the selected skill in the existing design or implementation session and uses the same browser verification and independent review.

| Need | Skill |
| --- | --- |
| Design a new screen or feature | [Anthropic Frontend Design](https://github.com/anthropics/skills/tree/41bbe19d1a1a7eaab5e7bb9050a417e5c6cffc8f/skills/frontend-design) for visual direction, typography, and composition |
| Improve an existing interface | [Impeccable](https://github.com/pbakaus/impeccable/tree/ab14427c899d65a2c0c198f1a05e0eb57d153c30/.agents/skills/impeccable) for a focused critique or polish pass |
| Audit accessibility and interaction details | [Vercel Web Design Guidelines](https://github.com/vercel-labs/agent-skills/tree/53b6e3ddf96b3fa83af97b1783ed805b582ad3a7/skills/web-design-guidelines) for actionable findings |

## Discover and install one skill

Run the commands from the folder that owns the UI. Use the project root for a flat app or the frontend package folder in a monorepo. Choose the source and review its instructions and helper files. This example installs the Anthropic skill at a pinned revision.

```powershell
gh skill search frontend-design --limit 5
$source = 'anthropics/skills'
$skill = 'skills/frontend-design/SKILL.md@41bbe19d1a1a7eaab5e7bb9050a417e5c6cffc8f'
gh skill preview $source $skill
gh skill install $source $skill --dir ./.optional-skills
```

Use the same commands with another approved source and its exact skill path and revision. For Impeccable, use `pbakaus/impeccable` and `.agents/skills/impeccable/SKILL.md@ab14427c899d65a2c0c198f1a05e0eb57d153c30`. Add `--allow-hidden-dirs` to preview and install it. Use the skill folder and a specific action such as `polish` or `critique`. Skip the full plugin installation and live mode for this workflow.

Keep optional installs in `.optional-skills/`, outside automatic discovery by Codex and Antigravity. For worktree launches, make the selected folder available in the feature checkout. An install in the main working directory is local to that checkout until you commit it to an agreed base or install it in the feature checkout as well.

## Enable it for a feature

> Develop Edit Task. Use `.optional-skills/frontend-design/SKILL.md` for the UI.

The coordinator includes the selected file path in the relevant UI brief. The design or implementation agent reads that file and the references it needs, then applies it within the approved scope. A feature without an explicit selection uses the project's existing design conventions. If the user explicitly selects an already installed skill, pass its resolved name or path.

Keep the visual brief short. Record who uses the screen, their primary action, the existing visual system or chosen direction, and which responsive, empty, or error states to verify. Reuse the browser check and [PR screenshots](workflow.md#hand-off-for-maintainer-review).

[GitHub CLI skill commands](https://cli.github.com/manual/gh_skill) · [Codex skill discovery](https://learn.chatgpt.com/docs/build-skills) · [Antigravity skills](https://antigravity.google/docs/skills)
