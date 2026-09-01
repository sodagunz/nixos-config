# Add Codex to Home Manager

**Priority:** High

**Scope:** Small

## Goal

Install Codex declaratively through the unstable Home Manager package set so it
is available in graphical sessions, TTYs, and fresh logins without relying on an
ambient or manually installed binary.

## Plan

1. Confirm the package name and version in the current `nixpkgs-unstable` input.
2. Add it to an appropriate Home Manager CLI/development module rather than a
   host-wide NixOS package list.
3. Keep Codex state and authentication in the normal persistent home location
   (`~/.codex`); do not place credentials in the Nix store.
4. Verify `codex --version` and `codex resume` from a new shell and from a TTY.

## Acceptance criteria

- `codex` resolves from the Home Manager profile on `minispore`.
- No global npm/manual installation is required.
- Existing sessions and authentication remain available after activation.
