# NixOS Modules Reference

## Module Structure

```nix
{ config, lib, pkgs, ... }:
{
  imports = [
    # Other modules to include
    ./other-module.nix
  ];

  options = {
    # Option declarations
  };

  config = {
    # Option definitions (values)
  };
}
```

## Declaring Options

```nix
{ config, lib, pkgs, ... }:
{
  options.myModule = {
    enable = lib.mkEnableOption "my module";

    port = lib.mkOption {
      type = lib.types.port;
      default = 8080;
      description = "Port to listen on";
    };

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.mypackage;
      description = "Package to use";
    };

    settings = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Additional settings";
    };

    extraConfig = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Extra configuration lines";
    };
  };
}
```

## Common Option Types

```nix
lib.types.bool                    # true/false
lib.types.int                     # integer
lib.types.str                     # string
lib.types.path                    # filesystem path
lib.types.package                 # Nix package
lib.types.port                    # 0-65535
lib.types.lines                   # newline-separated string
lib.types.enum [ "a" "b" ]        # one of listed values

lib.types.listOf lib.types.str    # list of strings
lib.types.attrsOf lib.types.int   # { name = int; ... }
lib.types.nullOr lib.types.str    # string or null
lib.types.either lib.types.int lib.types.str  # int or string

lib.types.submodule { options = { ... }; }  # nested options
```

## Defining Config with Conditions

```nix
{ config, lib, pkgs, ... }:
let
  cfg = config.myModule;
in {
  options.myModule = { /* ... */ };

  # ALWAYS use mkIf for conditional config (lazy evaluation)
  config = lib.mkIf cfg.enable {
    systemd.services.myservice = {
      description = "My Service";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${cfg.package}/bin/myapp --port ${toString cfg.port}";
      };
    };

    networking.firewall.allowedTCPPorts = [ cfg.port ];
  };
}
```

## Override Priorities

```nix
# Default value (easily overridden, priority 1000)
config.option = lib.mkDefault "value";

# Force value (priority 50)
config.option = lib.mkForce "value";

# Custom priority (lower number = higher priority)
config.option = lib.mkOverride 100 "value";

# Ordering for list/string merging
config.environment.systemPackages = lib.mkBefore [ pkgs.git ];
config.environment.systemPackages = lib.mkAfter [ pkgs.vim ];
```

## Merging Behavior

```nix
# Lists: concatenate
environment.systemPackages = [ pkgs.git ];  # module A
environment.systemPackages = [ pkgs.vim ];  # module B
# Result: [ pkgs.git pkgs.vim ]

# Strings: error (use types.lines or mkForce)
# Attribute sets: recursive merge
# Booleans: OR by default

# For attrsOf with merge function:
lib.mkOption {
  type = lib.types.attrsOf lib.types.str;
  default = {};
}
# Multiple definitions merge attribute sets
```

## Submodules (Nested Options)

```nix
options.myModule.virtualHosts = lib.mkOption {
  type = lib.types.attrsOf (lib.types.submodule {
    options = {
      port = lib.mkOption {
        type = lib.types.port;
        default = 80;
      };
      root = lib.mkOption {
        type = lib.types.path;
      };
    };
  });
  default = {};
};

# Usage:
config.myModule.virtualHosts = {
  "example.com" = {
    port = 443;
    root = "/var/www/example";
  };
  "other.com" = {
    root = "/var/www/other";
  };
};
```

## Module Arguments

Standard arguments available to all modules:

```nix
{ config   # Full system configuration (after evaluation)
, lib      # Nixpkgs library functions
, pkgs     # Package set
, options  # All declared options
, modulesPath  # Path to nixpkgs/nixos/modules
, ...
}:
```

## Conditional Imports

```nix
{ config, lib, ... }:
{
  imports = [
    ./base.nix
  ] ++ lib.optionals config.services.myservice.enable [
    ./myservice-extra.nix
  ];
}
```

## Exporting Modules from Flakes

```nix
# flake.nix
{
  outputs = { self, nixpkgs, ... }: {
    # Single module
    nixosModules.default = import ./modules;

    # Multiple modules
    nixosModules = {
      k3s = import ./modules/k3s;
      airgap = import ./modules/airgap;
    };
  };
}

# Usage in another flake
{
  inputs.myflake.url = "...";

  outputs = { nixpkgs, myflake, ... }: {
    nixosConfigurations.host = nixpkgs.lib.nixosSystem {
      modules = [
        myflake.nixosModules.default
        myflake.nixosModules.k3s
      ];
    };
  };
}
```

## Common Service Patterns

```nix
{ config, lib, pkgs, ... }:
let
  cfg = config.services.myapp;
in {
  options.services.myapp = {
    enable = lib.mkEnableOption "myapp service";
    user = lib.mkOption {
      type = lib.types.str;
      default = "myapp";
    };
    dataDir = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/myapp";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      isSystemUser = true;
      group = cfg.user;
      home = cfg.dataDir;
      createHome = true;
    };
    users.groups.${cfg.user} = {};

    systemd.services.myapp = {
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        User = cfg.user;
        WorkingDirectory = cfg.dataDir;
        ExecStart = "${pkgs.myapp}/bin/myapp";
        Restart = "on-failure";
      };
    };
  };
}
```

## Debugging Modules

```nix
# In nix repl
:lf .
nixosConfigurations.hostname.config.services.myservice

# Show option definition locations
nixosConfigurations.hostname.options.services.myservice.port.definitionsWithLocations

# Evaluate with trace
config.myModule.port = builtins.trace "port value" 8080;
```
