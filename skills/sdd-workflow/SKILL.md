---
name: sdd-workflow
description: Procedural software work for bugs, features, discovery, refactors, and reviews.
---

# SDD workflow

Use this small procedure for repository-grounded software work. The host and
Coder adapter own model/provider routing; this skill owns the work procedure.

## Intake and evidence

Classify the request as bug, feature, discovery, refactor, or review. Read the
applicable repository instructions, then inspect only the task, concise project
index, and files needed for the decision. Label facts, inferences, and open
questions. Repository evidence outranks imported prose.

For an explicit local microtask, use the fast lane: one targeted inspection,
one scoped edit (if authorized), and one focused check. Do not create a plan
or load unrelated references.

## Specification and execution

For larger work, keep a concise Markdown source of truth with outcome, scope,
acceptance criteria, non-goals, risks, and verification. Preserve existing
architecture and authorization boundaries. A worker loads the full skill and
targeted implementation files; the root receives a bounded capsule or
completion packet and does not shadow-execute the worker.

Implement the smallest change that satisfies the criteria. Return material
ambiguities to the root before making consequential assumptions. A failed
worker is replaced by an equivalent bounded worker; findings return to the
writer for correction.

## Verification and handoff

Verify each acceptance criterion with the smallest decisive deterministic check.
Use the repository's documented commands and the blocking runner for long
operations. Do not infer success from compilation alone. Report outcome,
changed artifacts, evidence, unresolved limitations, and the next decision.

Progressive disclosure is mandatory: index first, then targeted sources;
bounded context in, bounded packet out.
