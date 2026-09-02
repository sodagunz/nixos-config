let
  keys = {
    "gunz@minispore" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBOPsjlsehCwuVVDsyaKJoxvIefqu1BPl2/B3V8dghrf";
    "gunz@filmotheque" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINxupbH0ozQa8mB51cOtgABJULI8gtYGmz22fv9oafuP";
  };
in
{
  "secrets/filmotheque-cloudflared.token.age".publicKeys = [
    keys."gunz@minispore"
    keys."gunz@filmotheque"
  ];
}
