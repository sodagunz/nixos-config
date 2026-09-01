# Replace Waybar and companion services with Noctalia

**Priority:** Medium

**Scope:** Medium

## Goal

Use Noctalia as the Niri desktop shell and remove redundant components such as
Waybar, SwayNC, SwayOSD, the launcher, and possibly the current lock/background
tools where Noctalia provides a satisfactory replacement.

## Dependencies

- Niri bindings and desired desktop behavior have been inventoried.
- Standalone Home Manager is working.
- Preferably, the dendritic feature-module foundation exists so Noctalia becomes
  a self-contained desktop feature rather than more workstation clutter.

## Plan

1. Enable the native unstable Home Manager `programs.noctalia` module with a
   minimal configuration and autostart it from Niri.
2. Confirm required system services. NetworkManager and Bluetooth are already
   expected; evaluate UPower and power-profiles-daemon before enabling related
   widgets.
3. Recreate the current essentials: workspace display, tray, clock, networking,
   Bluetooth, audio, brightness, notifications, media, power/session actions,
   and launcher behavior.
4. Move Niri bindings from the old tools to Noctalia commands one group at a
   time.
5. Disable Waybar, SwayNC, SwayOSD, Rofi, and overlapping lock/background tools
   only after their replacements are verified.
6. Match the existing theme deliberately after functionality is stable.

## Acceptance criteria

- Noctalia starts reliably with Niri and exposes the required controls.
- There is only one provider for each bar, notification, OSD, launcher, and lock
  function.
- Removed components no longer start or remain in the active package/config
  graph unless retained for a documented reason.
- Logout, suspend, lock, audio, brightness, and network controls work before the
  old components are removed.
