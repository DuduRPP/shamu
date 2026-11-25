# Choose a diagram

Start with the question the reviewer needs answered. A short description or test matrix is sufficient when the relationships are already clear.

| Question | View |
| --- | --- |
| Who uses the system and what else does it connect to? | Context view |
| What owns state or data, and how are responsibilities divided? | Container or component view |
| Which participants act in which order, including retries or errors? | Sequence diagram |
| Which events move a workflow between modes? | State diagram |
| How do persistent records relate? | Entity relationship diagram |

Use the project's format. For a Markdown-first repo, use a small Mermaid block with simple syntax. Label the scope and whether the view is current or proposed. Name boundaries, arrows, and transitions so they can be checked against the code and acceptance criteria. Show only the participants and paths that answer the question, and check the rendering where it will be reviewed.

For example, a duplicate-entry warning with separate edit and confirm actions can benefit from a state view. A small feature with no change to system boundaries may need only the test scenarios.

[GitHub Mermaid support](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams) · [C4 views](https://c4model.com/diagrams) · [C4 notation](https://c4model.com/diagrams/notation)
