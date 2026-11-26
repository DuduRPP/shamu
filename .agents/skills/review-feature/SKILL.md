---
name: review-feature
description: Independently review a Shamu feature diff against approved requirements, architecture, tests, and project standards. Report blocking findings to the implementation agent through the feature coordinator.
---

# Review a feature

Work from fresh context. Use the pinned base and head, the originating issue or local spec, both approved documents, project guidance, and verification results. Inspect the diff against the merge base. Keep the review read-only and flag missing evidence.

Use the Spec and Standards checks in [Pocock’s code-review skill](references/pocock/code-review.md). Apply both in this independent worker. The feature coordinator supplies the comparison and issue, and receives the review result.

- Trace each acceptance criterion and relevant architecture decision to the behavior and tests. Check scope, compatibility, error paths, concurrency, and shared contracts where the diff changes them.
- Look for tests coupled to internals or mocks, missing meaningful cases, unsupported verification claims, and regressions. Compare test evidence to the exact head.
- Check readability, maintainability, duplication, unnecessary abstractions and comments, plus relevant security and performance risks. Focus on concrete failure modes and changes the review can justify.

Report each blocking finding with the file and line, the affected requirement or constraint, and what can go wrong. Report the reviewed head, the evidence checked, and any remaining gaps. Use the [writing skill](../unslop/SKILL.md) while preserving the evidence.

Send the findings back to the feature coordinator with the Orca worker receipt. The coordinator routes corrections to the implementer and requests a fresh review for the new head.

[Pinned review guide](https://github.com/mattpocock/skills/blob/d1478fcb140db0b93c0c8df17bcfd311844749d0/skills/engineering/code-review/SKILL.md) · [License](references/pocock/LICENSE)
