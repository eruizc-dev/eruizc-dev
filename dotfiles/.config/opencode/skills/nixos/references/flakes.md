# Nix Flakes Reference

## Flake Structure

```nix
{
  description = "A flake description";

  inputs = {
    # Input declarations
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # Output declarations
  };
}
```

## Input Types

```nix
inputs = {
  # GitHub
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  # GitLab (self-hosted)
  myflake.url = "git+ssh://gitlab.example.com/group/repo";
  myflake.url = "git+https://gitlab.example.com/group/repo";

  # Git with ref/rev
  myflake.url = "git+ssh://host/repo?ref=main";
  myflake.url = "git+ssh://host/repo?rev=abc123";

  # Local path (for development)
  myflake.url = "path:./subdir";

  # Tarball
  myflake.url = "https://example.com/archive.tar.gz";

  # Pin inputs to same nixpkgs (critical for consistency)
  other-flake.url = "git+ssh://host/other";
  other-flake.inputs.nixpkgs.follows = "nixpkgs";

  # Flake without flake.nix
  non-flake.url = "github:owner/repo";
  non-flake.flake = false;
};
```

## Standard Outputs

```nix
outputs = { self, nixpkgs, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };
in {
  # NixOS configurations
  nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
    inherit system;
    modules = [ ./configuration.nix ];
  };

  # Reusable NixOS modules
  nixosModules.default = import ./modules;
  nixosModules.myservice = import ./modules/myservice.nix;

  # Packages
  packages.${system}.default = pkgs.hello;
  packages.${system}.mypackage = pkgs.callPackage ./pkg.nix {};

  # Development shells
  devShells.${system}.default = pkgs.mkShell {
    packages = [ pkgs.git pkgs.nodejs ];
  };

  # Overlays
  overlays.default = final: prev: {
    mypackage = prev.callPackage ./pkg.nix {};
  };

  # Apps (runnable with nix run)
  apps.${system}.default = {
    type = "app";
    program = "${self.packages.${system}.default}/bin/hello";
  };

  # Formatter (nix fmt)
  formatter.${system} = pkgs.nixpkgs-fmt;

  # Templates
  templates.default = {
    path = ./template;
    description = "A basic template";
  };

  # Checks (nix flake check)
  checks.${system}.test = pkgs.runCommand "test" {} "touch $out";
};
```

## Multi-System Support

```nix
outputs = { self, nixpkgs, ... }:
let
  systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
  forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
    pkgs = import nixpkgs { inherit system; };
    inherit system;
  });
in {
  packages = forAllSystems ({ pkgs, system }: {
    default = pkgs.hello;
  });

  devShells = forAllSystems ({ pkgs, system }: {
    default = pkgs.mkShell { packages = [ pkgs.git ]; };
  });
};
```

## Multi-Repo Composition Pattern

```nix
# builder/flake.nix - Composes multiple flakes
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Pin all to same nixpkgs
    os.url = "git+ssh://gitlab.example.com/flakes/os";
    os.inputs.nixpkgs.follows = "nixpkgs";

    k3s.url = "git+ssh://gitlab.example.com/flakes/k3s";
    k3s.inputs.nixpkgs.follows = "nixpkgs";

    services.url = "git+ssh://gitlab.example.com/flakes/services";
    services.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, os, k3s, services, ... }: {
    nixosConfigurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        os.nixosModules.default
        k3s.nixosModules.k3s
        ./host-config.nix
      ];
    };
  };
}
```

## Passing Extra Arguments to Modules

```nix
outputs = { self, nixpkgs, ... }: {
  nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      # Available in all modules as function arguments
      myCustomArg = "value";
      inherit self;
    };
    modules = [ ./configuration.nix ];
  };
};

# In configuration.nix
{ config, pkgs, myCustomArg, self, ... }:
{
  # Use myCustomArg and self here
}
```

## Commands

```bash
# Show flake outputs
nix flake show
nix flake show github:owner/repo

# Check flake validity
nix flake check

# Update all inputs
nix flake update

# Update specific input
nix flake lock --update-input nixpkgs

# Build outputs
nix build .#packageName
nix build .#nixosConfigurations.hostname.config.system.build.toplevel

# Enter devShell
nix develop
nix develop .#shellName

# Run apps
nix run .#appName

# Create new flake from template
nix flake init -t templates#name

# Show flake metadata
nix flake metadata

# Lock without building
nix flake lock
```

## flake.lock

The lock file pins exact revisions. Key fields:

```json
{
  "nodes": {
    "nixpkgs": {
      "locked": {
        "lastModified": 1234567890,
        "narHash": "sha256-...",
        "owner": "NixOS",
        "repo": "nixpkgs",
        "rev": "abc123...",
        "type": "github"
      }
    }
  }
}
```

## Common Issues

### Input not found
Ensure flake has `git add flake.nix flake.lock` - untracked files ignored.

### Dirty tree warning
Commit or stage changes, or use `--impure` flag.

### Infinite recursion
Usually from accessing config values before they're defined. Use `lib.mkIf` for conditional config.

### Hash mismatch
Update hash with: `nix build 2>&1 | grep 'got:' | awk '{print $2}'`
