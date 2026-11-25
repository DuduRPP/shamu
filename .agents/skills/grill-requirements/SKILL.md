---
name: grill-requirements
description: Start a new feature from a plain-language build request or run a requirements interview. Develop the domain model and turn settled scope into a spec, issues, and a design handoff as requested.
---

# Grill requirements

## Interview and model the domain

- Apply Matt Pocock's [grilling](references/pocock/grilling.md) and [domain modeling](references/pocock/domain-modeling.md) together. Read the brief, relevant code, glossary, and decision records. Follow existing documentation conventions or the single-context layout in the guide. Check project facts before asking the user.
- Ask only questions whose prerequisites are settled and whose answers would change the scope, behavior, or a consequential design decision. Call out conflicting or overloaded terms, check what the code does, and test domain relationships with concrete scenarios. Use the answers to determine the next round.
- For a decision with clear alternatives, offer two or three distinct, practical options. Mark one recommendation with its reason and explain trade-offs briefly. Keep questions open when proposing options would narrow the discussion prematurely.
- Use an interactive choice prompt when it accepts a free-text answer for each question. Otherwise, number questions and letter the options in chat so the user can reply with `1A, 2B`. Invite the user to add conditions or answer in their own words. Carry their actual answer and any conditions into the confirmed decisions.
- In the full workflow, update the relevant local glossary as each domain definition is confirmed. Use the upstream format and create the file only when there is a term to record. If a choice meets the upstream guide's three ADR criteria, propose the record in the same round and write it when the decision is confirmed. For a draft-only request, include any proposed glossary or ADR changes in the draft unless the user also asked for edits.

## Close the interview and hand off

- Use the project's feature spec format or Shamu's `templates/feature-spec.md` from the Git root. Record the goal, scope, confirmed decisions, and observable acceptance criteria with stable IDs. Use the settled domain terms and reference the relevant glossary and ADRs. Keep deferred behavior and open material decisions visible.
- Use one issue for a small, verifiable feature. For larger work, apply the context and drafting steps in [Pocock's to-tickets guide](references/pocock/to-tickets.md). Draft numbered, independently verifiable slices that deliver a complete outcome through the relevant layers. Keep acceptance criteria traceable to the spec and list only dependencies that gate a slice. Use the guide's expand–contract sequence when a wide refactor needs multiple safe steps.
- Follow the scope of the request under the repository instructions. For interview or draft work, return the requested artifact. For a full feature request, resolve any material scope, slicing, or dependency decisions together. Record which user replies settle the requirements revision and proceed once the scope is confirmed.
- Follow `docs/workflow.md` to reuse or publish issues in the verified project repository, then continue to design. Pass the verified issues, requirements revision, relevant local domain documents, and full-workflow context to the design session. Report the issues and session.

## Bundled upstream guides

Matt Pocock's skills v1.3.2. [Pinned source](https://github.com/mattpocock/skills/tree/d1478fcb140db0b93c0c8df17bcfd311844749d0/skills) · [License](references/pocock/LICENSE)
