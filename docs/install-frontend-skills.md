# Install the frontend skills

A request such as “Install frontend skills in `client/`” installs the whole Shamu frontend pack in that package. Run the install in the requested checkout, including the feature worktree when one is specified.

1. Resolve the requested folder relative to the project and check that it exists. If the user omits the folder, use the current frontend package when clear or the project root for a flat app. Ask for the folder only if multiple targets are plausible.
2. Run this from the selected folder with an authenticated GitHub CLI that supports `gh skill`.

```powershell
gh skill install DuduRPP/shamu --all --pin frontend-skills-v0.3.0 --dir ./.optional-skills
```

3. Run `gh skill list --dir ./.optional-skills` from the same folder. Report the installed version and project-relative location. The tagged pack contains 12 skills. If installation reports an existing-file conflict, retain the existing copy and identify the conflict.

The install keeps the pack outside the normal discovery paths. To use a skill, ask the relevant frontend worker to read its installed `SKILL.md`. For example, for an install in `client/`, ask it to use `client/.optional-skills/frontend-design/SKILL.md` for visual direction. [Pack contents and sources](https://github.com/DuduRPP/shamu/tree/frontend-skills-v0.3.0)
