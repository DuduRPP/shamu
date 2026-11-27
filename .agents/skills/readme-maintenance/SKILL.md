---
name: readme-maintenance
description: Create or maintain an application's README when its user-visible behavior, setup, build, stack, or architectural decisions change.
---

# Maintain the application README

Check the README when a slice changes something a reader needs to know. Update affected sections in that slice, within the assigned write scope. If the root README is shared, send the exact change to the coordinator for the assigned owner. Before handoff, check that the README describes the delivered revision.

- Lead with the application title and one sentence explaining what it does and who uses it. Put a current screenshot or demo near the top when it helps someone understand the application. Use a readable viewport, sample data, and descriptive alt text. Prefer versioned repository assets with relative paths. Reuse a suitable screenshot from feature verification if it represents the application well. Text examples can serve the same purpose for a CLI or library.
- List the main features and relevant limits in a few bullets. Derive them from the working application and approved scope. Keep proposed features in their issue or roadmap.
- Make the first run easy to copy. Include prerequisites, install and launch commands, and any required configuration using sample values. Include build and verification commands when applicable. Check the manifest, lockfile, scripts, and CI. Name the directory if commands run from a subproject.
- Summarize the stack and decisions that help contributors orient themselves. Link to the architecture, decision records, and license using repository-relative paths. Keep detailed rationale and contribution steps in their existing documents.
- Add a small row of relevant badges. Link CI to the repository's actual workflow and coverage to a configured report. Verify the license against the tracked file. Omit badges that have no real source or do not render for the intended audience.
- Review the changed text against code and commands. Run the repository's link check when available. Inspect screenshots at their displayed size and replace ones that show stale behavior.

For an initial README or a larger redesign, see [LocalSend](https://github.com/localsend/localsend#readme) for screenshots and separated download and build instructions, [Excalidraw](https://github.com/excalidraw/excalidraw#readme) for a feature list and quick start tailored to its readers, and [Immich](https://github.com/immich-app/immich#readme) for linking out to detailed docs. [GitHub's README guide](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes) explains relative links. [GitHub's status badge guide](https://docs.github.com/en/actions/how-tos/monitor-workflows/add-a-status-badge) explains workflow and branch selection.
