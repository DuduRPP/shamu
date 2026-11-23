# Feature workflow

This workflow uses one GitHub issue to connect the feature's approved scope, implementation, and review. Keep the documents proportionate to the size of the change.

## 1. Define and approve the feature

For a rough brief or unresolved product decision, use [`$grill-requirements`](../.agents/skills/grill-requirements/SKILL.md) to check existing project facts, ask decision questions, and draft the [feature spec](../templates/feature-spec.md). Clarify domain terms when their meaning changes behavior. Capture settled choices and leave open questions visible.

Have the human project owner approve the requirements revision before planning implementation. Then draft one task for a small feature or verifiable slices for larger work. Each draft identifies the outcome, acceptance criteria it covers, how to observe that outcome, and actual blocking dependencies.

Record approvals in a GitHub issue comment from the human decision maker or in a review on a documentation pull request. Identify the revision the decision covers.

### Publish task drafts to GitHub

1. Show the target repository in `OWNER/REPO` form and preview each exact issue title and body using the [feature issue template](../.github/ISSUE_TEMPLATE/feature.md). Include the approved spec revision, criteria, verification, and any blockers. Link the approval record when it is on GitHub. If the decision was made in chat, identify the approved revision in the issue and ask the human to record the approval in GitHub before implementation.
2. Wait for explicit authorization to publish the reviewed drafts to that repository. If the target, title, or body changes, show the revised preview and obtain authorization for it. Confirm the repository identity and that issues are enabled before creating anything.
3. Publish one issue at a time with your GitHub tool or CLI. Read each issue back and compare its repository, title, and body with the preview. Return the confirmed issue numbers and URLs.
4. If a request times out or the readback fails, check the returned URL first. If there is no URL, inspect recent open and closed issues in the target repository for the same task and approved spec revision. Reuse a confirmed match. Report any uncertain result and resolve it before attempting another create. For a batch, retain the links already confirmed.

With GitHub CLI, set `$issueRepo` to the approved repository and `$issueTitle` to the approved title. Write the exact approved body to a temporary file and set `$approvedIssueBodyFile` to its path. Run this for each authorized draft.

```powershell
$issueUrl = gh issue create --repo $issueRepo --title $issueTitle --body-file $approvedIssueBodyFile
if ($LASTEXITCODE -ne 0 -or -not $issueUrl) {
    throw 'Issue creation could not be confirmed. Check GitHub before retrying.'
}
Write-Output $issueUrl
gh issue view $issueUrl --repo $issueRepo --json 'number,url,title,body'
if ($LASTEXITCODE -ne 0) {
    throw 'Check the returned issue URL before retrying.'
}
```

Check the JSON against the preview and keep the URL with the task. [GitHub CLI issue creation](https://cli.github.com/manual/gh_issue_create) · [GitHub CLI issue readback](https://cli.github.com/manual/gh_issue_view)

## 2. Agree on the design and tests

Use the [design and test plan](../templates/design-and-test.md) to identify the affected parts of the project and map acceptance criteria to test scenarios. Identify where each important behavior is observable, such as a browser interaction, API response, or CLI result. Include the commands or manual checks that will verify the change. Ask for human approval of the plan before implementation. If a change revises approved behavior or test expectations, record approval for the affected revision before proceeding with that part.

## 3. Implement in a worktree

Start an Orca session in an assigned worktree. Give Codex the issue and its approved documents. For behavior covered by automated tests, write the tests first and confirm they fail for the expected reason. Implement the feature, rerun the tests, and run the project's relevant checks.

## 4. Review and merge

Open a draft pull request using the [pull request template](../.github/pull_request_template.md). Link the issue and decisions and report what passed or needs follow-up. Give a fresh review session the approved requirements revision, the exact diff, and verification results for the code under review. Ask for findings tied to requirements, regressions, or missing evidence. Resolve findings and rerun affected checks. The human maintainer decides when to merge and verifies that the issue reflects the outcome.

## Resume work

Start a fresh session with the issue link. The issue should point to the current approved revisions, the active branch or pull request, and any blocker. If work is interrupted, record the latest verification result and the next action so the session can continue from GitHub.
