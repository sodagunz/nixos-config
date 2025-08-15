{
  pkgs,
  inputs,
  username,
  host,
  homeModules ? [],
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs username host;};
    users.${username} = {
      imports = [
        inputs.nvf.homeManagerModules.default
      ] ++ homeModules;
      home = {
        username = "${username}";
        homeDirectory = "/home/${username}";
        stateVersion = "25.05";
      };
      programs.home-manager.enable = true;
    };
    backupFileExtension = "hmbackup";
  };

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  nix.settings.allowed-users = ["${username}"];
}