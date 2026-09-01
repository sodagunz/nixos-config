# Adopt a dendritic module layout

**Priority:** Medium, incremental

**Scope:** Large architectural migration

## Goal

Replace the current hierarchy of broad `base`, `workstation`, and program files
with feature-owned modules that can contribute flake, NixOS, and Home Manager
configuration from one place.

## Principles

- Organize by feature or capability rather than by configuration class.
- Keep each module responsible for a coherent feature, including its package,
  service, configuration files, and relevant options.
- Preserve host declarations as composition points, not collections of program
  configuration.
- Migrate incrementally and keep every commit evaluable.

## Plan

1. Choose and document the exact dendritic mechanism and module discovery
   convention. Evaluate a small `flake-parts`/import-tree style foundation
   before committing the entire repository to it.
2. Establish shared constructors or module classes for flake, NixOS, and Home
   Manager contributions.
3. Move one low-risk feature first (for example `fzf` or `yazi`) and verify the
   resulting option graph and output.
4. Migrate independent CLI/editor features, then desktop services, then Niri.
5. Use Noctalia as a real test of the feature boundary rather than adding it to
   the old workstation import list.
6. Remove old aggregation modules only after their imports are empty.
7. Add lightweight documentation explaining how to add a host and a feature.

## Acceptance criteria

- A feature's NixOS and Home Manager pieces live together and are discoverable.
- Hosts select capabilities without importing many program-specific files.
- No module is imported twice and no configuration relies on accidental import
  order.
- Each migration commit is behavior-preserving unless explicitly labelled
  otherwise.
