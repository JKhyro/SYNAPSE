param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
    [string]$BuildDir = ""
)

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "resolve-toolchain.ps1")

$cmake = Resolve-SynapseToolchainPath -ToolName "cmake"
if (-not $cmake) {
    throw "cmake was not found. Install CMake or add it to PATH before building the Native C scaffold."
}

if ([string]::IsNullOrWhiteSpace($BuildDir)) {
    $BuildDir = Join-Path $RepoRoot "artifacts\native"
}

New-Item -ItemType Directory -Force -Path $BuildDir | Out-Null

& $cmake -S $RepoRoot -B $BuildDir
& $cmake --build $BuildDir --config Debug
