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
      config = lib.mkIf cfg.enable {
        # Keep the server on stable while using Cloudflared's current connector.
        nixpkgs.overlays = [
          (final: _prev: {
            cloudflared =
              inputs.nixpkgs-unstable.legacyPackages.${final.stdenv.hostPlatform.system}.cloudflared;
          })
        ];

        systemd.services.${unitName} = {
          after = [
            "jellyfin.service"
            "network-online.target"
          ];
          description = "Cloudflare Tunnel '${cfg.tunnelId}'";
          serviceConfig = {
            DynamicUser = true;
            ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token-file %d/token";
            LoadCredential = [ "token:${cfg.tokenFile}" ];
            NoNewPrivileges = true;
            PrivateTmp = true;
            ProtectControlGroups = true;
            ProtectHome = true;
            ProtectKernelLogs = true;
            ProtectSystem = "strict";
            Restart = "on-failure";
            RestartSec = "10s";
            RestrictAddressFamilies = [
              "AF_UNIX"
              "AF_INET"
              "AF_INET6"
            ];
          };
          wantedBy = [ "multi-user.target" ];
          wants = [
            "jellyfin.service"
            "network-online.target"
          ];
        };
      };
      options.sodagunz.services.cloudflared = {
        enable = lib.mkEnableOption "the Cloudflare Tunnel connector";
        tokenFile = lib.mkOption {
          description = "Runtime path to the Cloudflare Tunnel token.";
          type = lib.types.str;
        };
        tunnelId = lib.mkOption {
          description = "UUID of the Cloudflare Tunnel to run.";
          type = lib.types.str;
        };
      };
    };
}
