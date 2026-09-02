# Configuration roadmap

This directory tracks the next changes after the initial Hyprland-to-Niri
migration. The current Niri generation is usable, so the plan favors small,
verifiable improvements before restructuring the entire flake.

## Priorities

| Order | Workstream | Priority | Reason |
| --- | --- | --- | --- |
| 1 | [Add Codex to Home Manager](todo/01-codex-home-manager.md) | High | Makes the recovery and maintenance tool available after every activation and from a fresh login. |
| 2 | [Fix Ghostty](todo/02-ghostty.md) | High | Restores the primary terminal and removes a hard-coded system assumption. |
| 3 | [Restore Niri configuration parity](todo/03-niri-parity.md) | High | Fixes daily bindings and recovers the useful behavior of the previous desktop. |
| 4 | [Add an XBOOTLDR partition](todo/04-xbootldr.md) | High, maintenance window | Removes the recurring boot-partition capacity constraint, but requires careful partition work. |
| 5 | [Separate Home Manager from NixOS](todo/05-home-manager-separation.md) | Medium | Establishes a clean boundary before the broader module refactor. |
| 6 | [Adopt a dendritic module layout](todo/06-dendritic-migration.md) | Medium, incremental | Reduces program and compositor clutter without combining the migration into one risky rewrite. |
| 7 | [Replace the desktop shell with Noctalia](todo/07-noctalia.md) | Medium | Best implemented as an early consumer of the cleaner Home Manager/module structure. |
| 8 | [Fix Niri startup placement and bindings](todo/08-niri-startup-and-bindings.md) | High | Follow-up regression ticket for boot-time placement, look-and-feel initialization, and missing useful bindings. |

## Dependency and execution order

```text
Current bootable Niri baseline
├── Desktop usability: Codex -> Ghostty -> Niri parity
│                                      └-> Niri startup and bindings
├── Boot reliability: XBOOTLDR (independent maintenance window)
└── Architecture: separate Home Manager -> dendritic foundation
                                      └-> Noctalia migration
Niri parity -------------------------------------------------> Noctalia migration
```

The architectural work should not block the first three usability fixes. The
Noctalia migration should wait until the behavior worth preserving has been
identified and Home Manager has a stable standalone entry point.

## Working rules

- Pick up the lowest-numbered unblocked file in `todo/` unless priorities are
  deliberately changed.
- Work on one plan at a time. Keep its acceptance criteria current if the scope
  changes during implementation.
- When all acceptance criteria are satisfied and the change is verified, move
  the plan from `todo/` to `done/` without renumbering it.
- The filename number is the issue/order identifier and remains stable.
- Keep `minispore` as the only graphical target unless another host is made
  graphical explicitly.
- Preserve a known-good boot generation during desktop and bootloader changes.
- Make each architectural migration mechanical and independently reviewable;
  avoid mixing layout changes with behavior changes.
- Run `nix flake check` for every step and use `nh os test` for changes that
  affect the active system or desktop.
- Commit the current boot-size mitigation separately before beginning these
  workstreams.
