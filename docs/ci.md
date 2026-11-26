# Continuous integration

Look for existing workflows and required checks before changing CI. Extend the current pipeline with missing verification. For a new project, use the [starter workflow](../.github/workflows/ci.yml) and add the app’s checks to it. The template itself checks patch whitespace and local documentation links.

- Read the lockfile, build files, and project instructions. Install dependencies reproducibly and run the same commands in CI that developers run locally. Include the applicable build, lint, formatter check, static analysis such as type checking, and tests. Keep local exploratory browser checks in the test specification.
- Use a stable job name for the aggregate required check. The starter publishes `Quality checks` for pull requests and merge queues. Keep the job reporting a result on every relevant PR. A required step fails the job when its check fails.
- Check the run for the proposed PR commit (or GitHub’s corresponding merge commit). Address failed checks and wait for pending checks before marking the PR ready.

## Enforce the checks on GitHub

After the job runs once, require it in the ruleset or branch protection for each branch that receives feature PRs. Require a pull request and passing status checks. Select `Quality checks` or the existing mandatory jobs and restrict bypass where permissions allow it. Before merging, verify the rule covers the PR’s actual base branch. Ask a maintainer with settings access to enable or verify the rule when needed.

Creation from a template copies the workflow files. Repository rules are settings on each new repo. If a target branch uses a merge queue, make sure every required workflow also runs on `merge_group`.

[GitHub rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/available-rules-for-rulesets#require-status-checks-to-pass-before-merging) · [Required check troubleshooting](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/troubleshooting-required-status-checks)
