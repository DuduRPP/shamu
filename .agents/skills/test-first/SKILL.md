---
name: test-first
description: Implement an approved feature or explicitly requested TDD task in small test-first slices and report verification evidence.
---

# Test-first implementation

For Shamu feature work, read the verified issue and current approved design and test plan, and check readiness in `docs/workflow.md`. Work within the approved scope in the assigned worktree.

1. Pick one acceptance criterion or small observable behavior from the plan. Add a focused test through the agreed public surface. Use behavior from the spec to establish the expected value.
2. Run that test before implementing the behavior. Confirm that the failure is the missing behavior. Fix broken setup separately. If the behavior already works, record the passing regression check and continue with the next missing behavior.
3. Make the smallest implementation that passes. Rerun the same test. Clean up within the slice while checks are green, then repeat for the next behavior.
4. Run the project checks and any direct verification from the plan. Record the criterion, failing check and reason, passing result, and any check that is pending. Use this evidence in the issue or pull request when authorized.

Follow the accepted plan for routine implementation decisions. Surface a specific decision if the approved behavior or test boundary needs a material change.

[Pocock's TDD skill](https://github.com/mattpocock/skills/blob/main/skills/engineering/tdd/SKILL.md) · [Pstack's TDD guidance](https://github.com/cursor/plugins/blob/main/pstack/skills/tdd/SKILL.md) · [Pstack's direct verification](https://github.com/cursor/plugins/blob/main/pstack/skills/principle-prove-it-works/SKILL.md)
