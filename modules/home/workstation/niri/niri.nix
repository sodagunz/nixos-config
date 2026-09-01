{pkgs, ...}: {
  home.packages = with pkgs; [
    swaybg
    swaylock
    grim
    slurp
    wl-clip-persist
    cliphist
    wf-recorder
    glib
    wayland
    direnv
  ];
}
