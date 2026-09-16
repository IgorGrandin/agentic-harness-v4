## Claude Code runtime adapter

- Use the global `CLAUDE.md` as always-on instructions and discover shared skills from `~/.claude/skills/`.
- Project-specific `CLAUDE.md` files remain higher-specificity instructions and are not managed by this harness.
- This adapter projects the Coder profile's five canonical roles into `~/.claude/agents/` using Claude Code's native agent files. Claude Code's authentication and MCP configuration remains user-managed.

### Model and effort lanes

- Default bounded roles use Claude Haiku 4.5 (`claude-haiku-4-5-20251001`) with medium/default-equivalent effort.
- A stronger bounded invocation keeps the same role and may override it to Claude Sonnet 5 (`claude-sonnet-5`) with medium effort first. Difficulty alone does not invoke the decision role.
- `architect_escalation` is decision-only and uses Claude Opus 5 (`claude-opus-5`) with low effort first. Escalate Opus Low -> Medium -> High only after an evidence-backed insufficiency packet at each step.
