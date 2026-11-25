---
name: test-first
description: Implement approved features or regression fixes in test-first slices. Choose behavior-focused tests, use doubles at system boundaries, and report verification evidence.
---

# Test-first implementation

Read the relevant glossary and ADRs. For Shamu feature work, read the verified issue or local spec and the current approved design and test plan. Use the readiness check in `docs/workflow.md` and work within scope on the feature branch.

- Use [Matt Pocock's TDD skill](references/pocock/tdd.md) for public test boundaries and the red–green loop. The approved public test surfaces in Shamu's design plan are the agreed boundaries. Follow the [test examples](references/pocock/tests.md) and consult the [mocking guide](references/pocock/mocking.md) when replacing a collaborator.
- Keep the behavior under test and deterministic internal code real. Use a stub for a controlled response or error and a fake when the test needs state. Verify a call when the interaction itself is part of the contract, such as sending one notification after a successful action. Reset doubles between tests. Use a real boundary check when the accepted behavior depends on compatibility with the service.
- Use [Pstack's regression workflow](references/pstack/regression-tdd.md) for bug fixes. If a regression test is impractical and the plan permits an executable check, use the closest one and report its before-and-after evidence. Surface a material coverage change when the approved plan calls for a different check.
- Run the focused check before changing the behavior and confirm the expected failure. Diagnose broken setup separately. For behavior that already works, keep the passing check and move to the next missing behavior. Run the relevant project checks and direct verification in the plan after the changes.
- Record the criterion, failing check and reason, passing result, and any check that is pending. Use this evidence in the issue or pull request when authorized. Surface a specific choice if approved behavior or the test boundary needs a material change.

## Bundled upstream references

- The TDD skill and the test and mock guides are from Matt Pocock's skills v1.3.2. [Pinned source](https://github.com/mattpocock/skills/tree/d1478fcb140db0b93c0c8df17bcfd311844749d0/skills/engineering/tdd) · [License](references/pocock/LICENSE)
- The regression guide is from Lauren Tan's Pstack. [Pinned source](https://github.com/cursor/plugins/blob/41e400932eca14f289e7db717a70455256b6d388/pstack/skills/tdd/SKILL.md) · [License](references/pstack/LICENSE)
