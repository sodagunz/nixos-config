{ lib, ... }:
{
  config.systems = [ "x86_64-linux" ];

  options.flake = {
    homeModules = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
      default = { };
      description = "Home Manager modules exported by feature modules.";
    };

    homeConfigurations = lib.mkOption {
      type = lib.types.lazyAttrsOf lib.types.raw;
      default = { };
      description = "Home Manager configurations exported by machine modules.";
    };
  };
}
