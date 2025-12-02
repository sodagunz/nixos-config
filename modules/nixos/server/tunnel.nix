_: {
  services.cloudflared = {
    enable = true;
    tunnels.media = {
      credentialsFile = "/var/lib/cloudflared/media.json";

      ingress = [
        {
          hostname = "media.sodagu.nz";
          service = "https://localhost:443";
          originRequest = {
            noTLSVerify = true; #TODO: this is insecure, but I need to set up ACME on caddy to remove it.
          };
        }
        { service = "https_status:404"; }
      ];
    }
  };
}
