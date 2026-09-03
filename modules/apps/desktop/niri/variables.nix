{ ... }:
{
  flake.homeModules.niri = { ... }: {
    home.sessionVariables = {
      ANKI_WAYLAND = "1";
      CLUTTER_BACKEND = "wayland";
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland";
      GTK_THEME = "Nordic";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "xcb";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_SCALE_FACTOR = "2";
      QT_STYLE_OVERRIDE = "kvantum";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      WLR_DRM_NO_ATOMIC = "1";
      XDG_SESSION_TYPE = "wayland";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
    };
  };
}
