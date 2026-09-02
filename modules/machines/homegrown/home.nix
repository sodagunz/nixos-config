{ ... }:
{
  flake.homeModules.homegrown =
    { self, ... }:
    {
      imports = [
        self.homeModules.server
      ];
    };
}
