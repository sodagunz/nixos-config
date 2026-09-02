# nixos-config

Nixos configs for my users and machines.

## Table of contents

- [Layout](#layout)
- [Adding configuration](#adding-configuration)
- [Rebuilding](#rebuilding)
- [Components](#components)
- [Credits](#credits)

## Layout

This configuration loosely uses the [dendritic pattern][Dendritic]: a feature owns
the NixOS and Home Manager and Darwin configuration that belongs to it, rather than being
split by configuration type, except in that they are in any of the following root directories:

- [apps](apps) holds user-facing programs. `desktop` is intentionally flat;
  `dev`, `gaming`, `shell`, `terminal`, and `tools` group related programs when
  useful.
- [system](system) holds operating-system configuration, including
  `services`.
- [profiles](profiles) reusable base, server, and workstation setups. Stuff I would
  normally want in every machine of it's kind.
- [machines](machines) holds machine-specific configurations. Each machine registers its
  own NixOS and Home Manager outputs, and selects the modules it will use.
- [lib](lib) contains the shared flake-parts plumbing.

Each public feature directory has a `default.nix` entry point. Put its private
implementation and assets behind an underscore-prefixed name such as
`_module.nix` or `_nixos.nix`; as `import-tree` does not import those paths on its
own.

## Adding configuration

### Feature

Create a feature under the functional root where it belongs, for example
`apps/dev/example/default.nix`. Export a Home Manager module through
`flake.homeModules`, a NixOS module through `flake.nixosModules`, or both; then
add that capability to the appropriate profile.

```nix
{ ... }:
{
  flake.homeModules.example = import ./_module.nix;
  flake.nixosModules.example = import ./_nixos.nix;
}
```

### Machine

Create `machines/<hostname>/default.nix` to register a new machine's NixOS and
Home Manager outputs. Keep its NixOS, Home Manager, hardware, and optional
Disko modules in underscore-prefixed sibling files. You can then import features
individually, or build up from one of the base profiles.

## Rebuilding

```console
nh os switch .#minispore
nh home switch '.#gunz@minispore' -b hmbackup
```

Normally OS is on nixpkgs and home-manager on nixpkgs-unstable, so they each use
their own dedicated config. I keep home-manager config uncoupled from system config,
as otherwise I need to maintain separate config for any machine not running nixos.

```console
nix flake check --no-build
```

## Desktop Components

| Component             | Configuration                                                        |
| --------------------- | -------------------------------------------------------------------- |
| Window manager        | [Niri][Niri]                                                         |
| Desktop shell         | [Noctalia][Noctalia]                                                 |
| Browser               | [Firefox][Firefox]                                                   |
| Terminals             | [Ghostty][Ghostty] and [Kitty][Kitty]                                |
| Shell                 | [Fish][Fish] with [Starship][Starship]                               |
| Editors               | [Zed][Zed], [Neovim][Neovim] via [NVF][NVF], [Helix][Helix]          |
| File managers         | [Nemo][Nemo] and [Yazi][Yazi]                                        |
| Video and music       | [mpv][mpv], [VLC][VLC], and [ncspot][ncspot]                         |
| Resource monitoring   | [Btop][Btop] and [Resources][Resources]                              |
| Audio                 | [PipeWire][PipeWire]                                                 |
| Screen recording      | [wf-recorder][wf-recorder] with [slurp][slurp]                       |
| Colour scheme         | [Nord][Nord]-Night, as featured by [Ghostty][Ghostty]                |
| Icons                 | [Nordzy][Nordzy]                                                     |
| Cursor                | [Bibata Modern Ice][Bibata]                                          |
| Fonts                 | [Montserrat][Montserrat] and [Nerd Fonts][Nerd Fonts]                |

## Server Components

| Component             | Configuration                                                        |
| --------------------- | -------------------------------------------------------------------- |
| Media streaming       | [Jellyfin][Jellyfin]                                                 |
| File sharing          | [Copyparty][Copyparty] and NFS                                       |
| Media management      | [*arr services][Servarr] and Transmission                            |
| Reverse proxy         | Not configured                                                       |
| Emulation             | Reserved; no emulator is installed                                   |

## Credits

- [Frost-Phoenix/nixos-config][Frost-Phoenix] is the original foundation for
  this configuration.
- [mightyiam/dendritic][Dendritic] documents the module-system pattern that
  informs its feature-oriented structure.

[Dendritic]: https://github.com/mightyiam/dendritic
[Bibata]: https://github.com/ful1e5/Bibata_Cursor
[Btop]: https://github.com/aristocratos/btop
[Copyparty]: https://github.com/9001/copyparty
[Fish]: https://fishshell.com/
[Firefox]: https://www.mozilla.org/firefox/
[Frost-Phoenix]: https://github.com/Frost-Phoenix/nixos-config
[Ghostty]: https://github.com/ghostty-org/ghostty
[Helix]: https://helix-editor.com/
[Jellyfin]: https://jellyfin.org/
[Kitty]: https://sw.kovidgoyal.net/kitty/
[Montserrat]: https://fonts.google.com/specimen/Montserrat
[Nemo]: https://github.com/linuxmint/nemo/
[Nerd Fonts]: https://www.nerdfonts.com/
[Niri]: https://github.com/niri-wm/niri
[ncspot]: https://github.com/hrkfdn/ncspot
[Noctalia]: https://github.com/noctalia-dev/noctalia
[Nord]: https://www.nordtheme.com/
[Nordzy]: https://github.com/alvatip/Nordzy-icon
[Neovim]: https://neovim.io/
[NVF]: https://github.com/NotAShelf/nvf
[PipeWire]: https://pipewire.org/
[Resources]: https://apps.gnome.org/Resources/
[Servarr]: https://wiki.servarr.com/
[Starship]: https://starship.rs/
[slurp]: https://github.com/emersion/slurp
[VLC]: https://www.videolan.org/vlc/
[wf-recorder]: https://github.com/ammen99/wf-recorder
[Yazi]: https://yazi-rs.github.io/
[Zed]: https://zed.dev/
