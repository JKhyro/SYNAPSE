param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path,
    [switch]$SkipGh
)

$ErrorActionPreference = "Stop"

function Add-Result {
    param(
        [System.Collections.Generic.List[object]]$Results,
        [string]$Name,
        [bool]$Ok,
        [string]$Detail
    )

    $Results.Add([pscustomobject]@{
        name = $Name
        ok = $Ok
        detail = $Detail
    })
}

$results = [System.Collections.Generic.List[object]]::new()

if (-not (Test-Path $RepoRoot)) {
    throw "Repository root not found: $RepoRoot"
}

Add-Result -Results $results -Name "repo-root" -Ok $true -Detail $RepoRoot

$catalogPath = Join-Path $RepoRoot "infra\operator\github_surface_catalog.json"
if (-not (Test-Path $catalogPath)) {
    Add-Result -Results $results -Name "catalog-load" -Ok $false -Detail $catalogPath
    $results | Format-Table -AutoSize
    throw "Git and GitHub infrastructure verification failed."
}

$catalog = Get-Content $catalogPath -Raw | ConvertFrom-Json
Add-Result -Results $results -Name "catalog-load" -Ok $true -Detail $catalogPath

foreach ($relativePath in $catalog.required_files) {
    $fullPath = Join-Path $RepoRoot $relativePath
    Add-Result -Results $results -Name ("required-file:" + $relativePath) -Ok (Test-Path $fullPath) -Detail $fullPath
}

$origin = ""
try {
    $origin = git -C $RepoRoot remote get-url origin
    Add-Result -Results $results -Name "git-origin" -Ok ($origin -eq "https://github.com/JKhyro/SYNAPSE.git") -Detail $origin
}
catch {
    Add-Result -Results $results -Name "git-origin" -Ok $false -Detail $_.Exception.Message
}

try {
    $branch = (git -C $RepoRoot rev-parse --abbrev-ref HEAD).Trim()
    $branchOk = ($branch -eq $catalog.repository.default_branch) -or $branch.StartsWith($catalog.repository.branch_prefix)
    Add-Result -Results $results -Name "branch-policy" -Ok $branchOk -Detail ("branch=" + $branch + "; prefix=" + $catalog.repository.branch_prefix)
}
catch {
    Add-Result -Results $results -Name "branch-policy" -Ok $false -Detail $_.Exception.Message
}

if ($catalog.project.number -eq 18) {
    Add-Result -Results $results -Name "catalog-project-number" -Ok $true -Detail "18"
}
else {
    Add-Result -Results $results -Name "catalog-project-number" -Ok $false -Detail ("project=" + $catalog.project.number)
}

if (-not $SkipGh) {
    try {
        $repoJson = gh repo view $catalog.repository.slug --json nameWithOwner,defaultBranchRef,url | ConvertFrom-Json
        $repoOk = ($repoJson.nameWithOwner -eq $catalog.repository.slug) -and ($repoJson.defaultBranchRef.name -eq $catalog.repository.default_branch)
        Add-Result -Results $results -Name "gh-repo-view" -Ok $repoOk -Detail ($repoJson.url)
    }
    catch {
        Add-Result -Results $results -Name "gh-repo-view" -Ok $false -Detail $_.Exception.Message
    }

    try {
        $issueJson = gh issue view $catalog.issues.infrastructure --repo $catalog.repository.slug --json number,title,state,url | ConvertFrom-Json
        $issueOk = ($issueJson.number -eq $catalog.issues.infrastructure) -and ($issueJson.state -eq "OPEN")
        Add-Result -Results $results -Name "gh-infrastructure-issue" -Ok $issueOk -Detail ($issueJson.url)
    }
    catch {
        Add-Result -Results $results -Name "gh-infrastructure-issue" -Ok $false -Detail $_.Exception.Message
    }
}

$results | Format-Table -AutoSize

if (($results | Where-Object { -not $_.ok }).Count -gt 0) {
    throw "Git and GitHub infrastructure verification failed."
}
