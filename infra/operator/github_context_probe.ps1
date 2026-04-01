param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
)

$ErrorActionPreference = "Stop"

$catalogPath = Join-Path $RepoRoot "infra\operator\github_surface_catalog.json"
$catalog = Get-Content $catalogPath -Raw | ConvertFrom-Json

$gitStatus = git -C $RepoRoot status --short --branch
$remote = git -C $RepoRoot remote get-url origin

$issues = gh issue list --repo $catalog.repository.slug --limit 10 --json number,title,state,updatedAt | ConvertFrom-Json

[pscustomobject]@{
    repo_root = $RepoRoot
    repository = $catalog.repository.slug
    project = $catalog.project.title
    infrastructure_issue = $catalog.issues.infrastructure
    branch_prefix = $catalog.repository.branch_prefix
    remote = $remote
    git_status = $gitStatus
    recent_issues = $issues
} | ConvertTo-Json -Depth 6
