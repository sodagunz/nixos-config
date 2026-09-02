{
  hosts,
  self,
  ...
}:
let
  hostname = "minispore";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    module = self.nixosModules.minispore;
  };

  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = self.homeModules.minispore;
  };
}
