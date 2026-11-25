---
name: design-and-test
description: Turn a settled feature issue into a small architecture proposal and test plan for review before implementation.
---

# Design and test

## Inspect the issue and checkout

- Read the verified issues, the settled requirements revision, and relevant glossary and architecture decisions, including any local documents named in the handoff. Use the confirmed terms in the plan and its test scenarios. Confirm which acceptance criteria apply. Use the recorded decisions to resolve older drafts. Surface a conflict when the available evidence leaves behavior unsettled.
- Inspect the actual checkout, including relevant local files, public interfaces, existing tests, and runnable checks. Reuse the project's working patterns. Draft the plan in this session or in the artifact authorized for review.

## Draft one reviewable plan

Use `templates/design-and-test.md` in Shamu or the project's equivalent. Give the proposal a specific revision. For a multi-ticket feature, identify which criteria and tests apply to each issue.

1. Describe current behavior and the proposed change. Name who owns each relevant piece of state or data, the interfaces callers use, and the responsibilities that change. Choose the smallest design that covers the criteria. Compare viable alternatives and record a trade-off when the choice is consequential.
2. Give each acceptance criterion a testable scenario with a setup, action, public verification surface, and expected result. Reuse existing public interfaces. Choose a unit check for a distinct rule, a component or integration test for behavior across boundaries, or a real browser, CLI, or API check when the behavior depends on that surface. Identify failures and edge cases that matter to the agreed scope.
3. Order tests as small behavior slices. Name the first focused check, why it should fail before implementation, and what will show it passes afterward. List the relevant commands and any test setup the proposal needs.
4. When a drawing would resolve a design question, use [diagram guidance](references/diagrams.md). Keep prose and the test matrix sufficient to understand the plan.

## Review and continue

Present the architecture and tests together for one human review. The same response can approve this revision and authorize recording the decision and starting work. If the user requests changes, revise the affected decisions and tests. After approval, record the decision in the plan or its issues as authorized and check readiness per issue. When implementation is authorized, take the first ready issue in the planned order and continue with `$test-first` in the assigned worktree.

Based on [Pocock's codebase design](https://github.com/mattpocock/skills/blob/main/skills/engineering/codebase-design/SKILL.md) and [Pstack's architecture guidance](https://github.com/cursor/plugins/blob/main/pstack/skills/architect/SKILL.md).
