# Run a feature in Orca

## Launch design in a worktree

Load `orca skills get orca-cli` with the executable for this host. For commands that carry message bodies on Windows, use the native `orca.exe` if the wrapper directs you to it. Verify the repo and choose a committed base containing the project and its workflow files. Use the project’s integration branch unless the feature has an agreed prerequisite or base. Include relevant requirements and domain decisions in the brief when they only exist in the current conversation or checkout.

Give the brief the verified issue URLs or a settled local spec, requirements revision, dependencies, assigned scope, the main coordinator’s Orca session address, and any feature-local glossary or decision-record updates. Assign [`$design-and-test`](../.agents/skills/design-and-test/SKILL.md). For a full feature, tell the designer to request approval in its own chat and coordinate implementation and review after approval. Use a fresh user-facing Chat UI session so the design approval can be answered on the phone.

Set `$featureName`, `$verifiedBaseRef`, `$designBrief`, and `$verifiedIssueUrls` before launch. Use an empty list for local work.

```powershell
$references = @()
foreach ($issueUrl in $verifiedIssueUrls) {
    $references += @('--reference', $issueUrl)
}
orca worktree create --name $featureName --no-parent --base-branch $verifiedBaseRef --agent codex --surface chat @references --prompt $designBrief --json
```

Confirm the new worktree and prompt delivery from the launch receipt. Report the branch and session, then return to the user. Resolve an uncertain result with the same operation ID or by inspecting the worktree and session per the CLI guide. Keep handoff pending if Orca is unavailable. Resume the existing session when retrying work already dispatched. [Orca CLI guide](https://github.com/stablyai/orca/blob/main/skill-guides/orca-cli.md#full-handoffs)

## Request interactive approval

The designer presents the architecture and test specification in the feature chat. Name the requirements revision, give both document links or show their full contents, and identify their exact revision. For remote review, use links addressed by commit SHA on the feature branch or publish the documents in the feature issue and link the exact version.

Call the structured user-input tool available in Orca Chat UI. Use `request_user_input` when offered, or `request_user_input_async` on a host that surfaces its choices. Ask one question with the actions **Approve both**, **Request changes**, and **Keep paused**. Allow detail through the tool’s free-text field or a follow-up structured question. End the turn after an asynchronous request. Orca recognizes the pending question and handles the attention notification on paired hosts with notifications enabled. [Orca Chat UI](https://orca.dev/docs/agents/native-chat) · [Orca notifications](https://orca.dev/docs/notifications)

Only an explicit human approval of the presented pair clears the gate. A displayed card, a default choice, dismissal, timeout, or unrelated reply leaves it pending. If the user requests changes, supersede the old question and open a new one for the revised pair. Apply answers only to the current question and its linked documents. If the session lacks a supported question tool, retain the pending state and direct the user to an Orca Chat UI session with structured questions or to Plan mode when it offers the blocking tool.

## Coordinate implementation and review

The feature designer starts supervised workers from its own Orca chat after approval. Orca uses that session’s identity for the coordinator. Load `orca skills get orchestration` and use its version-matched instructions, including the coordinator loop reference for multiple tasks. Keep one run for the feature. Use explicit run and worktree identifiers when resuming, with fresh briefs for each role.

1. Start the implementation worker in the feature worktree with `orchestration worker-start`. Keep one writer in a worktree at a time. Include the approval record, dependency status, allowed edits, and what evidence to return.
2. End the turn after dispatch. When Orca delivers `worker_done`, verify the returned evidence and commit SHA. Open or update the draft PR for GitHub work, or record evidence in the local worktree. Use a fresh worker for review with the pinned diff, assigned read-only scope, and links to the requirements and two approved documents.
3. Return blocking findings through `orchestration send --to dispatch:<dispatch_id>`. Orca continues a settled worker as a follow-up task on supported hosts. When the fix arrives, rerun relevant checks and request a fresh review of the new head. Record the reviewed head and verification in the PR or local worktree. Follow the CLI’s recovery guidance for unknown starts and incomplete workers. If the shell reports `runtime_access_denied`, use the runner’s permission request for that specific Orca command.

[Orca orchestration](https://orca.dev/docs/cli/orchestration)
