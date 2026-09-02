{ ... }:
{
  flake.nixosModules.users =
    {
      pkgs,
      username,
      ...
    }:
    {
      users.users.${username} = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBOPsjlsehCwuVVDsyaKJoxvIefqu1BPl2/B3V8dghrf gunz"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICBhO59Hku23ejz5cyWdXQRnk8TpecPNAbZZw0VD60bv tomas"
        ];
      };
      nix.settings.allowed-users = [ "${username}" ];
    };
}
