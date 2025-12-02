_: {
  services.caddy = {
    enable = true;
    email = "sodagunz+media@proton.me";
    virtualHosts."media.sodagu.nz" = {
      extraConfig = ''
        reverse_proxy http://localhost:8096 {
          header_down X-Real-IP {http.request.remote}
          header_down X-Forwarded-For {http.request.remote}
        }
        redir https://media.sodagu.nz{uri} permanent
      '';
      serverAliases = [ "www.media.sodagu.nz" ];
    };
  };
  
}
