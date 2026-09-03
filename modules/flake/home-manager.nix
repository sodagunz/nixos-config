{ lib, ... }:
{
  options.flake = {
    homeConfigurations = lib.mkOption {
      default = { };
      description = "Home Manager configurations exported by machine modules.";
      type = lib.types.lazyAttrsOf lib.types.raw;
    };
    homeModules = lib.mkOption {
      default = { };
      description = "Home Manager modules exported by feature modules.";
      type = lib.types.lazyAttrsOf lib.types.deferredModule;
    };
  };
}
