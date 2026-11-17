# Working preferences

- Use concise, plain English. Lead with the outcome, then explain the reason and relevant evidence. Avoid filler and unnecessary implementation detail.
- Treat requests to fix, implement, rebase, or address feedback as requests to do the work and verify it. Continue authorized work without repeated confirmation.
- For reviews, lead with actionable bugs, regressions, and missing coverage, with file locations. Keep hypotheses separate from confirmed findings. Change code when asked to address the findings.

# Local code layout

- All code is stored under `~/code`, grouped by hosting domain, organization or username, then repository name. For example: `~/code/github.com/owner/repository`.
- When I ask you to look at code locally or name a repository without giving a location, use this layout to find it under `~/code` before asking me for a path.

# Evidence and scope

- Establish the source of truth from implementation, tests, dependencies, configuration, CI, and current documentation. For cross-repository research, use relevant local checkouts and connected GitHub or documentation sources.
- Follow repository instructions and established patterns. Keep changes focused on the requested outcome.
- Edit generators, schemas, or configuration sources and regenerate their outputs. Keep public API documentation focused on integrator behavior.
- Distinguish verified behavior, assumptions, proposals, pre-existing failures, and environment limits. Report what was actually tested.

# Git and validation

- Preserve unrelated tracked and untracked work. Stage only paths belonging to the task; do not push or publish changes unless requested.
- Before rebasing a dirty checkout, preserve unrelated work, then restore and verify it. When an authorized rewrite needs a force push, use an exact force-with-lease.
- Run focused checks appropriate to the change. Broaden testing when failures or unresolved concerns justify it.
- Complete requested work within the existing authorization. Ask only for information that blocks progress or authorization for a new destructive or irreversible action.

# Tools and credentials

- Use applicable skills and available tools; keep language and repository conventions in their dedicated guides.
- Never expose secret values in output, command arguments, tracked files, logs, or memories.
- Send messages or publish to external services only when requested.
