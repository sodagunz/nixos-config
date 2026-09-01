# Fix Ghostty

**Priority:** High

**Scope:** Small to medium

## Current concerns

The Home Manager module selects
`inputs.ghostty.packages.x86_64-linux.default` directly. This is brittle and may
not agree with the package set or system used to evaluate the configuration.
The failure mode still needs to be captured before changing configuration.

## Plan

1. Launch Ghostty from a TTY or another terminal and record stderr and relevant
   user-journal messages.
2. Determine whether the problem is package startup, graphics/backend support,
   shell integration, or the existing Ghostty configuration/theme.
3. Replace the hard-coded architecture lookup with a system-aware package, or
   use the unstable `pkgs.ghostty` package if the separate input is no longer
   necessary.
4. Temporarily test with an empty/minimal Ghostty config to distinguish package
   failures from configuration failures.
5. Restore settings incrementally and verify launch under Niri.

## Acceptance criteria

- Ghostty starts reliably from a Niri binding and from another terminal.
- The module contains no hard-coded `x86_64-linux` package selection.
- Errors are absent from the user journal during a normal launch.

## Resolution

- Replaced the dedicated Ghostty flake package with `pkgs.ghostty` from the
  unstable Home Manager package set and removed the obsolete flake input.
- Removed the deprecated `bold-is-bright` setting; its `false` behavior is the
  current default.
- Built the full minispore Home Manager activation with Ghostty 1.3.1.
- Launched the built binary under Niri using the managed configuration. It
  initialized OpenGL 4.6, ran its child command, and exited normally without the
  previous EGL error or core dump.
