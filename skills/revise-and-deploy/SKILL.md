---
name: revise-and-deploy
description: Independently audit a completed execution, open and validate its PR, then deploy the approved commit to Dev2. Use only when the user requests this end-to-end workflow; stop before deployment if any required gate is unresolved.
---

# Revise and deploy to Dev2

Continue from a completed `/execute` result. Dev2 is the fixed deployment target. Keep review, PR validation, and deployment as separate evidence stages.

## 1. Audit

- Locate the execution report and gate manifest. If either is missing, stop and report what is needed.
- Audit the commit against the WI/plan and `.cursor/commands/execute-code-review.md`; apply the relevant rules from `.cursor/rules/005`, `060`, and `110`.
- Verify branch, tested tree fingerprint, committed paths, and gate coverage. Re-run only when required by the rules or when the tested tree cannot be tied to the commit.
- Findings block PR creation. Route code corrections to the implementer; require a fresh applicable gate and re-audit after changes.
- Record the audit verdict and any required governance/build-log update according to project rules.

## 2. PR and pipeline checks

- Read the current WI and project PR policy. Push the audited branch and open a PR only when the audit and required local gate pass.
- Wait for all required PR validations. Fix failures attributable to the change, then wait for their reruns. Do not treat pending or unrelated failed checks as green.
- Do not merge unless the user explicitly asked for a merge.

## 3. Deploy to Dev2

- After required PR checks pass, use the documented Azure DevOps environments pipeline (pipeline 139), with `deploymentTarget=dev2` and the audited branch. Confirm the run's `Build.SourceVersion` equals the audited commit; stop if it does not.
- Follow `devops/README.md` and `devops/docker-ambientes.yml`. Confirm the `DeployDev2` stage succeeds and the Dev2 health check returns HTTP 200.
- The deployment pipeline reads the Compose and `.env` installed on the server; it does not update their values from the repository. If the change depends on a server-side Compose or `.env` edit, stop and report the required admin action instead of claiming it was deployed.
- Run only the additional runtime smoke checks required by the WI/change. A healthy endpoint does not prove Keycloak flow behavior, email delivery, or other untested behavior.

## Stop conditions and report

Stop on an unresolved audit finding, failed required gate/check, commit/tree mismatch, unavailable deployment authorization/tooling, or unsuccessful Dev2 health check. Do not bypass checks or expose secrets.

Report the audit verdict, gate evidence, PR URL and validation results, pipeline run and deployed commit/image, Dev2 health result, and any runtime checks not performed. Do not claim merge, deployment, or behavioral proof without its corresponding evidence.
