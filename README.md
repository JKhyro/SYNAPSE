# SYNAPSE

SYNAPSE is the suite shell, launcher, registry, and composition surface for programs inside programs.

It spans `CORTEX`, `VECTOR`, `FORGE`, `ANVIL`, and `NEXUS`, but it is not the canonical owner of those products' domain logic. SYNAPSE owns composition, entry, embedding, packaging, and suite navigation while the underlying native program units remain first-class.

## Core role

- package and launch suite-native program units
- host and embed child programs where a composed interface is useful
- maintain registry and section-entry contracts across the suite
- keep the suite shell distinct from the underlying product and runtime owners

## Implementation direction

- Native C is the default ownership lane for the underlying program units.
- C++ is allowed where it materially helps.
- Avalonia is the managed shell layer where a cross-platform desktop host is needed.
- C# is limited to host, bootstrap, packaging, and thin interop glue through an explicit C ABI.

## Cross-project boundaries

- `CORTEX` owns character construction and management.
- `VECTOR` owns workspace execution.
- `SYNAPSE` owns composition, launching, registry, embedding, and program-of-programs shell behavior.

See [docs/program-composition-doctrine.md](docs/program-composition-doctrine.md) for the current doctrine note.
