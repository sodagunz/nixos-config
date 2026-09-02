{ ... }:
{
  flake.homeModules.minispore =
    { self, ... }:
    {
      imports = [
        self.homeModules.workstation
      ];
    };
}
