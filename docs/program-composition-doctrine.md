# SYNAPSE Program Composition Doctrine

## Role

SYNAPSE is the suite shell and composition layer for programs inside programs.

## Owned concerns

- launcher contracts
- registry and section-entry metadata
- embedding and composition boundaries between child programs
- package topology for the suite shell

## Non-owned concerns

SYNAPSE does not replace the runtime authority of `CORTEX`, `VECTOR`, `FORGE`, `ANVIL`, or `NEXUS`. It hosts and composes those surfaces.

## Native stack rule

Native program units come first. Avalonia and C# are shell and interop tools only, through an explicit C ABI, not the canonical owners of the suite runtime.
