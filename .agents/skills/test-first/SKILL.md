---
name: test-first
description: Implement approved features or regression fixes in test-first slices. Choose behavior-focused tests, use doubles at system boundaries, and report verification evidence.
---

# Test-first implementation

For Shamu feature work, read the verified issue and current approved design and test plan, and check readiness in `docs/workflow.md`. Use the public test surfaces already approved in the plan. Work within scope in the assigned worktree.

## Choose the checks

- Use [Pocock's test guide](references/pocock/tests.md) before the first slice. Exercise production entry points and use expected results from the spec or an independent example. Name the behavior and check outcomes that should survive an internal refactor. Give each test one behavior to prove, with the assertions that make its outcome clear.
- Read [Pocock's mocking guide](references/pocock/mocking.md) when a test needs to replace a collaborator. Keep the behavior under test and deterministic internal code real. Prefer existing system boundaries for controlling things such as time, randomness, or an external service.
- Choose the smallest useful double. Use a stub for a controlled response or error and a fake when the test needs meaningful state. Verify a call when the interaction itself is part of the contract, such as sending one notification after success or sending none after rejection. Use realistic inputs and responses, and reset the double between tests. Use a real boundary check when compatibility with the actual service is part of the accepted behavior.
- Use [Pstack's regression workflow](references/pstack/regression-tdd.md) for bug fixes. Prefer a focused reproduction that proves the actual failure. If a regression test is impractical and the plan permits an executable check, use the closest one and report its before-and-after evidence. Surface a material coverage change when the approved plan calls for a different check.

## Run one behavior at a time

1. Pick one acceptance criterion or small observable behavior. Add the focused check through the agreed public surface.
2. Run it before implementing the behavior. Confirm the expected behavior is missing. Diagnose broken setup separately. For behavior that already works, keep the passing regression check and continue with the next missing behavior.
3. Make the smallest change that passes and rerun the same check. Keep cleanup within the slice while checks are green, then move to the next behavior.
4. Run the relevant project checks and any direct verification in the plan. Record the criterion, failing check and reason, passing result, and any check that is pending. Use this evidence in the issue or pull request when authorized.

Follow the accepted plan for routine test and implementation decisions. Surface a specific choice if approved behavior or the test boundary needs a material change.

## Bundled upstream references

- The test and mock guides are from Matt Pocock's skills v1.3.2. [Pinned source](https://github.com/mattpocock/skills/tree/d1478fcb140db0b93c0c8df17bcfd311844749d0/skills/engineering/tdd) · [License](references/pocock/LICENSE)
- The regression guide is from Lauren Tan's Pstack. [Pinned source](https://github.com/cursor/plugins/blob/41e400932eca14f289e7db717a70455256b6d388/pstack/skills/tdd/SKILL.md) · [License](references/pstack/LICENSE)
