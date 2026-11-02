{ inputs, ... }:
{
  flake.nixosModules.comin =
    {
      config,
      pkgs,
      self,
      username,
      ...
    }:
    let
      # Include Home Manager in the system closure so Comin notices home-only changes.
      homeActivation =
        self.homeConfigurations."${username}@${config.networking.hostName}".activationPackage;
    in
    {
      imports = [
        inputs.comin.nixosModules.comin
      ];
      services.comin = {
        enable = true;
        postDeploymentCommand = "${
          pkgs.writeShellApplication {
            name = "comin-home-manager-activation";
            runtimeInputs = [
              pkgs.coreutils
              pkgs.util-linux
            ];
            text = ''
              # Only activate Home Manager after Comin has successfully switched NixOS.
              if [ "$COMIN_STATUS" != "done" ]; then
                exit 0
              fi

              logger -t comin-home-manager "Activating ${username}@${config.networking.hostName} for $COMIN_GIT_SHA"
              runuser -u ${username} -- env \
                HOME=/home/${username} \
                HOME_MANAGER_BACKUP_EXT=hmbackup \
                ${homeActivation}/activate 2>&1 | logger -t comin-home-manager
              logger -t comin-home-manager "Activated ${username}@${config.networking.hostName} for $COMIN_GIT_SHA"
            '';
          }
        }/bin/comin-home-manager-activation";
        remotes = [
          {
            # Minispore and filmotheque provision this with Agenix. Homegrown
            # remains unprovisioned until its age recipient is available.
            auth.access_token_path = "/run/agenix/comin-github.token";
            branches = {
              main = {
                name = "main";
                operation = "switch";
              };
              # Main is the only release branch for this remote.
              testing.name = "";
            };
            name = "origin";
            url = "https://github.com/sodagunz/nixos-config.git";
          }
        ];

        # Set sshAllowedSignersPath once SSH commit signing is introduced.
      };
    };
}
