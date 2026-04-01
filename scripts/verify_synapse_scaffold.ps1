param(
    [string]$RepoRoot = (Resolve-Path ".").Path
)

$ErrorActionPreference = "Stop"

$requiredFiles = @(
    "SYNAPSE.sln",
    "CMakeLists.txt",
    "Directory.Build.props",
    "docs/architecture/synapse-host-boundary.md",
    "registry/synapse.topology.json",
    "src/native/CMakeLists.txt",
    "src/native/synapse_core/CMakeLists.txt",
    "src/native/synapse_core/include/synapse_shell_contract.h",
    "src/native/synapse_core/src/synapse_shell_contract.c",
    "src/host/Synapse.Host/Synapse.Host.csproj",
    "src/host/Synapse.Host/Program.cs",
    "src/host/Synapse.Host/App.axaml",
    "src/host/Synapse.Host/App.axaml.cs",
    "src/host/Synapse.Host/ViewModels/MainWindowViewModel.cs",
    "src/host/Synapse.Host/Interop/NativeSynapseBridge.cs",
    "src/host/Synapse.Host/Views/MainWindow.axaml",
    "src/host/Synapse.Host/Views/MainWindow.axaml.cs"
)

$results = foreach ($relativePath in $requiredFiles) {
    $fullPath = Join-Path $RepoRoot $relativePath
    [pscustomobject]@{
        name = $relativePath
        ok = Test-Path $fullPath
    }
}

$topologyPath = Join-Path $RepoRoot "registry/synapse.topology.json"
$topology = Get-Content $topologyPath -Raw | ConvertFrom-Json
$sectionCountOk = $topology.sections.Count -eq 5
$boundaryOk = $topology.boundary.coreRuntimeOwner -eq "native-c" -and $topology.boundary.shellHost -eq "avalonia"

$results += [pscustomobject]@{ name = "topology.section-count"; ok = $sectionCountOk }
$results += [pscustomobject]@{ name = "topology.boundary"; ok = $boundaryOk }

$results | Format-Table -AutoSize

if (($results | Where-Object { -not $_.ok }).Count -gt 0) {
    throw "SYNAPSE scaffold verification failed."
}
