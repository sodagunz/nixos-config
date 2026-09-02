# Run Cloudflare Tunnel as a boot service

**Priority:** High

**Scope:** Medium

## Summary

Run the existing managed Cloudflare tunnel automatically at boot. Do not
restore Caddy. Store its rotated, per-tunnel token encrypted in Git and deploy
only that token at runtime.

## Plan

1. Confirm the existing managed tunnel ID and rotate its per-tunnel token.
2. Add Agenix as a flake input following stable `nixpkgs`, and include its
   NixOS module only in Filmotheque.
3. Add `secrets/secrets.nix` with Filmotheque's SSH host Ed25519 public key and
   the user's `id_ed25519_local` public key as recipients.
4. Have the user encrypt the existing credentials interactively without the
   agent reading their plaintext:
   - Store the tunnel token as `filmotheque-cloudflared.token.age`, declare it
     through `age.secrets`, and deploy it under `/run/agenix` with mode `0400`.
   - Leave `cert.pem` out of the repository: it is an account-wide credential
     and is not required to run the existing named tunnel.
5. Add a `system/services/cloudflared` feature, import it through the server
   profile, and leave it disabled by default. Expose host-level settings for
   enablement, tunnel ID, and token path. Override only Cloudflared from
   `nixpkgs-unstable`.
6. Enable the feature in Filmotheque with managed tunnel ID
   `ae4102f8-f139-456d-9d33-f5d85ce06030`. Public-hostname and origin routing
   remain in Cloudflare's managed-tunnel configuration.
7. Add a Git ignore safeguard for plaintext files under `secrets/`, while
   continuing to track `.age` files.
8. Stop the manually launched Cloudflared connector, activate the NixOS
   configuration, and verify the managed connector locally and through the
   public hostname.
9. Reboot Filmotheque and repeat the checks to prove unattended startup. After
   verifying recovery and cold-boot operation, remove obsolete local tunnel
   credentials. Keep the account-wide `cert.pem` out of Git.

## Acceptance criteria

- `media.sodagu.nz` reaches the existing Jellyfin library through the managed
  Cloudflare tunnel without Caddy or an inbound firewall port.
- The Cloudflared systemd unit starts automatically after a cold boot, remains
  active with zero restarts, and logs a registered tunnel connection.
- The runtime tunnel token exists only under `/run/agenix`, is mode `0400`,
  and systemd copies it into the dynamic service's private credential
  directory.
- Git and the Nix store contain no plaintext Cloudflare credentials or paths to
  credentials in the user's home directory.
- `treefmt`, `nix flake check --no-build`, and the Filmotheque NixOS build pass.
- The original plaintext tunnel token is removed only after encrypted recovery
  and cold-boot operation have both been verified. Keep `cert.pem` out of Git.

## Notes

- The Cloudflare dashboard owns the managed tunnel's public-hostname and
  origin routing; this change does not manage Cloudflare DNS or ingress.
- Only Jellyfin is exposed initially through that dashboard configuration.
- Caddy, ACME, and `noTLSVerify` are unnecessary for this issue.
- `cert.pem` is needed for administrative tunnel management, not for running
  the existing named tunnel, so it stays outside this repository.
- Follow-up issue `10-caddy-https-origin` replaces the loopback HTTP origin
  with Caddy and strictly verified HTTPS. It also documents the remaining
  Cloudflare TLS-termination boundary.
