# Add a Caddy HTTPS origin behind Cloudflare Tunnel

**Priority:** Medium

**Scope:** Medium

## Summary

Put Caddy between Cloudflared and Jellyfin, obtain a publicly trusted
certificate through an ACME DNS-01 challenge, and require Cloudflared to
validate that certificate when connecting to the origin. This removes the
remaining plaintext loopback hop and avoids `noTLSVerify`.

This does not make HTTP traffic opaque to Cloudflare. A normal
browser-accessible Cloudflare proxy terminates the client's TLS session at the
Cloudflare edge before forwarding the request through the tunnel. HTTPS to
Caddy creates a separate, authenticated TLS connection from Cloudflared to the
origin.

## Plan

1. Create a least-privilege Cloudflare API token restricted to DNS edits for
   the `sodagu.nz` zone. Encrypt it with Agenix using the same user and
   Filmotheque host recipients as the tunnel credentials; deploy it only under
   `/run/agenix` for ACME renewal.
2. Configure `security.acme` with the existing administrative email, accept the
   terms, and request a certificate for `media.sodagu.nz` using Cloudflare
   DNS-01 validation. Do not use HTTP-01 or expose an ACME listener publicly.
3. Enable Caddy with a `media.sodagu.nz` virtual host bound to loopback HTTPS.
   Use the ACME-managed certificate and reverse proxy to
   `http://127.0.0.1:8096`.
4. Preserve the client-address headers supplied through the trusted local
   Cloudflared/Caddy chain without accepting equivalent spoofed headers from
   untrusted origins.
5. Change the tunnel ingress origin to Caddy's HTTPS listener. Set
   `originServerName = "media.sodagu.nz"`, retain certificate verification,
   and do not configure `noTLSVerify`.
6. Order startup so the ACME material and Caddy are available before the
   Cloudflared connector starts. Ensure certificate renewal reloads Caddy
   without disrupting Jellyfin.
7. Build and activate the configuration, verify strict origin TLS, then reboot
   and confirm ACME, Caddy, Cloudflared, and Jellyfin recover in the intended
   order.

## Acceptance criteria

- Cloudflared connects to `https://` Caddy with certificate verification
  enabled and the expected `media.sodagu.nz` server name.
- Caddy presents a currently valid certificate for `media.sodagu.nz` and
  proxies successfully to Jellyfin over loopback.
- The DNS API token exists only as an Agenix-encrypted repository file and a
  mode-`0400` runtime secret.
- No Caddy, ACME, Jellyfin, or Cloudflared listener is opened to the public
  network; the tunnel remains the only public transport.
- Certificate issuance and renewal require no manual intervention, and a
  renewal reload does not interrupt the managed Jellyfin service.
- A cold boot produces healthy ACME, Caddy, Cloudflared, and Jellyfin services
  with no `noTLSVerify`, certificate, or startup-order warnings.
- `treefmt`, `nix flake check --no-build`, and the Filmotheque NixOS build pass.

## Privacy boundary

Cloudflare will still be able to inspect HTTP content at its edge under this
design. If preventing that is a hard requirement, replace the browser-facing
HTTP tunnel with one of these architectures before implementing this issue:

1. Use Cloudflare for DNS only, expose Caddy directly on port 443, and terminate
   the client's TLS session exclusively on Filmotheque.
2. Keep Filmotheque private behind WireGuard or Tailscale and access Caddy only
   through the VPN.
3. Use an opaque TCP transport that preserves client-to-origin TLS, accepting
   that standard browser access may require a client connector or a different
   Cloudflare product.

Do not describe Caddy-behind-Tunnel as end-to-end encryption from the browser
to Filmotheque. Its benefit is strict encryption and authentication of the
origin hop.

## Notes

- Cloudflare documents HTTPS origins through Tunnel with `originServerName`,
  custom CA, and TLS-verification controls:
  https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/configure-tunnels/origin-configuration/
- Cloudflare's Full (strict) model validates a public or Cloudflare Origin CA
  certificate on the origin connection:
  https://developers.cloudflare.com/ssl/origin-configuration/ssl-modes/full-strict/
