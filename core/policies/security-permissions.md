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
- When an authorized command is blocked solely by sandbox or host access restrictions, request the narrowest permission through the active runtime's approval mechanism. State the exact command, resource, and purpose. Existing task authorization for scoped elevation is sufficient; do not ask the user again before submitting the routine request. Host approval is still required.
- If permission is denied, continue independent work and report the exact blocked command and reason. Never bypass approval or change ACLs, credentials, or security controls to work around the denial.
- Distinguish access-denied failures from missing executables or unavailable services. A permission request does not install a tool or start a missing service; use a documented alternative or report the prerequisite.
- A diagnostic or review request authorizes inspection and reporting, not implementation.
- Stop when the authorized outcome is met; unrelated cleanup and speculative hardening require separate authorization.
