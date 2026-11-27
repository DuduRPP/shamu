---
name: frontend-ui-review
description: Review a running frontend feature for concrete usability, layout, and accessibility issues when the user selects this skill.
---

# Review a frontend feature

Read the feature's acceptance criteria and use the running app with sample data. Follow the main journey at a typical desktop width and a narrow mobile width. Include relevant alternate states such as empty results, invalid input, or recovery. If the app cannot run, report which checks you could do from the diff.

- Check visual priority, spacing, alignment, text wrapping, and clipping. Look for an obvious next action in each state and verify that long content leaves the interface usable.
- Use the keyboard through the changed flow. Check visible focus, labels, control names, expected navigation, and focus after submission or dismissal. Check that feedback is noticeable and that errors explain how to recover. Check color contrast where styling changed.
- Report a concrete observation with the state or viewport, reproduction steps, user impact, and the smallest useful fix. Attach a screenshot only when it clarifies a finding. Distinguish observed issues from checks still pending.

Keep review read-only unless the task includes fixes. Use the feature's existing review and verification process.
