---
name: grilling
description: "Grill the user relentlessly about a plan or design. Use when the user wants to stress-test a plan before building, or uses any 'grill' trigger phrases."
---

# Grilling (Codex interface)

This entry preserves the original Claude workflow at [source-claude/ORIGINAL.md](source-claude/ORIGINAL.md). Read that file before executing the workflow. Treat it as the normative workflow; translate only the host-specific mechanics below. Do not edit the source file.

## Codex interface

- Invoke this entry explicitly as `$grilling` (the Claude slash invocation becomes the Codex skill invocation). Keep the source workflow's scope, sequence, questions, decision points, outputs, and approval boundaries.
- Use Codex file reading for Claude `Read`; `rg` for `Grep`/`Glob`; and the normal shell tool for `Bash`. Do not emulate Claude-specific tool syntax.
- When the source delegates evidence gathering to `Agent` / `diff-evidence`, use the existing read-only Scout role for one bounded evidence question. Ask for file/line references and literal excerpts only; the skill owner retains analysis and verdict.
- For Azure Boards, PRs, files, and pipelines, use the Azure DevOps connector/tools available in this session and follow their actual schemas. The imported skill's MCP function names are examples from Claude and are not Codex tool names. If the connector is unavailable, report that dependency rather than pretending to query Azure.
- Resolve project paths from the active BrixBroker checkout and its `AGENTS.md` / repository guidance. Claude-specific `CLAUDE.md` and `.cursor` references are project evidence where present; Codex instructions do not replace them. Preserve Cursor-targeted outputs (such as `.cursor/plans`) when the source requires them.
- Translate Claude-specific ephemeral state paths to `%TEMP%\codex-handoffs\BrixBroker\` for handoff documents and `%USERPROFILE%\.codex\brixbroker\` for durable Codex session records. Keep filenames and record formats required by the source. Never create or edit the original Claude-specific state locations from Codex.
- Codex/session permissions govern tool use. Any write to Azure, PR comments, or governance records remains subject to the source workflow's owner-approval step; do not infer approval from invocation alone.

## Invocation

Use `$grilling` when the user asks for this workflow, including the equivalent Claude slash-command name. If the source calls another imported skill, read that skill's Codex entry and preserve the dependency order; for existing `domain-modeling`, use its canonical shared skill as-is.