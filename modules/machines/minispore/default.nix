{ inputs, ... }:
let
  hosts = import ../../flake/_hosts.nix { inherit inputs; };
  hostname = "minispore";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    module = ./_nixos.nix;
  };

  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = ./_home.nix;
  };
}
