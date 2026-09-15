# Agentic Harness V4 (`agentic-harness-v4`)

V4 is a parallel, minimal distribution. One native-agent kernel serves ordinary
tasks and `/execute`; `/execute` is a constraints overlay, not a workflow
engine. The host selects the root. Sol is decision-only, first escalation is
Sol Low, and a failed worker receives one equivalent replacement with bounded
context. Long deterministic operations use `bin/agentic-run.ps1` and keep
runtime state outside repositories.

Workers must return doubts, ambiguities, and critical decisions to the root;
they may not assume consequential answers. The root answers or invokes Sol Low
`architect_escalation`, then sends the decision back.

## Contents

The manifest is the source of truth. Five roles are retained (scout,
implementer, verifier, reviewer, architect-escalation); `sdd-workflow`,
`systematic-debugging`, and `repo-aware-architecture` are worker-loaded skills
available on demand. Codex, Cursor, Antigravity, and Claude Code
projections are included. No LangGraph, compiler, graph/runtime, workflow
receipts, obsolete registries, Ollama models, unrelated profiles/memory, or
Python packaging are shipped.

## Validate and install

Run `scripts/materialize.ps1`, then `scripts/verify.ps1`. A dry-run install is
`scripts/install.ps1 -HarnessHome <temporary-path> -WhatIf`; it never performs a
global install. A replacement rollout should first archive the current
`.agentic-harness` and verify V4 in a temporary target. Roll back by restoring
that archive and restarting host applications. The original harness remains
untouched until the user explicitly authorizes replacement.

Global destinations are `~/.codex/AGENTS.md` plus `~/.codex/agents/`,
`~/.cursor/rules/agentic-harness.mdc` plus `~/.cursor/agents/`,
`~/.gemini/GEMINI.md` plus `~/.gemini/config/skills/`, and
`~/.claude/CLAUDE.md` plus `~/.claude/skills/`. Codex and Cursor receive native
role projections; Antigravity and Claude Code receive global instructions and
the three shared skills. Other profile declarations may remain as source/platform
declarations, but they are not materialized into the Codex Coder runtime unless
that adapter explicitly composes them. MCP, credentials, models, and project-local rules
remain provider-managed. Existing managed instruction files are backed up
under each provider's `portable-backups/<timestamp>/` directory.

## Baseline and decision log

V4 was derived from the current agentic-harness manifest/install/materialize/
verify contract. KEEP: portable manifest, adapter projections, materialization,
blocking runner, finalization guard, kernel, roles, and installation checks.
SIMPLIFY: one manifest, four adapters, three worker-loaded skills, and a small
execute resolver.
REMOVE: legacy workflow compiler/validator/registry/resolver/receipts, graph
runtime, obsolete capability/profile registries, unrelated profiles/memory,
and `pyproject.toml`.
