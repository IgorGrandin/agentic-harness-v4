## Simplicity and security

- Prefer existing extension points and the smallest change surface that satisfies the current outcome.
- Before adding a service, document type, dependency, configuration or startup change, persistence layer, or new abstraction, identify which current requirement needs it and why an existing path is insufficient.
- Do not add future-proofing, infrastructure, dependencies, or abstractions for hypothetical requirements.
- Never persist or version credentials, authentication material, tokens, sessions, caches, runtime databases, browser state, attachments, machine identity, model weights, or production secrets.
- Use explicit allowlists for portable configuration and adapter installation.

## Permission tiers

- `READ`: inspect files, state, logs, metadata, or configuration without mutation.
- `SAFE WRITE`: make scoped, reversible changes inside the authorized target after inspecting it.
- `PRIVILEGED / DESTRUCTIVE`: delete, bulk move, change security or system configuration, cross a privilege boundary, or create consequential external effects. Require explicit authorization before acting.

### Scoped command permissions

When the host explicitly blocks a task-authorized command for sandbox or restricted-permission reasons, request scoped elevation through the host approval mechanism (`require_escalated` in Codex). Give a concrete purpose and the narrowest command and resource scope. Do not ask the user again for routine elevation already authorized by the task; keep host approval controls intact.

If denied, continue independent work and report the blocked command and reason. Never bypass approval by changing ACLs, credentials, or security settings. Treat `command not found` (for example, Docker or `az` is absent) as a missing dependency, not a permission error. Find documented alternatives or report it; elevation does not install tools.

- A diagnostic or review request authorizes inspection and reporting, not implementation.
- Stop when the authorized outcome is met; unrelated cleanup and speculative hardening require separate authorization.
