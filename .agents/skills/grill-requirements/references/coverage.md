# Requirements coverage

Start with the current code, specifications, glossary, and active work. Check these areas before settling scope. Ask about the ones that change what you would build or verify.

| Area | Decisions to resolve |
| --- | --- |
| App context and scope | Who uses the app, its goal, existing screens, accounts, and persistence. Confirm which app-wide decisions this feature depends on and what can wait. |
| Main flow and boundaries | Who acts, where they start, what changes, where they see the outcome, and which nearby behavior is deferred. |
| Inputs and state | Empty, invalid, duplicate and maximum inputs, editing and cancellation, permissions, repeated actions, and competing writes when applicable. |
| Errors and recovery | The user-visible message and preserved state on failure, partial success, safe retries, offline behavior, and rollback if relevant. |
| Dependencies and app-wide effects | Existing components and shared contracts, data ownership and compatibility, integrations, other feature dependencies, and constraints such as accessibility, privacy, or performance that change acceptance. |

Walk concrete examples with expected outcomes. For example, ask what happens when someone repeats an action after a timeout. If the answer depends on whether the first action took effect, settle how the user can see that and what retry should do.

Use later rounds for decisions that depend on earlier answers. Keep a few questions per round and continue until every material ambiguity is resolved or explicitly deferred.

On a starter todo app with no settled requirements, a Create Task interview could run like this:

1. App context. Ask whether the list is personal or shared, which fields a new task needs, and whether tasks survive a reload. For a first local version, recommend one personal list, a title, and session-only state if speed matters. Browser storage is a practical choice if continuity matters.
2. Creation flow. Based on those answers, ask what submits the form, where a new task appears, and what happens to the input and focus after a successful add. A reasonable starting point is a button and Enter, append at the bottom, then clear and refocus the input.
3. Validation and failures. Ask whether duplicate titles are allowed, and agree on the response to blank, whitespace-only, or over-limit titles. If saving can fail, settle what the person sees, what data is preserved, and how they retry. If tasks are only in memory, cover reset on reload and defer save failures.

Use the app's code and earlier answers to combine, replace, or omit decisions. For example, an existing title policy comes from the app unless the new feature needs to change it.

Record the main flow and relevant alternate outcomes as observable acceptance criteria. Use stated defaults for reversible details that do not change acceptance, and surface any consequential assumption before the issue is published.
