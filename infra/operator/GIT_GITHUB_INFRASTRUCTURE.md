# SYNAPSE Git and GitHub Infrastructure

## Purpose

This document defines the baseline repository surfaces that keep `SYNAPSE` execution coherent across local Git, GitHub issues, pull requests, and the `SYNAPSE` project board.

## Canonical Targets

- repository: `JKhyro/SYNAPSE`
- project: `JKhyro` project `#18` (`SYNAPSE`)
- infrastructure issue: `JKhyro/SYNAPSE#13`
- linked execution lanes:
  - `JKhyro/SYNAPSE#8`
  - `JKhyro/SYNAPSE#10`
  - `JKhyro/SYNAPSE#12`

## Required Repository Surfaces

- `.gitignore`
- `.gitattributes`
- `.github/CODEOWNERS`
- `.github/ISSUE_TEMPLATE/config.yml`
- `.github/ISSUE_TEMPLATE/bug_report.yml`
- `.github/ISSUE_TEMPLATE/feature_request.yml`
- `.github/ISSUE_TEMPLATE/git_github_infrastructure.yml`
- `.github/pull_request_template.md`
- `.github/workflows/git-github-infrastructure.yml`
- `CONTRIBUTING.md`
- `infra/operator/GITHUB_THREAD_BOOTSTRAP.md`
- `infra/operator/github_context_probe.ps1`
- `infra/operator/github_surface_catalog.json`
- `infra/operator/verify_git_github_infrastructure.ps1`

## Working Rules

- open or link a GitHub issue before implementation starts
- use `codex/` branch names
- keep GitHub issue, PR, and project-card state synchronized when execution meaningfully changes
- preserve the Native C first, Avalonia second, interop seam third direction in repo metadata and docs

## Verification

Run from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\infra\operator\verify_git_github_infrastructure.ps1 -RepoRoot .
```

Use `-SkipGh` when live GitHub checks are intentionally unavailable.

## Workflow Publishing Note

Workflow files require GitHub credentials that are permitted to create or update `.github/workflows/*`. If that scope is unavailable, keep the workflow file in the local branch, push the remaining baseline through a GitHub-safe branch, and record the blocker on the active issue and PR.
