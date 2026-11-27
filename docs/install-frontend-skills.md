# Install the frontend skills

A request such as “Install frontend skills in `client/`” installs the full Shamu frontend pack into `client/.agents/skills/`. Run the install in the requested checkout, including the feature worktree when one is specified.

1. Resolve the requested folder relative to the project and check that it exists. If the user omits the folder, use the current frontend package when clear or the project root for a flat app. Ask for the folder only if multiple targets are plausible.
2. Run this from the selected folder with an authenticated GitHub CLI that supports `gh skill`.

```powershell
gh skill install DuduRPP/shamu --all --pin frontend-skills-v0.3.0 --dir ./.agents/skills
```

3. Verify the 12 skills from the tagged pack with `gh skill list --dir ./.agents/skills` from the same folder. Report the installed version and project-relative location. Keep existing skills and report any name conflicts.

Codex and Antigravity discover skills from the session's working folder and its parents up to the repo root. For a package install, start the frontend session in that package. Ask the agent to use the relevant skill by name, such as `frontend-design`. If more than one copy matches, give the path to the intended `SKILL.md`. [Pack contents and sources](https://github.com/DuduRPP/shamu/tree/frontend-skills)
