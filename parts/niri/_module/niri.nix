{ pkgs, ... }: {
  home.packages = with pkgs; [
    grim
    slurp
    wf-recorder
    glib
    wayland
    direnv
  ];
}
