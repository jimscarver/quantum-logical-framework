# Repository Layout

The repository now separates formal proofs, importable Python, executable
experiments, and long-form documentation.

| Path | Purpose |
|---|---|
| `README.md` | Project overview and current entry point. |
| `CLAUDE.md` | Agent/project operating notes. |
| `lean/` | Lean 4 formalization; module roots remain unchanged. |
| `src/qlf/` | Importable Python package for reusable QLF engines and helpers. |
| `experiments/` | Standalone demonstrations, empirical reports, and simulations. |
| `docs/` | Conceptual, physics, formal, computing, research, personal, and asset documentation. |
| `tests/` | Python, documentation, and Lean inventory guardrails. |
| `tools/` | Auxiliary repository tools, including Markdown link checking. |

Root-level Markdown route files are lightweight forwarders to preserve key
public links while the canonical documents live under `docs/`. See
[migration-map.md](migration-map.md) for the old-path to new-path map.
