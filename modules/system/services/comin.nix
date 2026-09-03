{ inputs, ... }:
{
  flake.nixosModules.comin =
    {
      pkgs,
      ...
    }:
    {
      imports = [
        inputs.comin.nixosModules.comin
      ];

      services.comin = {
        enable = true;
        postDeploymentCommand = pkgs.writeShellApplication {
          name = "comin-home-manager-activation";
          runtimeInputs = [
            pkgs.coreutils
            pkgs.nix
            pkgs.util-linux
          ];
          text = ''
            set -o pipefail

            # Only activate Home Manager after Comin has successfully switched NixOS.
            if [ "$COMIN_STATUS" != "done" ]; then
              exit 0
            fi

            activation_package="$(nix build --no-link --print-out-paths \
              "$COMIN_FLAKE_URL#homeConfigurations.\\\"gunz@$COMIN_HOSTNAME\\\".activationPackage")"
            runuser -u gunz -- env \
              HOME=/home/gunz \
              HOME_MANAGER_BACKUP_EXT=hmbackup \
              "$activation_package/activate"
          '';
        };
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
