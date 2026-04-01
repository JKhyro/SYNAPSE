# SYNAPSE Host and Native Boundary

## Ownership

- Native C owns runtime-facing section boundaries, launch entrypoints, and core shell contract exports.
- Avalonia owns desktop shell presentation, navigation chrome, and window composition.
- C# owns only the host bootstrap, interop glue, and UI-local state needed to present the shell.

## Repository Mapping

- Native contract: `src/native/synapse_core/include/synapse_shell_contract.h`
- Native implementation: `src/native/synapse_core/src/synapse_shell_contract.c`
- Avalonia host: `src/host/Synapse.Host/`
- Package topology metadata: `registry/synapse.topology.json`

## Guardrails

- Do not move launch routing, runtime identity, or lifecycle ownership into managed code.
- Treat the topology manifest as package metadata, not as runtime truth.
- Keep section launch stubs callable from the host through explicit Native C exports rather than managed section ownership.

## Current State

This scaffold intentionally stops at:

- shell navigation chrome
- section metadata display
- native interop contract definitions
- stub native launch entrypoints for `CORTEX`, `VECTOR`, `FORGE`, `ANVIL`, and `NEXUS`

It does not yet implement real section runtime activation.
