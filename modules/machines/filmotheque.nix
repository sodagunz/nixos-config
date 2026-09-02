{ inputs, ... }:
let
  hosts = import ../flake/_hosts.nix { inherit inputs; };
  hostname = "filmotheque";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    module = ./filmotheque/_nixos.nix;
    extraModules = [
      inputs.copyparty.nixosModules.default
    ];
  };

  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = ./filmotheque/_home.nix;
  };
}
