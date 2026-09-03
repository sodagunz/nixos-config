{ ... }:
{
  flake.nixosModules.audio = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ pulseaudioFull ];
    security.rtkit.enable = true;
    services.pipewire = {
      alsa.enable = true;
      alsa.support32Bit = true;
      enable = true;
      pulse.enable = true;
      # lowLatency.enable = true;
    };
    services.pulseaudio.enable = false;
  };
}
