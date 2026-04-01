param(
    [string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
)

$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "resolve-toolchain.ps1")

$dotnet = Resolve-SynapseToolchainPath -ToolName "dotnet"
if (-not $dotnet) {
    throw "dotnet was not found. Install the .NET SDK or add it to PATH before building the Avalonia host."
}

$project = Join-Path $RepoRoot "src\host\Synapse.Host\Synapse.Host.csproj"

& $dotnet restore $project
& $dotnet build $project -c Debug
