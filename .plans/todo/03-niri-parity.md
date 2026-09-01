# Restore Niri configuration parity

**Priority:** High

**Scope:** Medium

## Goal

Recover the useful behavior of the previous Hyprland desktop while keeping
Niri-native concepts and defaults where they are a better fit.

## Plan

1. Inventory the old Hyprland bindings, autostart commands, output settings,
   environment variables, input settings, rules, screenshots, media controls,
   and session actions.
2. Compare that inventory with the current `config.kdl` and mark each item as:
   preserved, intentionally changed for Niri, missing, or broken.
3. Fix the daily-use bindings first: terminal, launcher, browser, close window,
   focus/move, workspaces, monitor movement, screenshots, volume, brightness,
   lock, logout, suspend, and power actions.
4. Validate Niri syntax after each group of edits and inspect the Niri user
   service log for rejected bindings or startup commands.
5. Split generated values from the main KDL only when it improves ownership;
   avoid redesigning the entire module during parity work.
6. Record which shell components will later be replaced by Noctalia so they are
   not needlessly polished twice.

## Acceptance criteria

- All common actions have documented, working bindings.
- Output, input, startup, and window-rule behavior is intentional.
- Niri starts without configuration errors.
- A short parity checklist remains in the module or its documentation for later
  regressions.
