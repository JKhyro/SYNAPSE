function Resolve-SynapseToolchainPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ToolName
    )

    $candidates = switch ($ToolName) {
        "dotnet" { @("$env:ProgramFiles\\dotnet\\dotnet.exe") }
        "cmake" { @("$env:ProgramFiles\\CMake\\bin\\cmake.exe") }
        default { @() }
    }

    foreach ($candidate in $candidates) {
        if (Test-Path $candidate) {
            return (Resolve-Path $candidate).Path
        }
    }

    $command = Get-Command $ToolName -ErrorAction SilentlyContinue
    if ($command) {
        return $command.Source
    }

    return $null
}
