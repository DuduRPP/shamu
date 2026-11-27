---
name: design-and-test
description: Design a settled feature in its Orca worktree. Write separate architecture and test specifications, request interactive approval, then coordinate delivery for a full feature.
---

# Design and test

## Inspect the issue and worktree

- Read the settled requirements, existing architecture and test files, relevant glossary and decision records, and the feature’s dependencies and assigned scope. Apply confirmed domain updates within the assigned write scope. Use the project’s existing design and verification practices.
- Compare the expected write areas with active work. Send newly discovered shared edits to the main coordinator. Keep those changes in feature-local draft documents while the coordinator records ownership or sequencing. Apply a shared edit only after the coordinator assigns it to this feature.

## Write the two documents

1. Use the [architecture template](../../../templates/architecture.md) or the project’s equivalent. Start with a [Mermaid diagram](references/diagrams.md) of the key flow or ownership. Use short bullets for responsibilities, contracts, constraints, and trade-offs. Show app-wide effects separately and update shared architecture when its contracts or boundaries change and you own those files.
2. Design boundaries around behavior with distinct responsibilities or reasons to change. Keep UI composition, local interaction state, domain rules, and external access where they naturally belong. Reuse existing seams. Extract an interface when it makes useful behavior easier to change or verify. Consult [Pocock's design skill](../codebase-design/SKILL.md) when boundaries are hard to choose.
3. Use the [test specification template](../../../templates/test-spec.md) or the project’s equivalent. Map every criterion to public behavior with explicit setup, action, and expected outcome. Include relevant boundaries, error and recovery cases, and the state that must stay intact. Name the public component or module and the test location that owns each scenario. Prefer fast unit and integration tests. Reserve automated end-to-end tests for critical journeys that need a real system boundary. For a UI, include exploratory browser flows and visual checks.
4. Record the order of test-first slices, their expected first failures, and the project’s verification commands. Inspect existing CI and propose any required additions using the [CI guide](../../../docs/ci.md). Include setup and access requirements in the plan.
5. Apply [PStack’s writing skill](../unslop/SKILL.md). Give both documents a specific revision tied to the requirements. In the full GitHub workflow, link both from the issue with versioned links that can be opened remotely. Include the proposed changes to shared architecture in the review.

## Request approval and coordinate delivery

Call the [interactive approval gate](../../../docs/orca.md#request-interactive-approval) in this feature chat. A revision request leaves implementation paused. Update the affected documents and request approval of the new pair.

For a full feature request, record explicit approval of both current documents, then check [readiness](../../../docs/workflow.md#check-readiness-before-implementation). Update [feature progress](../../../docs/progress.md) as the gate and the workers advance. Delegate implementation to a separate worker. Coordinate its checks and independent review using the [Orca instructions](../../../docs/orca.md#coordinate-implementation-and-review). For a standalone design request, deliver the two artifacts for review within the requested scope.
