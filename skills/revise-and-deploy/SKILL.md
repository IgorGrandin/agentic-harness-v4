---
name: revise-and-deploy
description: Audit a completed execution, review the exact local diff, validate or publish its PR, and deploy the audited commit to Dev2 when the user authorizes the workflow. Use for an end-to-end revise-and-deploy request; ask the user to choose automatic or manual progression before starting.
---

# Revise and deploy to Dev2

Continue from a completed `/execute` result. Dev2 is the fixed deployment target. Keep the audit, local pre-review, PR validation, and deployment as distinct evidence stages. Before starting, ask the user to choose **automatic** or **manual** progression. Do not infer a mode from a general request to deploy.

- **Automatic:** the user's explicit choice authorizes the ordered workflow: audit and required gates with a report; local pre-review with a report; publish or complete PR setup and monitor required validations; fix attributable in-scope failures through an implementer, then rerun affected gates and review the new SHA; report final pipeline evidence; revalidate and deploy that exact reviewed SHA to Dev2. Do not ask for stage-by-stage confirmation or a final deployment approval. Report the final review and pipeline state before deployment, and revalidate the SHA and evidence immediately before it.
- **Manual:** run the audit and report, then stop and ask whether to perform the local pre-review; after that report, ask whether to publish or complete PR setup; after all required PR validations finish, report their results and ask whether to deploy the exact SHA. Wait for each answer before its next stage. An affirmative response to the deployment report authorizes only the SHA identified in that report; the user need not repeat the SHA.

In both modes, unresolved blocking findings stop progression. Automatic mode does not authorize architecture, security, access-control, identity, data, or other consequential design decisions; do not make them on the user's behalf. Neither mode authorizes merging, voting on a PR, or posting review comments. Route code corrections to an implementer; re-run applicable gates and repeat the local pre-review against the corrected SHA. Prior evidence is stale after any tree or commit change. If no suitable implementer or required tool is available, report the blocker rather than silently taking over or inventing an API.

## 1. Audit the completed execution

- Locate and read the execution report and gate manifest. Missing evidence does not prevent auditing available materials: record the gap and continue the audit. It does block any stage whose required gate is missing or cannot be tied to the audited tree. Never substitute unrelated evidence.
- For BrixBroker gate artifacts, use the project-defined root `%TEMP%/claude-handoffs/Broker/`; each gate is in its gate-specific subfolder. Resolve that subfolder from project instructions or the execution manifest. If absent, report the expected path; do not use a similarly named file elsewhere in `%TEMP%`.
- Resolve the exact Azure Boards WI ID from the execution report and branch context. If absent or ambiguous, audit what is available and report the identity gap; do not guess or publish a PR until the exact work item is known.
- Audit the committed tree against the WI, plan, `.cursor/commands/execute-code-review.md`, and applicable project rules and ADRs. Confirm branch, commit, tested tree fingerprint, changed paths, and gate coverage. Re-run only what project rules require or what is needed to bind evidence to the commit.
- Report the audit verdict, WI/plan alignment, exact SHA, evidence and gaps, blocking and secondary findings, governance items, and next eligible stage. Record required audit or build-log updates according to project rules.

## 2. Local pre-review before publication

Before pushing or publishing a PR, review the **actual diff** from the proposed source SHA against its pinned base SHA. Verify both SHAs and branch identity; a changed source or base invalidates the review. Do not infer code behavior from the PR title, changed-file list, summary, or green checks. Follow [the local pre-review rubric](references/pre-review-rubric.md), including its project rule/ADR discovery, evidence and test criteria, decision-residue check, and separate code-quality and process verdicts.

Use only available repository, shell, or provider tooling and the project's documented procedures. A tool name in the rubric describes a capability, not proof that a callable tool exists here. Do not invent MCP methods or assume that listing changed files supplies diff content. If canonical project references required by the rubric (such as the rule map, applicable rules, ADRs, audit rubric, or decision/build log) are absent or inaccessible, state exactly which ones were unavailable and how that limits the verdict. Missing evidence is a recorded limitation; it does not excuse skipping the review of available evidence.

Produce the local pre-review report before publication. Any unresolved blocking finding prevents publication in both modes. Send mechanical corrections to an implementer, then require fresh relevant checks and a fresh review pinned to the corrected SHA. Automatic mode covers those in-scope corrections and stage transitions, but not consequential unresolved decisions.

## 3. PR setup and required validations

Proceed only when the audit and local pre-review have no unresolved blocking finding, the required local gates pass and match the reviewed tree, and the exact WI is known. In manual mode, first obtain the user's approval to publish or complete PR setup. In automatic mode, the initial explicit mode choice authorizes this stage.

- Read the current WI and project PR policy. Push the audited branch and create a PR, or complete the exact work-item association on an existing PR. In Azure DevOps, include `AB#<ID>` in the description or use a documented, actually available explicit linking capability; verify the PR visibly links to the exact WI. A commit mention alone is not a PR-to-WI link.
- Monitor every required PR validation to a terminal result. Do not count pending checks or unrelated failures as green. For failures attributable to the change, ask an implementer to correct within the approved scope, then run fresh affected gates and review the new SHA before waiting for reruns. Stop for unrelated failures, missing required validations, or any blocker outside authorized scope and report it.
- Do not merge or vote. Do not post review comments as part of this workflow.

After the PR validations finish, report the pre-review and audit verdicts, WI/plan alignment, gate evidence, PR URL and verified WI link, validation results, exact reviewed SHA, risks, pending items, limitations, and deployment recommendation. In manual mode, ask whether to deploy **that exact SHA** and wait. In automatic mode, this is a status report; no extra deployment question is required by the selected mode.

## 4. Permission and command safety

- If a required local command is blocked by the sandbox, request the narrowest platform permission for that exact command and scope. Never bypass an approval prompt, weaken security settings, run as administrator by default, alter ACLs, or change credentials or Azure RBAC. If the provider denies the signed-in identity, stop and report the denied action and the required authorized administrator.
- Never access, invoke tools from, or manipulate the repository's hidden `.pnpm` directory (including `node_modules/.pnpm`). Use documented project scripts and its declared package-manager command.
- Use only documented Azure DevOps procedures or actually available tools. Do not claim an API/tool exists because a rubric mentions it. If required PR or pipeline capabilities are unavailable, report the limitation and stop before the dependent external action.

## 5. Deploy to Dev2

Deploy only after all required audit, local gate, pre-review, PR, and validation evidence is valid for the exact target SHA. In manual mode, the user's affirmative answer to the report that identifies the SHA is sufficient; do not require them to repeat it. Automatic mode needs no additional confirmation after its explicit initial choice, but still requires all gates and a final SHA/evidence revalidation. If the branch tip, deployment target, base, tested tree, or relevant evidence changed, rerun what is invalidated and repeat the review; in manual mode obtain approval after reporting the new exact SHA.

- Use the documented Azure DevOps environments pipeline (pipeline 139), `deploymentTarget=dev2`, and the audited branch. Confirm `Build.SourceVersion` equals the approved/reported SHA; stop on mismatch.
- Follow `devops/README.md` and `devops/docker-ambientes.yml`. Confirm `DeployDev2` succeeds and the Dev2 health check returns HTTP 200.
- The pipeline reads Compose and `.env` installed on the server; it does not update their values from the repository. If deployment depends on a server-side Compose or `.env` edit, stop and report the required administrator action.
- Run only additional runtime smoke checks required by the WI/change. An HTTP 200 does not prove an untested Keycloak flow, email delivery, or other behavior.

## Stop conditions and final report

Stop on an unresolved blocking finding, failed or missing required gate/validation, commit/tree mismatch, unavailable required tooling or authorization, consequential unresolved decision, or unsuccessful Dev2 health check. Do not bypass checks or expose secrets. In the final report distinguish audit and review verdicts, governance findings from code findings, gate and PR evidence, exact pipeline run and `Build.SourceVersion`, deployed commit/image when available, health result, and runtime checks not performed. Claim no publication, link, merge, deployment, or behavioral proof without its corresponding evidence.
