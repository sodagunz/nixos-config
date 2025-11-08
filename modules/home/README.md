# Home modules

Home modules, organized by specialization.

```
./                  # Alias for ./base/.
|--base/            # Contains the minimum base modules common to all my builds.
|--server/          # Contains the home modules I normally use on all my servers. Contains the base.
     |--module.nix  # A module intended for server use. Might not be included in the default server configuration.
|--workstation      # Contains the home modules I normally use on all my workstations. Contains the base.
     |--module.nix  # A module intended for workstation use. Might not be included in the default workstation configuration.
```
