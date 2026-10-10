---
name: revise
description: "Audita a execução de um plano do Cursor contra o diff e o código reais; usa relatórios do /execute como evidência complementar quando existirem, sem exigir um relatório narrativo separado. Use após o Cursor executar um plano, mesmo que só haja evidência de gates."
---

# Revise (Codex interface)

This entry preserves the original Claude workflow at [source-claude/ORIGINAL.md](source-claude/ORIGINAL.md). Read that file before executing the workflow. Treat it as the normative workflow; translate only the host-specific mechanics below. Do not edit the source file.

## Codex interface

- Invoke this entry explicitly as `$revise` (the Claude slash invocation becomes the Codex skill invocation). Keep the source workflow's scope, sequence, questions, decision points, outputs, and approval boundaries.
- **Codex fallback when `/execute` has no narrative report:** this deliberately adapts the source's Claude-specific report-required path. The separate `execute-reports` document is optional. Cursor may provide a gate report without that narrative, so do not stop with `sem-relatorio` just because the narrative file is absent. Start the timestamp invariant first, then identify the approved `.cursor/plans` plan and execution target from the conversation/argument plus `git status`, `git log`, and the actual diff. If a matching plan and changed commit/diff are identifiable, continue the code-quality audit against that plan and the real code. Treat any `/execute` gate report as evidence about gates only; do not infer code quality or missing facts from it. If gate evidence is absent, record it as unverified and still deliver the code review. Reserve `sem-relatorio` for when no execution target or diff can be identified after checking the repository; ask for the missing plan/commit only then.
- Preserve the source's round-record invariant: record the start timestamp before opening project files and append a `rodadas.csv` row before ending, including when the narrative report is absent. In Codex, use `%USERPROFILE%\.codex\brixbroker\rodadas.csv` as the durable record path.
- Use Codex file reading for Claude `Read`; `rg` for `Grep`/`Glob`; and the normal shell tool for `Bash`. Do not emulate Claude-specific tool syntax.
- When the source delegates evidence gathering to `Agent` / `diff-evidence`, use the existing read-only Scout role for one bounded evidence question. Ask for file/line references and literal excerpts only; the skill owner retains analysis and verdict.
- For Azure Boards, PRs, files, and pipelines, use the Azure DevOps connector/tools available in this session and follow their actual schemas. The imported skill's MCP function names are examples from Claude and are not Codex tool names. If the connector is unavailable, report that dependency rather than pretending to query Azure.
- Resolve project paths from the active BrixBroker checkout and its `AGENTS.md` / repository guidance. Claude-specific `CLAUDE.md` and `.cursor` references are project evidence where present; Codex instructions do not replace them. Preserve Cursor-targeted outputs (such as `.cursor/plans`) when the source requires them.
- Translate Claude-specific ephemeral state paths to `%TEMP%\codex-handoffs\BrixBroker\` for handoff documents and `%USERPROFILE%\.codex\brixbroker\` for durable Codex session records. Keep filenames and record formats required by the source. Never create or edit the original Claude-specific state locations from Codex.
- Codex/session permissions govern tool use. Any write to Azure, PR comments, or governance records remains subject to the source workflow's owner-approval step; do not infer approval from invocation alone.

## Invocation

Use `$revise` when the user asks for this workflow, including the equivalent Claude slash-command name. If the source calls another imported skill, read that skill's Codex entry and preserve the dependency order; for existing `domain-modeling`, use its canonical shared skill as-is.
