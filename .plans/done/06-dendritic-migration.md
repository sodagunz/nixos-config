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

## Foundation decision

Use `flake-parts` with `import-tree` over a new `parts/` tree. Existing
`modules/` remains a legacy tree during the migration; importing it recursively
would incorrectly evaluate its NixOS and Home Manager modules as flake-parts
modules.

Each feature in `parts/<feature>/default.nix` may expose one or more of:

- `flake.nixosModules.<feature>`
- `flake.homeModules.<feature>`
- flake-wide outputs/options when the feature owns them

Hosts compose those exports explicitly through `self.nixosModules` and
`self.homeModules`. This retains clear host capability selection while keeping a
feature's flake and module contributions together.

The first migration is Codex: it now exposes `flake.homeModules.codex` from
`parts/codex`, and minispore imports that feature directly. `nix flake check`
and the standalone Home Manager activation build pass with this pattern.

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

## Completed

- Added `flake-parts` and `import-tree`, with implementation files hidden below
  underscore-prefixed paths.
- Migrated the active Home Manager and NixOS configuration into feature-owned
  modules under `parts/`.
- Added `workstation`, `base`, and `server` profiles so hosts select coherent
  capabilities rather than individual program files.
- Removed the legacy `modules/` tree and its aggregation layers.
- Documented how to add features and hosts in the repository README.
- Verified every migration checkpoint with `nix flake check`; also built the
  standalone minispore Home Manager activation package.
