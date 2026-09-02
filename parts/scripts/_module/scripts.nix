{ pkgs, ... }:
let
  record = pkgs.writeScriptBin "record" (builtins.readFile ./scripts/record.sh);
in
{
  home.packages = [ record ];
}
