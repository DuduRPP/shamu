---
name: grill-requirements
description: Interview the user about a feature, clarify domain terms, and turn settled requirements into a spec or an authorized GitHub issue and Orca design handoff.
---

# Grill requirements

## Prepare and interview

- Read the brief and relevant project files first. Check existing behavior, requirements, domain language and decision records before asking the user for information already available there. Surface material conflicts between the brief and the repository.
- Ask the unresolved questions that change scope, observable behavior, or a consequential design choice. Ask in small rounds, with prerequisites settled before follow-up questions.
- For a decision with clear alternatives, offer two or three distinct, practical options. Mark one recommendation with its reason and explain trade-offs briefly. Keep questions open when proposing options would narrow the discussion prematurely.
- Use an interactive choice prompt when it accepts a free-text answer for each question. Otherwise, number questions and letter the options in chat so the user can reply with `1A, 2B`. Explicitly invite the user to add conditions to any choice or answer in their own words. Wait for their reply and carry their actual answer and any conditions into the confirmed decisions.
- Reuse project terms. When a term has conflicting meanings that affect behavior, confirm its meaning and propose a focused glossary entry in the project's existing documentation. For a consequential decision with viable alternatives and a real downside, capture the choice and consequence in the design notes or propose an architecture decision record if future work needs it. Apply documentation edits within the requested scope.

## Close the interview and hand off

- Capture the goal, scope, confirmed decisions, and observable acceptance criteria with stable IDs. Keep deferred behavior and open material decisions visible. Use the project's feature-spec format. In Shamu, use `templates/feature-spec.md` from the Git root.
- For a draft request, return the draft. For the full workflow, use authorization already given for GitHub issue creation and the design session in the named repo. If it is missing, use one closing recap to confirm the scope and authorize both actions. Treat a reply to a single question as that decision and record actual human confirmation for the settled revision. Revisit materially changed scope with the user.
- Use one issue for a small, verifiable feature. For larger work, draft independently verifiable outcomes with criteria and real blockers. Resolve consequential questions about splitting or sequencing in the same closeout.
- Once the scope is settled and authorized, follow `docs/workflow.md` to publish and verify the issue and immediately launch a new Orca session for architecture and tests. Give the new session the issue URL and spec revision. Report the verified issue and session. The design session proposes the plan for human review before implementation.

Inspired by Matt Pocock's [grilling](https://github.com/mattpocock/skills/blob/main/skills/productivity/grilling/SKILL.md), [domain modeling](https://github.com/mattpocock/skills/blob/main/skills/engineering/domain-modeling/SKILL.md), and [ticket slicing](https://github.com/mattpocock/skills/blob/main/skills/engineering/to-tickets/SKILL.md).
