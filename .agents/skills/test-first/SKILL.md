---
name: test-first
description: Implement approved features or regression fixes in test-first slices. Choose behavior-focused tests, use doubles at system boundaries, and report verification evidence.
---

# Test-first implementation

Read the relevant glossary and ADRs. For Shamu feature work, check the recorded requirements, interactive approval of the current architecture and test specification, and the actual dependencies. Use the [readiness check](../../../docs/workflow.md#check-readiness-before-implementation) before making product changes. Stay within the assigned feature worktree and its edit scope.

- Use [Matt Pocock's TDD skill](references/pocock/tdd.md) for public test boundaries and the red–green loop. The approved public test surfaces in Shamu's design plan are the agreed boundaries. Follow the [test examples](references/pocock/tests.md) and consult the [mocking guide](references/pocock/mocking.md) when replacing a collaborator.
- Prefer unit tests for distinct rules and integration tests for behavior across interfaces. Use automated end-to-end tests for critical journeys where they cover a real browser, service, or deployment interaction that focused tests cannot prove. Test the expected behavior and failures from the approved specification.
- Keep the behavior under test and deterministic internal code real. Use a stub for a controlled response or error and a fake when the test needs state. Verify a call when the interaction itself is part of the contract, such as sending one notification after a successful action. Reset doubles between tests. Use a real boundary check when the accepted behavior depends on compatibility with the service.
- Use [Pstack's regression workflow](references/pstack/regression-tdd.md) for bug fixes. If a regression test is impractical and the plan permits an executable check, use the closest one and report its before-and-after evidence. Surface a material coverage change when the approved plan calls for a different check.
- Run the focused check before changing the behavior and confirm the expected failure. Diagnose broken setup separately. For behavior that already works, keep the passing check and move to the next missing behavior. Run the relevant project checks and direct verification in the plan after the changes.
- Reuse existing patterns and the [codebase design guidance](../codebase-design/SKILL.md). Keep the implementation simple and reserve comments for non-obvious reasoning. For UI work, run the planned exploratory scenarios in the Orca browser or the coding agent's browser and record what you observed. Use the [CI guide](../../../docs/ci.md) for the project’s checks.
- Follow the [commit convention](../../../docs/progress.md#commit-as-work-progresses) after each verified slice or review fix. Return the commit SHA and criteria covered, the failing-before and passing-after results, and any pending checks to the feature coordinator. Surface a specific choice if approved behavior or the test boundary needs a material change.

## Bundled upstream references

- The TDD skill and the test and mock guides are from Matt Pocock's skills v1.3.2. [Pinned source](https://github.com/mattpocock/skills/tree/d1478fcb140db0b93c0c8df17bcfd311844749d0/skills/engineering/tdd) · [License](references/pocock/LICENSE)
- The regression guide is from Lauren Tan's Pstack. [Pinned source](https://github.com/cursor/plugins/blob/41e400932eca14f289e7db717a70455256b6d388/pstack/skills/tdd/SKILL.md) · [License](references/pstack/LICENSE)
