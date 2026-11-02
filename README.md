```
███████╗··██████╗·██████╗··█████╗··██████╗·██╗···██╗███╗···██╗███████╗···/┐········
██╔════╝·██╔═══██╗██╔══██╗██╔══██╗██╔════╝·██║···██║████╗··██║╚══███╔╝··/·(░)─┐····
███████╗·██║···██║██║··██║███████║██║··███╗██║···██║██╔██╗·██║··███╔╝····(▒▒▒)···°·  
╚════██║·██║···██║██║··██║██╔══██║██║···██║██║···██║██║╚██╗██║·███╔╝·····|▓▓▓|·|º|·  
███████║·╚██████╔╝██████╔╝██║··██║╚██████╔╝╚██████╔╝██║·╚████║███████╗···|███|·|▓|·  
╚══════╝··╚═════╝·╚═════╝·╚═╝··╚═╝·╚═════╝··╚═════╝·╚═╝··╚═══╝╚══════╝···\___/·|_|·  

github: https://github.com/sodagunz                                                 
email: sodagunz@proton.me                                                           
```

# nixos-config

Nixos configs for my users and machines.

## Table of contents

<!--toc:start-->

- [nixos-config](#nixos-config)
  - [Table of contents](#table-of-contents)
  - [Layout](#layout)
  - [Adding configuration](#adding-configuration)
    - [Feature](#feature)
    - [Machine](#machine)
  - [Rebuilding](#rebuilding)
  - [Deploy](#deploy)
  - [Desktop Components](#desktop-components)
  - [Server Components](#server-components)
  - [Credits](#credits)

<!--toc:end-->

## Layout

This configuration loosely uses the [dendritic pattern][dendritic]: a feature
owns the NixOS and Home Manager and Darwin configuration that belongs to it,
rather than being split by configuration type, except in that they are in any of
the following root directories:

- [apps](modules/apps) holds user-facing programs. `desktop` is intentionally
  flat; `dev`, `gaming`, `shell`, `terminal`, and `tools` group related programs
  when useful.
- [system](modules/system) holds NixOS features. Shared operating-system
  defaults live in `system/core.nix`, with services grouped under `services`.
- [profiles](modules/profiles) reusable base and workstation setups. Stuff I
  would normally want in every machine of it's kind.
- [machines](modules/machines) holds machine-specific configurations. Each
  machine registers its own NixOS and Home Manager outputs, and selects the
  modules it will use.
- [flake](modules/flake) contains the shared flake-parts plumbing.

Each public feature is a meaningfully named `.nix` module discovered by
`import-tree`. Keep simple features in one file, such as `shell/fish.nix`. When
a feature has associated configuration, themes, or genuinely separate module
implementations, place them in a sibling directory such as `shell/yazi/`. Every
Nix file under `modules/` is itself a flake-parts module; split files contribute
independently to the same deferred NixOS or Home Manager module.

## Adding configuration

### Feature

Create a feature under the functional root where it belongs, for example
`modules/apps/dev/example.nix`. Export a Home Manager module through
`flake.homeModules`, a NixOS module through `flake.nixosModules`, or both; then
add that capability to the appropriate profile.

```nix
{ ... }:
{
  flake.homeModules.example = { pkgs, ... }: {
    home.packages = [ pkgs.example ];
  };
}
```

### Machine

Create `modules/machines/<hostname>.nix` to define the machine's NixOS and Home
Manager modules and register both outputs. Keep only its hardware and optional
Disko fragments under `modules/machines/<hostname>/`; each is an independently
imported flake-parts module that contributes to the machine's exported NixOS
module. You can then import features individually, or build up from one of the
base profiles.

## Rebuilding

```console
nh os switch .#minispore
nh home switch '.#gunz@minispore' -b hmbackup
```

Normally OS is on nixpkgs and home-manager on nixpkgs-unstable, so they each use
their own dedicated config. I keep home-manager config uncoupled from system
config, as otherwise I need to maintain separate config for any machine not
running nixos.

```console
nix flake check --no-build
```

## Deploy

We use [Comin] to deploy `main` automatically. Each host's NixOS generation
references its Home Manager activation package, so a Home Manager change also
changes the NixOS output that Comin watches. After a successful NixOS switch,
the post-deployment hook activates Home Manager for that host. This is our own
hook, not native Comin Home Manager support. Check `journalctl -u comin` for
deployment status and `journalctl -t comin-home-manager` for activation output.

Before enrolling a host, create a fine-grained GitHub token with **Contents:
Read** permission for the source repository, then encrypt it for the two
existing recipients:

```console
agenix -e .secrets/comin-github.token.age
```

Add every enrolled host's age recipient to `.secrets/secrets.nix` and declare
the secret in that machine module. Bootstrap each online host once with the
Comin-enabled configuration, then confirm polling and deployment with
`journalctl -u comin`. Normal NixOS rollback and boot-menu generations remain
the recovery path if a deployment is bad; Comin uses its own generation
ordering. Comin logs a failed Home Manager hook but keeps the successful NixOS
deployment and does not retry the hook when it skips an already-deployed output.

GitHub branch protection is managed outside this repository: require all CI
checks for pull requests to `main`, and block direct and force pushes. No
testing branch, tag, release or deploy workflow is currently configured for
Comin. The trunk, `main`, is the source of truth and (if everything goes well)
the actual configuration of every configured machine. `homegrown` currently uses
the placeholder token path until its age recipient is available, as it's
currently on a pitstop due to ~~someone temporarily comandeering it's SSD~~
unforseen technical issues. SSH commit signature verification is also deferred
to a later commit; configure Comin's `sshAllowedSignersPath` with an
allowed-signers file once commit signing is in place.

## Desktop Components

| Component           | Configuration                          |
| ------------------- | -------------------------------------- |
| Window manager      | [Niri]                                 |
| Desktop shell       | [Noctalia]                             |
| Browser             | [Firefox]                              |
| Terminals           | [Ghostty] and [Kitty]                  |
| Shell               | [Fish] with [Starship]                 |
| Editors             | [Zed], [Neovim] via [NVF], [Helix]     |
| File managers       | [Nemo] and [Yazi]                      |
| Video and music     | [mpv][mpv], [VLC], and [ncspot]        |
| Resource monitoring | [Btop] and [Resources]                 |
| Audio               | [PipeWire]                             |
| Screen recording    | [wf-recorder] with [slurp]             |
| Colour scheme       | [Nord]-Night, as featured by [Ghostty] |
| Icons               | [Nordzy]                               |
| Cursor              | [Bibata Modern Ice][bibata]            |
| Fonts               | [Montserrat] and [Nerd Fonts]          |

## Server Components

| Component        | Configuration                              |
| ---------------- | ------------------------------------------ |
| Media streaming  | [Jellyfin]                                 |
| File sharing     | [Copyparty] and NFS                        |
| Media management | [\*arr services][servarr] and Transmission |
| Reverse proxy    | [Cloudflared]                              |
| Emulation        | Retroarch                                  |
| Deployment       | [Comin]                                    |

## Credits

- [Frost-Phoenix/nixos-config][frost-phoenix] is the original foundation for
  this configuration.
- [mightyiam/dendritic][dendritic] documents the module-system pattern that
  informs its feature-oriented structure.

[bibata]: https://github.com/ful1e5/Bibata_Cursor
[btop]: https://github.com/aristocratos/btop
[cloudflared]: https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/
[comin]: https://github.com/nlewo/comin
[copyparty]: https://github.com/9001/copyparty
[dendritic]: https://github.com/mightyiam/dendritic
[firefox]: https://www.mozilla.org/firefox/
[fish]: https://fishshell.com/
[frost-phoenix]: https://github.com/Frost-Phoenix/nixos-config
[ghostty]: https://github.com/ghostty-org/ghostty
[helix]: https://helix-editor.com/
[jellyfin]: https://jellyfin.org/
[kitty]: https://sw.kovidgoyal.net/kitty/
[montserrat]: https://fonts.google.com/specimen/Montserrat
[ncspot]: https://github.com/hrkfdn/ncspot
[nemo]: https://github.com/linuxmint/nemo/
[neovim]: https://neovim.io/
[nerd fonts]: https://www.nerdfonts.com/
[niri]: https://github.com/niri-wm/niri
[noctalia]: https://github.com/noctalia-dev/noctalia
[nord]: https://www.nordtheme.com/
[nordzy]: https://github.com/alvatip/Nordzy-icon
[nvf]: https://github.com/NotAShelf/nvf
[pipewire]: https://pipewire.org/
[resources]: https://apps.gnome.org/Resources/
[servarr]: https://wiki.servarr.com/
[slurp]: https://github.com/emersion/slurp
[starship]: https://starship.rs/
[vlc]: https://www.videolan.org/vlc/
[wf-recorder]: https://github.com/ammen99/wf-recorder
[yazi]: https://yazi-rs.github.io/
[zed]: https://zed.dev/
