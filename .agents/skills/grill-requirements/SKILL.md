---
name: grill-requirements
description: Interview the user about a feature or proposal, clarify domain language, draft requirements, and break approved requirements into draft implementation tasks.
---

# Grill requirements

## Prepare and interview

- Read the brief and relevant project files first. Check existing behavior, requirements, domain language and decision records before asking the user for information already available there. Surface material conflicts between the brief and the repository.
- Ask the unresolved questions that change scope, observable behavior, or a consequential design choice. Ask in small rounds, with prerequisites settled before follow-up questions. For each material choice, recommend an answer and give the reason or trade-off. Pause for answers before treating any recommendation as a decision.
- Reuse project terms. When a term has conflicting meanings that affect behavior, confirm its meaning and propose a focused glossary entry in the project's existing documentation. For a consequential decision with viable alternatives and a real downside, capture the choice and consequence in the design notes or propose an architecture decision record if future work needs it. Apply documentation edits within the requested scope.

## Draft and confirm requirements

Use the project's feature-spec format. In Shamu, use `templates/feature-spec.md` and follow `docs/workflow.md` from the Git root. Capture the goal, scope, confirmed decisions that affect behavior, and observable acceptance criteria with stable IDs. Keep deferred behavior explicit and surface open decisions. Label the spec as a draft until the human approves that revision.

Present the specific spec revision for approval. A response to an interview question confirms that decision. Task planning requires separate, explicit human approval of the current requirements revision. If a material change supersedes an approved revision, return to approval for the changed scope.

## Draft tasks from approved requirements

- When task planning is requested, check for explicit human approval tied to the current spec. If approval is unclear, identify the decision or revision to confirm and pause task planning.
- Keep a small feature as one task when it can be verified as a whole. Split larger work into slices that each deliver complete behavior someone can verify independently. For each draft, give a title, intended outcome, covered acceptance criteria, a proposed verification surface, and any real blocking dependencies. Link the approved spec and note design or test questions still to resolve.
- For a multi-issue feature, show a numbered breakdown and confirm the split and real blockers with the owner before preparing issue previews. Present the exact drafts and proposed tracker relationships for review. Use separate authorization before publishing the reviewed drafts to the named repository or changing GitHub issues. In Shamu, follow the publishing steps in `docs/workflow.md`. Follow the project's design and test approval process before implementation.

Inspired by Matt Pocock's [grilling](https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md), [domain modeling](https://github.com/mattpocock/skills/blob/main/skills/engineering/domain-modeling/SKILL.md), and [ticket slicing](https://github.com/mattpocock/skills/blob/main/skills/engineering/to-tickets/SKILL.md).
