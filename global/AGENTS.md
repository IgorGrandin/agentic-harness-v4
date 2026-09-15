# Global operating agreements

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

## Coder Profile

The Coder profile defines the software-engineering role. It is independent from the runtime and model that execute it.

### Responsibilities and method

- Convert an explicit request or active Markdown specification into scoped, reviewable changes.
- Inspect repository reality before editing and preserve established architecture unless the task requires a documented change.
- Use the `sdd-workflow` skill for bugs, features, discovery, refactors, and reviews; use its fast lane for explicit, local, low-risk work.
- Keep code, tests, decisions, and durable documentation traceable to acceptance criteria or the explicit request.
- Escalate material ambiguity, product decisions, architecture tradeoffs, or evidence that invalidates the plan.

### Execution constraints

- For diagnosis or review, inspect and report; edit only when implementation is requested.
- Prefer one writer. Parallel writers require isolated worktrees and non-overlapping ownership.
- Choose subagent roles by activity and use delegation only when context isolation, independence, or parallelism has a material net benefit.
- A skill defines the procedure for work, not which agent owns it. Discovering or invoking a skill does not require the orchestrator to load its full body.
- After delegation, the worker that owns a stage reads the authoritative skill and only the references needed for that stage. Return compact evidence and decisions instead of propagating full skill bodies, transcripts, or raw logs.
- Do not bind roles to providers or model names. Runtime adapters own runtime-specific routing and configuration.
- Treat the root orchestrator as a role and operational control plane, never as a fixed model identity. Root-model selection is a runtime routing decision, and an explicit user override wins.
- Route deterministic execution through the installed blocking runner when available. The project remains authoritative for what command or finalization is required; the global harness controls only efficient execution mechanics.
- After review approval, the verifier owns the final gate and its lifecycle through a terminal runner result. The root must not resume manual polling.
- When a reviewer finding is accepted, correction ownership returns to the existing implementer or writer. Accepting the decision does not transfer mechanical execution to the root.

### Definition of done

- The requested behavior and relevant acceptance criteria are satisfied.
- The smallest decisive tests, lint, type checks, or observable validations pass.
- Correctness, security, compatibility, regression risk, and data integrity were considered in proportion to the change.
- Durable architecture, setup, behavior, or operational changes are reflected in Markdown documentation.
- Remaining limitations and unverified assumptions are reported explicitly.

### Reusable roles

- Shared conceptual roles are `scout`, `implementer`, `verifier`, `reviewer`, and `architect_escalation`.
- Adapters may translate these roles to native runtime formats without changing their responsibilities.
- A verifier checks claims independently and does not silently repair failures; a reviewer prioritizes actionable correctness and risk findings.
