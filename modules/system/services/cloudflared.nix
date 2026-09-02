{ ... }:
{
  flake.nixosModules.cloudflared =
    {
      config,
      inputs,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.sodagunz.services.cloudflared;
      unitName = "cloudflared-tunnel-${cfg.tunnelId}";
    in
    {
      options.sodagunz.services.cloudflared = {
        enable = lib.mkEnableOption "the Cloudflare Tunnel connector";

        tunnelId = lib.mkOption {
          type = lib.types.str;
          description = "UUID of the Cloudflare Tunnel to run.";
        };

        tokenFile = lib.mkOption {
          type = lib.types.str;
          description = "Runtime path to the Cloudflare Tunnel token.";
        };
      };

      config = lib.mkIf cfg.enable {
        # Keep the server on stable while using Cloudflared's current connector.
        nixpkgs.overlays = [
          (final: _prev: {
            cloudflared =
              inputs.nixpkgs-unstable.legacyPackages.${final.stdenv.hostPlatform.system}.cloudflared;
          })
        ];

        systemd.services.${unitName} = {
          description = "Cloudflare Tunnel '${cfg.tunnelId}'";
          after = [
            "jellyfin.service"
            "network-online.target"
          ];
          wants = [
            "jellyfin.service"
            "network-online.target"
          ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            DynamicUser = true;
            LoadCredential = [ "token:${cfg.tokenFile}" ];
            ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token-file %d/token";
            Restart = "on-failure";
            RestartSec = "10s";

            NoNewPrivileges = true;
            PrivateTmp = true;
            ProtectControlGroups = true;
            ProtectHome = true;
            ProtectKernelLogs = true;
            ProtectSystem = "strict";
            RestrictAddressFamilies = [
              "AF_UNIX"
              "AF_INET"
              "AF_INET6"
            ];
          };
        };
      };
    };
}
