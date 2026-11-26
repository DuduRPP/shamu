---
name: grill-requirements
description: Start a new feature from a plain-language build request or run a requirements interview. Develop the domain model and turn settled scope into a spec, issues, and a design handoff as requested.
---

# Grill requirements

## Interview and model the domain

- Apply Matt Pocock's [grilling](references/pocock/grilling.md) and [domain modeling](references/pocock/domain-modeling.md) together. Read the brief, relevant code, glossary, and decision records. Follow existing documentation conventions or the single-context layout in the guide. Check project facts before asking the user.
- Check [requirements coverage](references/coverage.md) for this feature and its application-wide effects. Ask all remaining questions that can materially change behavior, constraints, or acceptance. Group questions by settled prerequisites and walk concrete success, edge, and failure scenarios. Resolve conflicts with the code and glossary before settling the spec.
- For a decision with clear alternatives, offer two or three distinct, practical options. Mark one recommendation with its reason and explain trade-offs briefly. Keep questions open when proposing options would narrow the discussion prematurely.
- Use an interactive choice prompt when it accepts a free-text answer for each question. Otherwise, number questions and letter the options in chat so the user can reply with `1A, 2B`. Invite the user to add conditions or answer in their own words. Carry their actual answer and any conditions into the confirmed decisions.
- Capture confirmed glossary terms as they settle. Use the domain-modeling guide’s criteria to decide which architecture decisions warrant a record. Use the upstream formats to update canonical files within the assigned write scope. Keep proposed shared changes in the feature draft while ownership is pending. During grilling from the main checkout, keep the exact edits in the feature's draft and pass them to the designer to apply in the feature worktree. Include proposed edits in a draft-only response unless the user asked to save them.

## Close the interview and hand off

- Use the project's feature spec format or Shamu's `templates/feature-spec.md` from the Git root. Record the goal, scope, confirmed decisions, and observable acceptance criteria with stable IDs. Use the settled domain terms and reference the relevant glossary and ADRs. Keep deferred behavior and open material decisions visible.
- Use one issue for a small, verifiable feature. For larger work, apply the context and drafting steps in [Pocock's to-tickets guide](references/pocock/to-tickets.md). Draft numbered, independently verifiable slices that deliver a complete outcome through the relevant layers. Keep acceptance criteria traceable to the spec and list only dependencies that gate a slice. Use the guide's expand–contract sequence when a wide refactor needs multiple safe steps.
- Follow the scope of the request under the repository instructions. For interview or draft work, return the requested artifact. For a full feature request, resolve any material scope, slicing, or dependency decisions together. Record which user replies settle the requirements revision and proceed once the scope is confirmed.
- Follow `docs/workflow.md` to reuse or publish issues in the verified project repository and delegate design in a dedicated Orca worktree. Carry the requirements revision, module and dependency context, and confirmed domain edits. After the launch receipt, report the issue and session and return to the user.

## Bundled upstream guides

Matt Pocock's skills v1.3.2. [Pinned source](https://github.com/mattpocock/skills/tree/d1478fcb140db0b93c0c8df17bcfd311844749d0/skills) · [License](references/pocock/LICENSE)
