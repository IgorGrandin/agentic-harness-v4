## Codex runtime adapter

The host/user selects the root; the harness never replaces it. Luna Medium is
the recommended operational root, not a requirement. Every spawn specifies a
model and reasoning effort, uses fork_turns none by default, and stays within
three concurrent workers.

Luna/Terra handle bounded execution. Sol is architect_escalation only: first
escalation is Sol Low and decision-only; Sol never edits, runs gates, waits, or
owns mechanical correction. Workers use the five role files in global/agents/;
project AGENTS.md takes precedence.

Long deterministic work uses the blocking agentic-run.ps1; do not poll from the
root. The kernel is an optional helper for bounded delegation, replacement,
context-budget validation, and constraint overlays. Ordinary tasks use the
base harness. /execute adds declared constraints to that same root.
