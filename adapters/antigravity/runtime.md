## Antigravity runtime adapter

- Use the global `GEMINI.md` as always-on rules and keep task procedures in selectively loaded skills.
- Keep project rules, workflows, and skills inside the workspace `.agents/` directories when project scope is required.
- Treat globally configured MCP servers as available capabilities only after the current project explicitly permits their tools.
- Never place OAuth clients, access tokens, API keys, or authenticated MCP state in this repository.
- When a repository contains `.agentic-harness/executor.json`, treat it as the documented default for new Coder tasks; an explicit user choice of runtime takes precedence.

### Runtime activation and current state

- This Antigravity adapter activates Coder, Assistant, Knowledge, and Home. Cursor is the default Coder executor, but Antigravity remains a supported alternative.
- For this version, Coder, Assistant, Knowledge, and Home are `ACTIVE` in Antigravity.
- The Assistant durable-memory source, Obsidian integration, Home Assistant integration, MCP authentication, and automatic Antigravity-to-Ollama fallback remain `PLANNED` unless current runtime evidence proves that they are `CONNECTED`.
- Describe Home Assistant as the target source of truth until that integration is connected.

### Model names and routing

- Native role agents use `model: flash` for bounded workers and `model: pro` for `architect_escalation`. The native schema does not expose a reasoning/effort field, so none is invented.
- Semantic lanes are Gemini 3.8 Flash Medium (default), Gemini 3.8 Flash High (strong bounded override), and Gemini 3.1 Pro High (decision authority). Strong work keeps the same role and does not jump to Pro; Pro remains decision-only.
- Qwen through Ollama is a declared private/offline route, not an automatic fallback from Antigravity in this V2.
