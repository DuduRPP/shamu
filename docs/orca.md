# Run a feature in Orca

## Select an agent for the stage

Use the [model routing table](../AGENTS.md#model-routing) to set `$stageAgent`, `$stageModel`, and `$stageEffort` for the stage you are about to launch. Pick the main session's model and effort in Orca when starting the feature interview. Set `$stageEffort` to an empty string when the model ID includes the effort, as it does for the Antigravity profiles.

A contained change has clear acceptance criteria, few affected modules, and no shared contract, migration, or concurrency risk. Use the frontend profile for UI-only slices. Raise it to `gemini-4-hydrogen-medium` for complex interactions or async state. Route shared domain rules, APIs, storage, and backend changes to Codex. Increase effort when the evidence reveals a hard problem or verification repeatedly fails for an unresolved reason. For consequential design decisions, use Sol Max or Neon High if the host supports the model and [design approval](#request-interactive-approval). Reuse work and evidence when escalating.

Check available agents with `orca agent installed --json` and use the model ID offered by the agent on the execution host. Antigravity lists its IDs with `agy models`. If Antigravity is unavailable for a frontend slice, use the Codex implementation profile. If a listed Codex model is unavailable, use the host's available Codex default and omit the model and effort overrides. In any fallback, check the original launch outcome before starting a replacement. Record the model and effort actually used in the handoff or review evidence. [Orca worker options](https://orca.dev/docs/cli/orchestration)

```powershell
$stageArgs = @('--agent', $stageAgent)
if ($stageModel) {
    $stageArgs += @('--model', $stageModel)
    if ($stageEffort) {
        $stageArgs += @('--effort', $stageEffort)
    }
}
```

## Run the requirements interview

Start the interview in Orca's Codex Chat UI. Use the question tool exposed in that session. If the tool is unavailable or its card fails to open, resume from the unanswered decisions in a Codex Chat UI session that exposes it. In Orca, choose `/plan` for the interview if you need the blocking question tool and it is available there. Return to Build before the GitHub and worktree handoff for a full feature. [Orca Chat UI](https://orca.dev/docs/agents/native-chat)

## Launch design in a worktree

Load `orca skills get orca-cli` with the executable for this host once per active session and reuse the version-matched guide. For commands that carry message bodies on Windows, use the native `orca.exe` if the wrapper directs you to it. Verify the repo and choose a committed base containing the project and its workflow files. Use the project’s integration branch unless the feature has an agreed prerequisite or base. Include exact decisions in the brief if the feature session cannot read them from the shared records.

Give the brief the verified issue URLs or a settled local spec, requirements revision, dependencies, assigned scope, the main coordinator’s Orca session address, and any feature-local glossary or decision-record updates. Assign [`$design-and-test`](../.agents/skills/design-and-test/SKILL.md). For a full feature, tell the designer to request approval in its own chat and coordinate implementation and review after approval. Use a fresh user-facing Chat UI session so the design approval can be answered on the phone.

Set `$featureName`, `$verifiedBaseRef`, `$designBrief`, and `$verifiedIssueUrls` before launch. Use an empty list for local work. Build `$stageArgs` for the design stage.

```powershell
$references = @()
foreach ($issueUrl in $verifiedIssueUrls) {
    $references += @('--reference', $issueUrl)
}
orca worktree create --name $featureName --no-parent --base-branch $verifiedBaseRef @stageArgs --surface chat @references --prompt $designBrief --json
```

Confirm the new worktree and prompt delivery from the launch receipt. Report the branch and session, then return to the user. Resolve an uncertain result with the same operation ID or by inspecting the worktree and session per the CLI guide. Keep handoff pending if Orca is unavailable. Resume the existing session when retrying work already dispatched. [Orca CLI guide](https://github.com/stablyai/orca/blob/main/skill-guides/orca-cli.md#full-handoffs)

## Ask for human input

At a workflow checkpoint or when a decision meets the [human input rules](workflow.md#when-to-ask-the-user), use `request_user_input` or `request_user_input_async` in the user-facing feature chat. Give the decision, the recommended option, and what it changes. After an asynchronous call, yield the turn and wait for the submitted answer. If the tool is unavailable, route the request to the coordinator or resume in a supported chat. Keep the affected step pending and report the tool blocker if neither is possible.

## Request interactive approval

The designer presents the architecture and test specification in the feature chat. Name the requirements revision, give both document links or show their full contents, and identify their exact revision. For remote review, use links addressed by commit SHA on the feature branch or publish the documents in the feature issue and link the exact version.

Call the structured user-input tool available in Orca Chat UI. Use `request_user_input` when offered, or `request_user_input_async` on a host that surfaces its choices. Ask one question with the actions **Approve both**, **Request changes**, and **Keep paused**. Allow detail through the tool’s free-text field or a follow-up structured question. End the turn after an asynchronous request. Orca recognizes the pending question and handles the attention notification on paired hosts with notifications enabled. [Orca Chat UI](https://orca.dev/docs/agents/native-chat) · [Orca notifications](https://orca.dev/docs/notifications)

Only an explicit human approval of the presented pair clears the gate. A displayed card, a default choice, dismissal, timeout, or unrelated reply leaves it pending. If the user requests changes, supersede the old question and open a new one for the revised pair. Apply answers only to the current question and its linked documents. If the session lacks a supported question tool, retain the pending state and direct the user to an Orca Chat UI session with structured questions or to Plan mode when it offers the blocking tool.

## Coordinate implementation and review

The feature designer starts supervised workers from its own Orca chat after approval. Orca uses that session’s identity for the coordinator. Load `orca skills get orchestration` once in the coordinating session. Use its coordinator loop reference when needed for multiple tasks. Keep one run for the feature. Use explicit run and worktree identifiers when resuming, with fresh briefs for each role.

1. Dispatch one ready slice at a time in the feature worktree. Pick the implementation profile based on the approved slice and rebuild `$stageArgs`. Use the [package-scoped launch steps](#choose-the-workers-starting-folder) for the implementer and reviewer. Keep one writer in a worktree at a time. Use the [brief and receipt fields](workflow.md#reuse-feature-context). Tell the worker to resolve routine decisions within that scope and route any decision requiring human input back to the feature coordinator.
2. End the turn after dispatch. When Orca delivers `worker_done`, verify the evidence and commit SHA. In the full GitHub workflow, the coordinator pushes the verified commit, opens or updates the draft PR, and updates [feature progress](progress.md#record-milestones). For local work, record evidence in the worktree. Check readiness for the next slice.
3. Once the proposed scope is ready for review, rebuild `$stageArgs` for the review stage. Start a fresh reviewer with the pinned diff, read-only scope, and links to the requirements and both approved documents.
4. Return blocking findings through `orchestration send --to dispatch:<dispatch_id>`. Orca continues a settled worker as a follow-up task on supported hosts. Verify and publish each fix using the same receipt process. Run the affected checks. Give a fresh reviewer the new head, the last verified baseline, open findings, the fix diff, and current evidence. Expand the review if scope or behavior changed. Record the findings, fix commits, reviewed head, and verification in the PR and issue progress, or in the local worktree. Follow the CLI’s recovery guidance for unknown starts and incomplete workers. If the shell reports `runtime_access_denied`, use the runner’s permission request for that specific Orca command.

After review clears the current head and required checks pass, the feature coordinator completes the [GitHub handoff](workflow.md#hand-off-for-maintainer-review) before ending the run.

### Choose the worker’s starting folder

Choose the narrowest existing package or service root that owns the worker’s assigned work and checks. Use the project’s package layout and commands to identify it. Examples include `client/`, `server/`, or `services/scraper/`. Use the feature worktree root for a flat repo, shared changes, or work spanning packages. Keep the user-facing design and coordination session at the worktree root.

Record the repo-relative folder in the brief alongside the allowed edit paths. Resolve it in the feature worktree on the execution host. Check that it exists under that checkout and that `git -C <folder> rev-parse --show-toplevel` resolves to the same feature worktree. Use the package’s own commands and instructions. Have the worker verify its startup directory and Git root before editing. Include the directory in its completion receipt and report a placement mismatch before doing work.

Codex and Antigravity discover `.agents/skills/` and applicable `AGENTS.md` files in the package and its ancestors up to the repo root. A sibling package’s skills stay outside automatic discovery. Ensure any selected package skills are present in this feature checkout before launch. [Codex skill discovery](https://learn.chatgpt.com/docs/build-skills#where-codex-loads-local-skills) · [Antigravity discovery](https://antigravity.google/docs/customization-discovery#workspace-folders-and-parent-directories)

### Launch the supervised worker

For a new task, use the brief’s absolute path in `$workerBriefPath` and set `$taskTitle`. For an existing task, use `$taskArgs = @('--task', $taskId)` instead. Use a selector verified against the feature checkout. For a launch at the selected workspace’s root, use the native command.

```powershell
$taskArgs = @('--spec-file', $workerBriefPath, '--task-title', $taskTitle)
orca orchestration worker-start --worktree $worktreeSelector @stageArgs @taskArgs --json
```

For a nested folder, use a working-directory option only when the version-matched Orca CLI documents it. On hosts where `worker-start` selects the checkout only, create a dedicated terminal **in that feature worktree**, start the agent CLI from the verified package folder, then attach it to the same run. Load the orchestration guide’s low-level topology reference for this path. The `--terminal` start uses the agent already running, so apply the model and effort at CLI launch.

For a Windows host, use the exact `$worktreeSelector` for the feature worktree and set `$workerPath` to the verified absolute package root, `$agentExe` to the configured executable, and `$agentArgs` to its launch arguments with the selected profile. Codex accepts `--model <id>` and `-c model_reasoning_effort=<level>`. Antigravity’s `agy` accepts `--model <id>` and supports `--effort <level>` on hosts that advertise it. Use the configured agent account, environment, and permissions. If the host cannot reproduce those in a dedicated terminal, report the launch constraint. Use the same `$taskArgs` as above.

```powershell
$quoteArg = { param($value) "'" + ($value -replace "['\u2018\u2019]", '$0$0') + "'" }
$invokeAgent = ((@($agentExe) + $agentArgs) | ForEach-Object { & $quoteArg $_ }) -join ' '
$startup = "& { Set-Location -LiteralPath $(& $quoteArg $workerPath) -ErrorAction Stop; & $invokeAgent }"
$created = orca terminal create --worktree $worktreeSelector --shell powershell.exe --title $taskTitle --command $startup --json
if ($LASTEXITCODE -ne 0) { throw ($created -join "`n") }
$terminalHandle = ($created | ConvertFrom-Json).result.terminal.handle
if (-not $terminalHandle) { throw 'Inspect the launch receipt before retrying' }

$ready = orca terminal wait --terminal $terminalHandle --for tui-idle --timeout-ms 45000 --json
if ($LASTEXITCODE -ne 0) { throw ($ready -join "`n") }
orca terminal read --terminal $terminalHandle --screen --json
```

Confirm that the dedicated terminal shows the selected agent ready for a prompt. Then attach it using the terminal handle from the launch receipt.

```powershell
orca orchestration worker-start --terminal $terminalHandle @taskArgs --json
```

On a POSIX host, use the same terminal and attachment steps with a literal-path-quoted `cd <package> && exec <agent with arguments>` startup command and the host’s shell. If startup or attachment is uncertain, inspect the exact terminal or dispatch and follow Orca’s recovery guidance before retrying. Keep the verified worktree and folder when sending a follow-up or starting its replacement.

[Orca orchestration](https://orca.dev/docs/cli/orchestration)
