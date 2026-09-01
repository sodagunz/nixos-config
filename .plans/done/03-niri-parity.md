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

## Target parity checklist

- [x] Login starts Firefox fullscreen on workspace 1.
- [x] Login starts Ghostty fullscreen on workspace 2.
- [x] `Mod+1..0` focuses workspaces 1 through 10.
- [x] `Mod+Shift+1..0` moves the focused column to workspaces 1 through 10.
- [x] `Mod+H/J/K/L` moves focus and `Mod+Shift+H/J/K/L` moves the focused
  column/window.
- [x] `Mod+F` toggles fullscreen.
- [x] `Mod+Escape` locks and `Mod+Shift+Escape` opens the power menu.
- [x] `Mod+W/A/D/Z/E` opens Firefox, Ghostty, Discord, Zed, and Nemo.
- [x] `Mod+Space` opens Rofi and `Mod+V` opens clipboard selection in Rofi.
- [x] `Mod+T` toggles the focused window between rule opacity and opaque.
- [x] Firefox, Ghostty, Discord, and Zed open fullscreen.
- [x] Screenshots, media keys, brightness keys, mouse-focus, output settings,
  and theming remain functional.

The generated configuration validates with Niri 26.04 and the full Home Manager
activation builds. Check the items above after activation before moving this
issue to `done/`.
