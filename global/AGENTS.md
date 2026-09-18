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

### Resolved instruction references

- Parent resolves deterministic instruction/skill references before spawn;
  packets carry paths, so workers do not rediscover them.
- Global Harness policy is inherited from the Codex runtime. If inheritance is
  unavailable, pass the exact `~/.codex/AGENTS.md` path; never search for it.
- Project `AGENTS.md` and applicable rules remain distinct project constraints
  and are passed by resolved path.
- Shared skills use the canonical `~/.agents/skills/<skill-name>/SKILL.md` path;
  pass it directly and do not probe the repository for same-named copies.
- Use project-local skills or overlays only when explicitly resolved as local,
  passing their exact path.

The root is a control plane except for a true microtask. Delegated mechanical
work remains delegated: if a worker fails, times out, reaches a usage limit, or
cannot finish, the host creates one equivalent replacement worker with a bounded
checkpoint. The root does not inherit that work by default. Root takeover is
permitted only after explicit reclassification to a local, reversible,
single-small-edit microtask whose focused verification costs less than a
handoff. Execution-oriented skill bodies and broad implementation context stay
with workers; the root consumes bounded capsules and completion packets.

### Ownership gate

Use skill metadata/index only to classify activity. Choose ownership before
opening any execution-oriented `SKILL.md`, broad repository search, many
rules, large logs, or test/debug cycles. The owner then loads the procedure:
`skill applies -> choose owner -> owner loads skill -> execute`.

- **micro-direct:** explicit local reversible small edit plus focused check;
  no routing note is required.
- **bounded-direct:** root may retain one coherent, moderate surface when
  context/tool cycles are bounded and delegation offers no material
  independence, isolation, parallelism, noisy-output, or long-run benefit.
  Before the full skill body, emit: `Routing: bounded-direct; owner: root;
  reason: <positive bounded evidence>; expected surface: <scope>; delegate
  if: <assumptions that would break>`. This is transient, not a receipt.
- **delegated:** send a self-contained packet; the worker owns skill loading
  and returns a bounded capsule/completion packet. The root does not load the
  body merely for awareness.
- **decision-escalation:** Sol Low is decision-only for material architecture,
  security, permissions, data, migration, contract, or contradictory-evidence
  decisions; it never edits, tests, waits, or corrects mechanically.

Before a broad read ask whether it primarily serves routing or execution. A
primarily execution-oriented broad read belongs to the activity owner and is a
delegation trigger. Reclassify before more broad work if a second independent
surface, cross-cutting scope, repeated debug cycles, significant output,
long-running process, independent review, or increased risk/ambiguity appears.

When an accepted reviewer finding requires correction, the same implementer (or
an equivalent replacement implementer) owns the correction and proportional
re-review. The root decides whether to accept the finding but does not become
the writer.

Long deterministic work uses the blocking agentic-run.ps1; do not poll from the
root. The kernel is an optional helper for bounded delegation, replacement,
context-budget validation, and constraint overlays. Ordinary tasks use the
base harness. /execute adds declared constraints to that same root.

# Shared skill metadata index

Use this short index for initial routing; the activity owner loads the full
skill body after the ownership gate.

- `sdd-workflow` — repository-grounded bugs, features, discovery, refactors, and reviews.
- `systematic-debugging` — diagnosis of failures and unexpected behavior.
- `repo-aware-architecture` — repository-grounded architecture analysis.
- `revise-and-deploy` — audit a completed execution, validate its PR, and deploy to Dev2 only when explicitly requested.
