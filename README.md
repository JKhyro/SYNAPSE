# SYNAPSE

Suite shell for the packaged SYMBIOSIS control interface spanning CORTEX, VECTOR, FORGE, ANVIL, and NEXUS.

## Direction

- Native C owns core program logic, runtime boundaries, process control, and section entrypoints.
- Avalonia acts as the desktop shell, window composition layer, and managed host surface.
- Native C interop is the default seam between the shell and the core program surfaces.
- C# is limited to thin host bootstrap, UI composition, and interop glue where managed code is materially cheaper than reimplementing the same seam in Native C.

## Repository Baseline

This repository carries the Git and GitHub operating baseline needed to move `SYNAPSE` work through one coherent path:

- issue templates and PR template under `.github/`
- Git conventions and contribution rules in `CONTRIBUTING.md`
- operator documentation and repository verification under `infra/operator/`
- a machine-readable GitHub surface catalog for automation and validation

## Active Surfaces

- Repository: `JKhyro/SYNAPSE`
- Project: `JKhyro` project `#18` (`SYNAPSE`)
- Infrastructure lane: `JKhyro/SYNAPSE#13`
- Native host lane: `JKhyro/SYNAPSE#10`
- Package topology lane: `JKhyro/SYNAPSE#12`

## Scaffold

The first repository scaffold lives under:

- `src/native/synapse_core/` for the Native C section-entry contract and stub launch exports
- `src/host/Synapse.Host/` for the Avalonia shell host and thin interop glue
- `registry/synapse.topology.json` for package and launch topology metadata
- `docs/architecture/synapse-host-boundary.md` for the explicit runtime-boundary note

## Validation

Run the local infrastructure check from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\infra\operator\verify_git_github_infrastructure.ps1 -RepoRoot .
```

Use `-SkipGh` when you only need repository-file verification and do not want to query live GitHub.

Run the scaffold check from the repository root:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\verify_synapse_scaffold.ps1 -RepoRoot .
```

Use the thin build entrypoints when the local toolchain is available:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\build-native.ps1
powershell -ExecutionPolicy Bypass -File .\scripts\build-host.ps1
```
