{ ... }:
{
  flake.homeModules.filmotheque =
    { self, ... }:
    {
      imports = [
        self.homeModules.server
      ];
    };
}
