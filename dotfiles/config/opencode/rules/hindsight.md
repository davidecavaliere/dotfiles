# Hindsight Long-term Memory Rules

When storing information using the `hindsight_retain` tool, you MUST track which agent is adding the memory:
1. Always populate the `context` parameter with the name of the active agent (e.g., `agent: watson`, `agent: hermes`, `agent: sight`, `agent: ask`).
2. Alternatively, prepend the agent's identity to the `content` parameter (e.g., `[Agent: Watson] ...`).

This ensures that any agent recalling this memory in the future can track its origin and determine its context or trust-level.
