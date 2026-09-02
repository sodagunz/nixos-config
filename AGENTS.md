# AGENTS.md

## Architecture

This is a flake-parts configuration that loosely follows the dendritic pattern:
features own their NixOS and Home Manager sides, and their path names express
organisation rather than evaluation order. `flake.nix` imports the public entry
points automatically with `import-tree`.

- `apps/` contains user-facing configuration. Keep `apps/desktop` flat; use
  deeper groups only when they make a feature easier to find.
- `system/` contains NixOS features; shared defaults live in `system/core.nix`,
  with services grouped under `system/services`.
- `profiles/` combines exported features into `base`, `server`, and
  `workstation` configurations.
- `machines/<name>.nix` owns that machine's NixOS and Home Manager modules and
  self-registers both outputs; `machines/<name>/` contains only independently
  imported hardware and optional Disko fragments.
- `flake/` holds the shared constructors and output-option plumbing.

Every `.nix` file under `modules/` is a flake-parts module that `import-tree`
discovers automatically. Prefer a single `feature.nix` file. When a feature has
associated assets or genuinely separate implementation facts, keep them in a
sibling `feature/` directory and have each Nix file contribute independently to
the same deferred module. Public feature names under `flake.nixosModules` and
`flake.homeModules` are interfaces used by profiles and machines.

## How to make a change

1. Inspect `git status` and the relevant profile/machine before editing. Keep
   unrelated user changes intact.
2. Put a new user program in `apps/` and a new OS concern in `system/`. Give a
   program with its own configuration or launcher its own feature; use
   `apps/tools` only for genuinely general package bundles.
3. Export the feature from its public `.nix` module, then add it to the
   appropriate profile. Do not import individual features from a machine unless
   the feature is truly machine-specific.
4. Keep shared policy in features or profiles. Keep hardware, host IDs, disks,
   and machine-specific service facts in `machines/<name>`.
5. Preserve the package-set split: NixOS uses stable `nixpkgs`; standalone Home
   Manager uses `nixpkgs-unstable`.

## Verify and hand off

- After changing configuration, run `treefmt <changed paths>`. The repository's
  `treefmt.toml` formats Nix, shell, TOML, KDL, and YAML, and `nix fmt` exposes
  the same formatter through the flake. Use `treefmt --ci` when a no-rewrite
  check is needed.
- Then run `nix flake check --no-build`; build the affected NixOS
  `config.system.build.toplevel` or Home Manager `activationPackage` with
  `nix build --no-link` when practical.
- For documentation-only changes, run `git diff --check`.
- Do not run `nh ... switch`, `nixos-rebuild switch`, or another activation
  command unless explicitly requested.
- Stage and commit only when requested. Use a conventional commit subject and
  include the repository's `Assisted-by` trailer.
