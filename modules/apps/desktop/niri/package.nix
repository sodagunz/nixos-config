{ ... }:
{
  flake.homeModules.niri = { pkgs, ... }: {
    home.packages = with pkgs; [
      slurp
      wf-recorder
      glib
      wayland
      direnv
    ];
  };
}
