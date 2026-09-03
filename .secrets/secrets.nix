let
  keys = {
    "gunz@filmotheque" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINxupbH0ozQa8mB51cOtgABJULI8gtYGmz22fv9oafuP";
    "gunz@minispore" =
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9JOMByKMg+n5+eER4G3i1+5J/MoSeaTA0N39L34WqV";
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
