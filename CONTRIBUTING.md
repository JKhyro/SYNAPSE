# Contributing to SYNAPSE

## Working Direction

`SYNAPSE` is Native C first. Avalonia is the shell host. Native C interop is the seam. C# is only for host bootstrap, UI composition, and interop glue where necessary.

Do not quietly move runtime ownership, launcher-core ownership, or section-boundary logic into managed code for convenience.

## Git Conventions

- open or link the relevant GitHub issue before starting implementation
- use branch names prefixed with `codex/`
- keep one coherent branch per bounded task
- write commit messages that describe the actual delta, not the intent alone
- update the linked issue, PR, and project card when execution state materially changes

## Pull Requests

Every pull request should state:

- the issue it closes or advances
- the exact repository or GitHub surfaces changed
- the validation that was run
- whether the Native C versus Avalonia boundary changed

Use `.github/pull_request_template.md` as the default structure.

## Repository Operating Surfaces

- `.github/ISSUE_TEMPLATE/` for structured issue intake
- `.github/pull_request_template.md` for PR writeback discipline
- `.github/CODEOWNERS` for review routing
- `infra/operator/GIT_GITHUB_INFRASTRUCTURE.md` for repo-level operating rules
- `infra/operator/GITHUB_THREAD_BOOTSTRAP.md` for a quick thread-start bootstrap
- `infra/operator/github_surface_catalog.json` for machine-readable metadata
- `infra/operator/verify_git_github_infrastructure.ps1` for local verification

## Local Validation

Run:

```powershell
powershell -ExecutionPolicy Bypass -File .\infra\operator\verify_git_github_infrastructure.ps1 -RepoRoot .
```

If GitHub auth is intentionally unavailable, use:

```powershell
powershell -ExecutionPolicy Bypass -File .\infra\operator\verify_git_github_infrastructure.ps1 -RepoRoot . -SkipGh
```
