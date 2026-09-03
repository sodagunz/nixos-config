{ ... }:
{
  flake.nixosModules.users =
    {
      pkgs,
      username,
      ...
    }:
    {
      nix.settings.allowed-users = [ "${username}" ];
      users.users.${username} = {
        description = "${username}";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        isNormalUser = true;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBOPsjlsehCwuVVDsyaKJoxvIefqu1BPl2/B3V8dghrf gunz"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBhO59Hku23ejz5cyWdXQRnk8TpecPNAbZZw0VD60bv tomas"
        ];
        shell = pkgs.fish;
      };
    };
}
