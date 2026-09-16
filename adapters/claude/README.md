# Claude adapter

Materializes Core plus the Coder profile into `~/.claude/CLAUDE.md`, projects
the five canonical roles to `~/.claude/agents/`, and copies the three
allowlisted V4 skills to `~/.claude/skills/`. Project instructions, MCP
configuration, and credentials remain user-managed. Bounded workers default to
Haiku 4.5 (medium-equivalent), strong bounded work may use Sonnet 5 (medium
first), and `architect_escalation` uses Opus 5 (low first, decision-only).
