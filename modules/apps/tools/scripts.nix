{ ... }:
{
  flake.homeModules.scripts =
    { pkgs, ... }:
    let
      compress = pkgs.writeScriptBin "compress" (builtins.readFile ./scripts/compress.sh);
      extract = pkgs.writeScriptBin "extract" (builtins.readFile ./scripts/extract.sh);
      record = pkgs.writeScriptBin "record" (builtins.readFile ./scripts/record.sh);
    in
    {
      home.packages = [
        pkgs.ascii
        compress
        extract
        record
      ];
    };
}
