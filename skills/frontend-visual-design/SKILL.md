---
name: frontend-visual-design
description: Choose and apply a visual direction for a frontend feature when the user explicitly asks for design or polish guidance.
---

# Design a frontend feature

Inspect the current screen, its closest neighboring screens, and the project's design tokens or components. Identify the user's primary action and the states affected by the feature. Use existing product conventions for navigation, controls, and patterns. If the project has no visual system, choose one direction that fits its audience and describe it with concrete decisions about typography, spacing, color, and density.

- Give the primary action and most important content clear visual priority. Group related controls and use alignment and spacing to show relationships. Use restrained color for actions and status. Keep visible copy tied to decisions the user needs to make.
- Design the normal state and the empty, error, or loading states that the feature actually has. Budget room for long labels and real content. Keep labels readable, keyboard focus visible, and feedback close to the action that caused it.
- Work within the approved scope. Keep the existing component and token conventions, and introduce shared styling when a repeated use justifies it. A broader redesign needs its own scope.
- Verify with representative data in the running app at narrow and wide widths. Walk the primary action, check focus and feedback, and correct visible problems. Capture one or two useful states if the existing PR workflow calls for screenshots.

For a design-only request, deliver a short visual direction and describe the key states and responsive behavior. For implementation, put those decisions in the existing feature artifacts or worker brief.
