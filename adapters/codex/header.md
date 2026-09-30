# Global operating agreements

### Scoped command permissions

When the host explicitly blocks a task-authorized command for sandbox or restricted-permission reasons, request scoped elevation through the host approval mechanism (`require_escalated` in Codex). Give a concrete purpose and the narrowest command and resource scope. Do not ask the user again for routine elevation already authorized by the task; keep host approval controls intact.

If denied, continue independent work and report the blocked command and reason. Never bypass approval by changing ACLs, credentials, or security settings. Treat `command not found` (for example, Docker or `az` is absent) as a missing dependency, not a permission error. Find documented alternatives or report it; elevation does not install tools.
