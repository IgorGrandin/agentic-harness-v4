# Global operating agreements

### Scoped command permissions

When the host explicitly blocks a task-authorized command for sandbox or restricted-permission reasons, request scoped elevation through the host approval mechanism (`require_escalated` in Codex). Give a concrete purpose and the narrowest command and resource scope. Do not ask the user again for routine elevation already authorized by the task; keep host approval controls intact.

If denied, continue independent work and report the blocked command and reason. Never bypass approval by changing ACLs, credentials, or security settings. Treat `command not found` (for example, Docker or `az` is absent) as a missing dependency, not a permission error. Find documented alternatives or report it; elevation does not install tools.

## Codex runtime adapter

The host/user selects the root; the harness never replaces it. Keep the
orchestrator on GPT-6 Luna at Medium when the host allows explicit root
selection. The harness cannot enforce a root model or effort through
`config.toml`; an explicit host/user choice wins. Codex subagents default to
`gpt-6-luna` at Medium. Role files set Scout to Low and Reviewer to High;
Implementer, Verifier, and first-pass Architect use Medium. Every spawn
specifies a model and reasoning effort, uses fork_turns none by default, and
stays within three concurrent workers. No role uses xHigh in the normal path.

The Planner is a responsibility of the orchestrator or assigned worker, not a
separate native role. It should use scout findings instead of repeating broad
repository exploration.

Prefer action over narration. Once the task is understood, act without
repeatedly describing the next steps. Use at most one short preamble before
tool calls when useful; do not restate the plan unless it materially changes.
Report meaningful findings, blockers, changes, and validation results without
repeating information already provided by another agent.

Luna/Terra handle bounded execution. Sol is architect_escalation only: first
escalation uses GPT-6.1 Sol at Medium and is decision-only; Sol never edits,
runs gates, waits, or owns mechanical correction. Workers use the five role
files in global/agents/; project AGENTS.md takes precedence.

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
- **decision-escalation:** GPT-6.1 Sol at Medium is decision-only for material
  architecture, security, permissions, data, migration, contract, or
  contradictory-evidence decisions; it never edits, tests, waits, or corrects
  mechanically.
- Use Sol High only after an evidence-backed insufficiency packet from Sol
  Medium. xHigh is exceptional and requires a separate explicit justification.

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
base harness. `/execute` adds declared constraints to that same root and uses
the same role routing; it does not add a separate model workflow.

### Skill responsibility mapping

The harness keeps its five canonical roles. When `review-pr` delegates a large-diff evidence question to its `diff-evidence` responsibility, use the existing read-only Scout role in Codex. Give Scout one specific evidence question and the diff target; request file-and-line references with literal supporting excerpts. Scout reports evidence only: it must not summarize the whole PR, assess compliance, recommend a verdict, or make the review decision. The review owner verifies the cited evidence and retains the verdict. This mapping does not add a sixth role or alter the packaged skill source.

### `review-pr` Codex crosswalk

- Invoke the preserved skill with an explicit request such as `$review-pr N`; this is the Codex equivalent of `/review-pr N`.
- Interpret Claude `Read` as native file reading and `Grep` as `rg` searches.
- Interpret `Agent` with `subagent_type: "diff-evidence"` as a bounded task to the existing read-only Scout, following the evidence-only/no-verdict contract above.
- The skill's `.claude/settings.json` restrictions do not enforce permissions in Codex. Follow Codex/session permission controls, and always honor the skill's rule against editing PR code.

# Shared skill metadata index

Use this short index for initial routing; the activity owner loads the full
skill body after the ownership gate.

- `sdd-workflow` — repository-grounded bugs, features, discovery, refactors, and reviews.
- `systematic-debugging` — diagnosis of failures and unexpected behavior.
- `repo-aware-architecture` — repository-grounded architecture analysis.
- `revise-and-deploy` — audit a completed execution, validate its PR, and deploy to Dev2 only when explicitly requested.
- `review-pr` — review a pull request against the actual diff, repository rules, ADRs, release scope, and gate evidence.
- `domain-modeling` — sharpen domain terms and record architectural decisions using the repository's established glossary and ADR formats.
- `audit-task` — audit a human developer's implementation against the canonical task spec and real diff; read-only review.
- `brainstorming` — run a structured design interview using grilling and the existing domain-modeling skill.
- `grilling` — interview the owner one decision at a time to stress-test a plan or design.
- `handoff` — write a concise, resumable session handoff for a new Codex session.
- `plan-for-cursor` — validate a Cursor plan for executable steps, discriminating tests, verified claims, and gates.
- `plan-task` — read an Azure Boards work item and create a repository-grounded Cursor execution plan.
- `revise` — audit a completed Cursor execution against its plan, code, and gates; produce a correction plan when needed.
- `spec-task` — collaboratively define a human-developer task and prepare its Azure Boards specification.
- `takeover` — resume from the latest or specified Codex handoff after checking current repository state.
