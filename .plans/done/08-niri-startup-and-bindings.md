# Fix Niri startup placement and bindings

**Priority:** High

**Scope:** Medium

## Symptoms

- Firefox and Ghostty do not consistently open on the intended workspaces at
  login.
- Firefox and Ghostty do not consistently open at the intended fullscreen or
  size state.
- Niri's look and feel is not consistently initialized correctly on boot.
- The Niri help dialog/default bindings expose useful actions that are missing
  from the reduced custom binding set.

## Plan

1. Capture the exact boot state with `niri msg windows`, including app IDs,
   workspace indices, fullscreen state, and window dimensions.
2. Inspect the Niri user journal from the compositor start through application
   startup for rejected rules, timing issues, or missing commands.
3. Verify the actual Firefox and Ghostty app IDs and whether `at-startup=true`
   matches their startup-created windows.
4. Make startup deterministic: ensure the applications are launched once,
   assigned to workspaces after their windows exist, and given the desired
   fullscreen/size behavior.
5. Compare `niri msg action` and the built-in hotkey overlay with the current
   custom bindings. Add useful missing defaults in small groups, preserving the
   intentionally trimmed configuration.
6. Restore look-and-feel startup dependencies (background, bar/notifications,
   cursor, environment, and any replacement shell) only where logs show they
   are required.
7. Validate the generated KDL, build Home Manager, activate, and test across a
   fresh login and a reboot.

## Acceptance criteria

- Firefox reliably starts on workspace 1 with the intended fullscreen/size
  state.
- Ghostty reliably starts on workspace 2 with the intended fullscreen/size
  state.
- Niri startup logs contain no configuration or startup-placement errors.
- The help overlay is available and the selected useful default bindings are
  represented in the custom configuration.
- Look-and-feel components initialize consistently after login and reboot.

## Notes

The previous parity issue (`03-niri-parity`) remains complete. This ticket is a
follow-up for behavior that only became apparent during real boot testing.

