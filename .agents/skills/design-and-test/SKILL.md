---
name: design-and-test
description: Turn a settled feature issue into a small architecture proposal and test plan for review before implementation.
---

# Design and test

## Inspect the issue and checkout

- Read the verified issues or local spec, the settled requirements revision, and relevant glossary and architecture decisions, including any documents named in the handoff. Use the confirmed terms in the plan and its test scenarios. Confirm which acceptance criteria apply. Use the recorded decisions to resolve older drafts. Surface a conflict when the available evidence leaves behavior unsettled.
- Inspect the actual checkout, including relevant local files, public interfaces, existing tests, and available checks. Reuse the project's working patterns. Present the proposal from what you can verify. Include planned setup and checks in the proposal if they need installation or extra access.

## Draft one reviewable plan

Use `templates/design-and-test.md` in Shamu or the project's equivalent. Give the proposal a specific revision. For a multi-ticket feature, identify which criteria and tests apply to each issue.

1. Describe current behavior and the proposed change. Name who owns each relevant piece of state or data, the interfaces callers use, and the responsibilities that change. Choose the smallest design that covers the criteria. Compare viable alternatives and record a trade-off when the choice is consequential.
2. Give each acceptance criterion a testable scenario with a setup, action, public verification surface, and expected result. Reuse existing public interfaces. Choose a unit check for a distinct rule, a component or integration test for behavior across boundaries, or a real browser, CLI, or API check when the behavior depends on that surface. Identify failures and edge cases that matter to the agreed scope.
3. Order tests as small behavior slices. Name the first focused check, why it should fail before implementation, and what will show it passes afterward. List the relevant commands and any test setup the proposal needs.
4. When a drawing would resolve a design question, use [diagram guidance](references/diagrams.md). Keep prose and the test matrix sufficient to understand the plan.

## Review and continue

Present the architecture and tests together for one human review. Revise the affected decisions and tests if requested. For a full feature request, approval of the plan starts the next stage. Record the approved revision in the plan or issues, check readiness per slice, and take the first ready slice through `$test-first` and draft PR review using `docs/workflow.md`. For a standalone design request, deliver the proposal for review.

Based on [Pocock's codebase design](https://github.com/mattpocock/skills/blob/main/skills/engineering/codebase-design/SKILL.md) and [Pstack's architecture guidance](https://github.com/cursor/plugins/blob/main/pstack/skills/architect/SKILL.md).
