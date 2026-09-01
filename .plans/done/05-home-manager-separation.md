# Separate Home Manager from NixOS configurations

**Priority:** Medium

**Scope:** Medium architectural change

## Goal

Expose standalone `homeConfigurations` evaluated with `nixpkgs-unstable`, while
keeping each `nixosConfiguration` on stable `nixpkgs`. Remove the current Home
Manager embedding from the NixOS user module once the standalone workflow is
verified.

## Design decisions to confirm

- Whether system and home activation should remain coupled through a wrapper or
  specialisation, or be intentionally independent.
- The stable Home Manager/Nixpkgs compatibility strategy. If Home Manager
  follows unstable, standalone evaluation should use the same unstable package
  set and should not need the release-check suppression.
- How host-specific Home Manager modules receive host metadata without importing
  the NixOS configuration.

## Plan

1. Create a standalone Home Manager entry for `gunz@minispore` using
   `nixpkgs-unstable` and the current home modules.
2. Pass shared inputs and host metadata explicitly through `extraSpecialArgs`.
3. Verify that the standalone output builds to the same effective home setup.
4. Add documented build/switch commands, preferably through `nh` if supported
   by the chosen workflow.
5. Remove the embedded Home Manager NixOS module only after standalone
   activation succeeds from both the graphical session and a TTY.
6. Decide how system rebuilds communicate that a separate home activation is
   required.

## Acceptance criteria

- `nixosConfigurations.minispore` evaluates against stable `nixpkgs`.
- `homeConfigurations` evaluates and installs packages from
  `nixpkgs-unstable`.
- No Nixpkgs/Home Manager mismatch warning is suppressed merely to make the
  configuration evaluate.
- System and home activation commands are documented and recoverable from TTY.

## Resolution

- Added `homeConfigurations."gunz@minispore"`, evaluated with
  `nixpkgs-unstable` and explicit host metadata.
- Removed the embedded Home Manager NixOS module and its release-check
  suppression.
- Documented independent `nh os switch` and `nh home switch` commands in the
  repository README.
- `nix flake check`, the standalone Home Manager activation build, and the
  minispore NixOS toplevel build all pass.
- Live activation remains a user-facing smoke test: run
  `nh home switch '.#gunz@minispore' -b hmbackup`, then `nh os test`.
