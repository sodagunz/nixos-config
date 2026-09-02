_: {
  services.cloudflared = {
    enable = true;
    tunnels.media = {
      credentialsFile = "/home/gunz/.cloudflared/d456ae50-9f31-4e0c-a7af-a095f52a3850.json";
      ingress = {
        "media.sodagu.nz" = {
          service = "http://localhost:8096";
          originRequest.noTLSVerify = true; #TODO: this is insecure, but I need to set up ACME on caddy to remove it.
        };
      };
      default = "http_status:404";
    };
  };
}
