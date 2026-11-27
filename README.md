# Shamu frontend skills

This branch contains an optional frontend toolkit for Codex and Antigravity. Install it from the project root for a flat app or from the package that owns the UI in a monorepo.

| Skill | Use it for |
| --- | --- |
| [Frontend visual design](skills/frontend-visual-design/SKILL.md) | Define a visual direction and build or polish a feature screen. |
| [Frontend UI review](skills/frontend-ui-review/SKILL.md) | Check a running feature for visual, keyboard, responsive, and state issues. |

## Install the toolkit

```powershell
gh skill install DuduRPP/shamu --all --pin frontend-skills-v0.1.0 --dir ./.optional-skills
gh skill list --dir ./.optional-skills
```

To install only the design skill, use its exact path.

```powershell
gh skill install DuduRPP/shamu 'skills/frontend-visual-design/SKILL.md@frontend-skills-v0.1.0' --dir ./.optional-skills
```

## Use a skill

> Develop Edit Task. Read `.optional-skills/frontend-visual-design/SKILL.md` for the UI design.

Start from the folder where you ran the install or include that folder in the path. If Orca delegates the feature to a new worktree, make the skill available there and give the frontend worker its repository-relative path. Install it there or include the selected files in the base commit.

The optional folder stays outside the standard skill discovery paths. Select each skill by path when you want it. For standing frontend instructions, adapt the [optional AGENTS.md template](templates/AGENTS.frontend.md) to your frontend package and merge it with the instructions already there.

[License](LICENSE)
