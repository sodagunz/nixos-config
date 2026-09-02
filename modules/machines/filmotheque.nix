{
  hosts,
  inputs,
  self,
  ...
}:
let
  hostname = "filmotheque";
  system = "x86_64-linux";
  username = "gunz";
in
{
  flake.nixosConfigurations.${hostname} = hosts.mkNixos {
    inherit hostname system username;
    module = self.nixosModules.filmotheque;
    extraModules = [
      inputs.copyparty.nixosModules.default
    ];
  };

  flake.homeConfigurations."${username}@${hostname}" = hosts.mkHome {
    inherit hostname system username;
    module = self.homeModules.filmotheque;
  };
}
