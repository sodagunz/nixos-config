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

This configuration loosely uses the [dendritic pattern][Dendritic]: a feature owns
the NixOS and Home Manager and Darwin configuration that belongs to it, rather than being
split by configuration type, except in that they are in any of the following root directories:

- [apps](modules/apps) holds user-facing programs. `desktop` is intentionally flat;
  `dev`, `gaming`, `shell`, `terminal`, and `tools` group related programs when
  useful.
- [system](modules/system) holds NixOS features. Shared operating-system
  defaults live in `system/core.nix`, with services grouped under `services`.
- [profiles](modules/profiles) reusable base and workstation setups. Stuff I would
  normally want in every machine of it's kind.
- [machines](modules/machines) holds machine-specific configurations. Each machine registers its
  own NixOS and Home Manager outputs, and selects the modules it will use.
- [flake](modules/flake) contains the shared flake-parts plumbing.

Each public feature is a meaningfully named `.nix` module discovered by
`import-tree`. Keep simple features in one file, such as `shell/fish.nix`. When
a feature has associated configuration, themes, or genuinely separate module
implementations, place them in a sibling directory such as `shell/yazi/`.
Every Nix file under `modules/` is itself a flake-parts module; split files
contribute independently to the same deferred NixOS or Home Manager module.

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
their own dedicated config. I keep home-manager config uncoupled from system config,
as otherwise I need to maintain separate config for any machine not running nixos.

```console
nix flake check --no-build
```

## Deploy

We use [Comin][Comin] to manage release and deploy to all machines. It's constantly polling `main`, which needs to be protected.
Merging to it will trigger a diff, and if it correctly identifies that the **NixOS** configuration changed, it will trigger an os switch in all machines.
After a successful os switch, it will attempt to run a custom post installation script that triggers a home switch. This is not natively supported by [Comin][comin], so it could fail.
Because of this setup, a change landing on main that affects only `homeConfigurations` is not guaranteed to be deployed to machines that were already up to date.

Before enrolling a host, create a fine-grained GitHub token with
**Contents: Read** permission for the source repository, then encrypt it for the two
existing recipients:

```console
agenix -e .secrets/comin-github.token.age
```

Add every enrolled host's age recipient to `.secrets/secrets.nix` and declare
the secret in that machine module. Bootstrap each online host once with the
Comin-enabled configuration, then confirm polling and deployment with
`journalctl -u comin`. Normal NixOS rollback and boot-menu generations remain
the recovery path if a deployment is bad, Comin uses it's own generation ordering. A failed Home Manager activation is
recorded by Comin, while the successful NixOS generation remains available for
rollback.

GitHub branch protection is managed outside this repository: require all CI
checks for pull requests to `main`, and block direct and force pushes. No testing branch, tag, release or deploy workflow is currently configured for Comin.
The trunk, `main`, is the source of truth and (if everything goes well) the actual configuration of every configured machine.
 `homegrown` currently uses the placeholder token path until its age recipient is available, as it's currently on a pitstop due to ~~someone temporarily comandeering it's SSD~~ unforseen technical issues.
SSH commit signature verification is also deferred to a later commit; configure Comin's
`sshAllowedSignersPath` with an allowed-signers file once commit signing is in
place.

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
| Reverse proxy         | [Cloudflared][Cloudflared]                                           |
| Emulation             | Retroarch                                                            |
| Deployment            | [Comin][Comin]                                                       |

## Credits

- [Frost-Phoenix/nixos-config][Frost-Phoenix] is the original foundation for
  this configuration.
- [mightyiam/dendritic][Dendritic] documents the module-system pattern that
  informs its feature-oriented structure.

[Dendritic]: https://github.com/mightyiam/dendritic
[Bibata]: https://github.com/ful1e5/Bibata_Cursor
[Btop]: https://github.com/aristocratos/btop
[Cloudflared]: https://developers.cloudflare.com/cloudflare-one/networks/connectors/cloudflare-tunnel/
[Copyparty]: https://github.com/9001/copyparty
[Comin]: https://github.com/nlewo/comin
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
