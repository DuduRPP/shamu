# Requirements coverage

Start with the current code, specifications, glossary, and active work. Check these areas before settling scope. Ask about the ones that change what you would build or verify.

| Area | Decisions to resolve |
| --- | --- |
| Main flow and boundaries | Who acts, where they start, what changes, where they see the outcome, and which nearby behavior is deferred. |
| Inputs and state | Empty, invalid, duplicate and maximum inputs, editing and cancellation, permissions, repeated actions, and competing writes when applicable. |
| Errors and recovery | The user-visible message and preserved state on failure, partial success, safe retries, offline behavior, and rollback if relevant. |
| Dependencies and app-wide effects | Existing components and shared contracts, data ownership and compatibility, integrations, other feature dependencies, and constraints such as accessibility, privacy, or performance that change acceptance. |

Walk concrete examples with expected outcomes. For example, ask what happens when someone repeats an action after a timeout. If the answer depends on whether the first action took effect, settle how the user can see that and what retry should do.

Use later rounds for decisions that depend on earlier answers. Keep a few questions per round and continue until every material ambiguity is resolved or explicitly deferred. Record the main flow and relevant alternate outcomes as observable acceptance criteria. Use stated defaults for reversible details that do not change acceptance, and surface any consequential assumption before the issue is published.
