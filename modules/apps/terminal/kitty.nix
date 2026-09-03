{ ... }:
{
  flake.homeModules.kitty = _: {
    programs.kitty = {
      enable = true;
      font = {
        name = "FiraCode Nerd Font Mono";
        size = 16;
      };
      keybindings = {
        ## Tabs
        "alt+1" = "goto_tab 1";
        "alt+2" = "goto_tab 2";
        "alt+3" = "goto_tab 3";
        "alt+4" = "goto_tab 4";

        ## Unbind
        "ctrl+shift+left" = "no_op";
        "ctrl+shift+right" = "no_op";
      };
      settings = {
        active_tab_font_style = "normal";
        background_opacity = "1";
        confirm_os_window_close = 0;
        enable_audio_bell = false;
        inactive_tab_font_style = "normal";
        mouse_hide_wait = 60;
        scrollback_lines = 10000;
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
        ## Tabs
        tab_title_template = "{index}";
        window_padding_width = 10;
      };
      themeFile = "Nord";
    };
  };
}
