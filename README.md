# System configuration flakes

## Layout

- [flake.nix](flake.nix) base of the configuration
- [hosts](hosts) per-host configurations that contain machine specific
  configurations
  - [desktop](hosts/desktop/) Desktop specific configuration
  
- [modules](modules) modularized NixOS configurations
  - [core](modules/core/) Core NixOS configuration
  - [homes](modules/home/) NixOS + home-manager configuration
- [wallpapers](wallpapers/) 🌄 wallpapers collection

## Components

|                             |              NixOS + Niri              |
| --------------------------- | :------------------------------------: |
| **Window Manager**          |              [Niri][Niri]              |
| **Bar**                     |            [Waybar][Waybar]            |
| **Application Launcher**    |              [rofi][rofi]              |
| **Notification Daemon**     |            [swaync][swaync]            |
| **Terminal Emulator**       |           [ghostty][ghostty]           |
| **Shell**                   |  [fish][fish] + [Starship][Starship]   |
| **Text Editor**             |    [Neovim][Neovim] via [nvf][nvf]     |
| **System resource monitor** |              [Btop][Btop]              |
| **File Manager**            |  [nemo][nemo] GUI + [yazi][yazi] TUI   |
| **Color Scheme**            |          [Nord/Nordic][Nord]           |
| **Cursor**                  | [Bibata-Modern-Ice][Bibata-Modern-Ice] |
| **Icons**                   |      [Papirus-Dark][Papirus-Dark]      |
| **Lockscreen**              |          [Swaylock][Swaylock]          |
| **Image Viewer**            |             [qview][qview]             |
| **Media Player**            |               [mpv][mpv]               |
| **Music Player**            |          [ncspot][ncspot] TUI          |
| **Screenshot Software**     |       [grim][grim] + [slurp][slurp]    |
| **Screen Recording**        |       [wf-recorder][wf-recorder]       |
| **Clipboard**               |   [wl-clip-persist][wl-clip-persist]   |
| **Color Picker**            |            Niri built-in               |

# Installation

- `git clone github.com/tomasguinzburg/nixos-config`
- `cd nixos-config`
- You may need to copy some wallpapers to `~/Pictures/wallpapers` for stuff to
  work properly
- `nixos-rebuild switch --flake .#desktop`

# Credits

- [Frost-Phoenix/nixos-config](https://github.com/Frost-Phoenix/nixos-config):
  Heavily based on this config, and indirectly inspired by dozens of other
  projects through it.

<div align="right">
  <a href="#readme">Back to the Top</a>
</div>

<!-- Links -->

[Niri]: https://github.com/niri-wm/niri
[ghostty]: https://github.com/ghostty-org/ghostty
[Starship]: https://github.com/starship/starship
[Waybar]: https://github.com/Alexays/Waybar
[rofi]: https://github.com/lbonn/rofi
[Btop]: https://github.com/aristocratos/btop
[nemo]: https://github.com/linuxmint/nemo/
[yazi]: https://github.com/sxyazi/yazi
[fish]: https://fishshell.com/
[Swaylock]: https://github.com/swaywm/swaylock
[audacious]: https://audacious-media-player.org/
[mpv]: https://github.com/mpv-player/mpv
[nvf]: https://github.com/NotAShelf/nvf
[Neovim]: https://github.com/neovim/neovim
[grim]: https://sr.ht/~emersion/grim/
[slurp]: https://github.com/emersion/slurp
[qview]: https://interversehq.com/qview/
[swaync]: https://github.com/ErikReider/SwayNotificationCenter
[Nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[NetworkManager]: https://wiki.gnome.org/Projects/NetworkManager
[network-manager-applet]: https://gitlab.gnome.org/GNOME/network-manager-applet/
[wl-clip-persist]: https://github.com/Linus789/wl-clip-persist
[wf-recorder]: https://github.com/ammen99/wf-recorder
[Papirus-Dark]: https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
[Bibata-Modern-Ice]: https://www.gnome-look.org/p/1197198
[ncspot]: https://github.com/hrkfdn/ncspot
[Nord]: https://github.com/EliverLara/Nordic
