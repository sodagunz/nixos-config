{username, ...}: {
  services = {
    xserver = {
      enable = true;
      xkb.layout = "us,fr";
    };

    displayManager = {
      defaultSession = "niri";
      autoLogin = {
        enable = true;
        user = "${username}";
      };
    };
    libinput = {
      enable = true;
      # mouse = {
      #   accelProfile = "flat";
      # };
    };
  };
}
