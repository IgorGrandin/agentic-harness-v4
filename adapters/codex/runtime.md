## Codex runtime adapter

The host/user selects the root; the harness never replaces it. Luna Medium is
the recommended operational root, not a requirement. Every spawn specifies a
model and reasoning effort, uses fork_turns none by default, and stays within
three concurrent workers.

Luna/Terra handle bounded execution. Sol is architect_escalation only: first
escalation is Sol Low and decision-only; Sol never edits, runs gates, waits, or
owns mechanical correction. Workers use the five role files in global/agents/;
project AGENTS.md takes precedence.

The root is a control plane except for a true microtask. Delegated mechanical
work remains delegated: if a worker fails, times out, reaches a usage limit, or
cannot finish, the host creates one equivalent replacement worker with a bounded
checkpoint. The root does not inherit that work by default. Root takeover is
permitted only after explicit reclassification to a local, reversible,
single-small-edit microtask whose focused verification costs less than a
handoff. Execution-oriented skill bodies and broad implementation context stay
with workers; the root consumes bounded capsules and completion packets.

When an accepted reviewer finding requires correction, the same implementer (or
an equivalent replacement implementer) owns the correction and proportional
re-review. The root decides whether to accept the finding but does not become
the writer.

Long deterministic work uses the blocking agentic-run.ps1; do not poll from the
root. The kernel is an optional helper for bounded delegation, replacement,
context-budget validation, and constraint overlays. Ordinary tasks use the
base harness. /execute adds declared constraints to that same root.
