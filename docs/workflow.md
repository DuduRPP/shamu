# Feature workflow

This workflow uses one GitHub issue to connect the feature's approved scope, implementation, and review. Keep the documents proportionate to the size of the change.

## 1. Define and approve the feature

Use the [feature spec](../templates/feature-spec.md) to capture the goal, scope, and observable acceptance criteria. Have the human project owner approve the requirements before planning implementation. Link the approved revision and decision from the [feature issue](../.github/ISSUE_TEMPLATE/feature.md), along with dependencies and any unresolved questions.

Record approvals in a GitHub issue comment from the human decision maker or in a review on a documentation pull request. Identify the revision the decision covers.

## 2. Agree on the design and tests

Use the [design and test plan](../templates/design-and-test.md) to identify the affected parts of the project and map acceptance criteria to test scenarios. Include the commands or manual checks that will verify the change. Ask for human approval of the plan before implementation. If a change revises approved behavior or test expectations, record approval for the affected revision before proceeding with that part.

## 3. Implement in a worktree

Start an Orca session in an assigned worktree. Give Codex the issue and its approved documents. For behavior covered by automated tests, write the tests first and confirm they fail for the expected reason. Implement the feature, rerun the tests, and run the project's relevant checks.

## 4. Review and merge

Open a draft pull request using the [pull request template](../.github/pull_request_template.md). Link the issue and decisions and report what passed or needs follow-up. Ask a fresh review session to compare the diff against the requirements, test coverage, and CI results. Resolve findings and rerun affected checks. The human maintainer decides when to merge and verifies that the issue reflects the outcome.

## Resume work

Start a fresh session with the issue link. The issue should point to the current approved revisions, the active branch or pull request, and any blocker. If work is interrupted, record the latest verification result and the next action so the session can continue from GitHub.
