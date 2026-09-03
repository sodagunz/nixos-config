let
  keys = {
    "gunz@filmotheque" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINxupbH0ozQa8mB51cOtgABJULI8gtYGmz22fv9oafuP";
    "gunz@minispore" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBOPsjlsehCwuVVDsyaKJoxvIefqu1BPl2/B3V8dghrf";
  };
in
{
  ".secrets/comin-github.token.age".publicKeys = [
    keys."gunz@minispore"
    keys."gunz@filmotheque"
  ];
  ".secrets/filmotheque-cloudflared.token.age".publicKeys = [
    keys."gunz@minispore"
    keys."gunz@filmotheque"
  ];
}
