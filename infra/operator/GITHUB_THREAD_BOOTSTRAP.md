# SYNAPSE GitHub Thread Bootstrap

Use this repository-level bootstrap when a thread needs fast `SYNAPSE` Git and GitHub context.

## Repo and Project

- repository: `JKhyro/SYNAPSE`
- project: `JKhyro` project `#18`
- active infrastructure issue: `JKhyro/SYNAPSE#13`

## Quick Commands

```powershell
gh repo view JKhyro/SYNAPSE
gh issue list --repo JKhyro/SYNAPSE --limit 20
gh project item-list 18 --owner JKhyro --limit 200
git status --short --branch
powershell -ExecutionPolicy Bypass -File .\infra\operator\github_context_probe.ps1 -RepoRoot .
```

## Local Verification

```powershell
powershell -ExecutionPolicy Bypass -File .\infra\operator\verify_git_github_infrastructure.ps1 -RepoRoot .
```
