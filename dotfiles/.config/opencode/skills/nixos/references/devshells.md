# DevShells and Overlays Reference

## mkShell Basics

```nix
# Basic development shell
pkgs.mkShell {
  packages = [ pkgs.git pkgs.nodejs pkgs.yarn ];
}

# With environment variables
pkgs.mkShell {
  packages = [ pkgs.python3 ];

  PYTHONPATH = "${pkgs.python3Packages.requests}/lib/python3.11/site-packages";
  MY_VAR = "value";
}

# With shell hook (runs on entry)
pkgs.mkShell {
  packages = [ pkgs.kubectl ];

  shellHook = ''
    echo "Kubernetes development environment"
    export KUBECONFIG=$HOME/.kube/config
    alias k=kubectl
  '';
}

# mkShellNoCC (no C compiler, lighter)
pkgs.mkShellNoCC {
  packages = [ pkgs.nodejs pkgs.yarn ];
}
```

## Flake DevShells

```nix
{
  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    # Default shell (nix develop)
    devShells.${system}.default = pkgs.mkShell {
      packages = [ pkgs.git ];
    };

    # Named shells (nix develop .#name)
    devShells.${system} = {
      default = pkgs.mkShell { packages = [ pkgs.git ]; };
      python = pkgs.mkShell { packages = [ pkgs.python3 ]; };
      node = pkgs.mkShell { packages = [ pkgs.nodejs ]; };
    };
  };
}
```

## Shared DevShell Across Repos

```nix
# utils/nix/devshell.nix
{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    # Kubernetes
    kubectl
    kubernetes-helm
    kustomize
    k9s

    # Nix
    nil  # Nix LSP
    nixpkgs-fmt

    # Git
    git

    # Utilities
    jq
    yq-go
  ];

  shellHook = ''
    echo "Development environment loaded"
  '';
}

# Consuming repo's flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "git+ssh://gitlab.example.com/flakes/utils";
  };

  outputs = { self, nixpkgs, utils, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = import "${utils}/nix/devshell.nix" { inherit pkgs; };
  };
}
```

## Build Inputs vs Packages

```nix
pkgs.mkShell {
  # Modern: use packages (clearer intent)
  packages = [ pkgs.git pkgs.nodejs ];

  # Legacy: buildInputs (still works)
  buildInputs = [ pkgs.openssl ];

  # Native build inputs (build-time only tools)
  nativeBuildInputs = [ pkgs.pkg-config ];
}
```

## inputsFrom (Inherit from Derivations)

```nix
# Get all dependencies from a package
pkgs.mkShell {
  inputsFrom = [ pkgs.mypackage ];

  # Add extra tools
  packages = [ pkgs.gdb ];
}
```

---

# Overlays

## Basic Structure

```nix
# Overlay is: final -> prev -> { modifications }
final: prev: {
  # final = complete pkgs with your overlay applied
  # prev = pkgs before your overlay

  mypackage = prev.callPackage ./mypackage.nix {};
}
```

## Common Operations

```nix
final: prev: {
  # Add new package
  myapp = prev.callPackage ./myapp.nix {};

  # Override package arguments
  pass = prev.pass.override {
    x11Support = false;
  };

  # Override derivation attributes
  sl = prev.sl.overrideAttrs (old: {
    src = prev.fetchFromGitHub { /* ... */ };
    patches = (old.patches or []) ++ [ ./my.patch ];
  });

  # Override with different version
  nodejs = prev.nodejs_20;
}
```

## Using Overlays in Flakes

```nix
{
  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";

    # Method 1: overlay list
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlays.default ];
    };

    # Method 2: extend
    pkgs = nixpkgs.legacyPackages.${system}.extend self.overlays.default;
  in {
    overlays.default = final: prev: {
      mypackage = prev.callPackage ./mypackage.nix {};
    };

    packages.${system}.default = pkgs.mypackage;
  };
}
```

## Overlay in NixOS Configuration

```nix
{ config, pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      mypackage = prev.callPackage ./mypackage.nix {};
    })
  ];

  environment.systemPackages = [ pkgs.mypackage ];
}
```

## Accessing Unstable Packages

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-unstable { inherit system; };
        })
      ];
    };
  in {
    # Now use pkgs.unstable.somePackage
  };
}
```

## Python Package Overlays

```nix
final: prev: {
  python3 = prev.python3.override {
    packageOverrides = pyfinal: pyprev: {
      mypackage = pyprev.buildPythonPackage {
        pname = "mypackage";
        version = "1.0.0";
        src = ./mypackage;
      };
    };
  };
  python3Packages = final.python3.pkgs;
}
```

## Scoped Overlays (GNOME, Xfce)

```nix
# Packages in nested scopes need overrideScope
final: prev: {
  gnome = prev.gnome.overrideScope (gfinal: gprev: {
    mutter = gprev.mutter.overrideAttrs (old: {
      patches = (old.patches or []) ++ [ ./my-mutter-patch.patch ];
    });
  });
}
```

## Anti-Patterns

```nix
# BAD: causes infinite recursion
final: prev: {
  mypackage = final.mypackage.override { /* ... */ };
}

# GOOD: use prev for the base
final: prev: {
  mypackage = prev.mypackage.override { /* ... */ };
}

# BAD: using self for dependencies
final: prev: {
  mypackage = prev.callPackage ./pkg.nix {
    openssl = prev.openssl;  # should use final
  };
}

# GOOD: use final for dependencies
final: prev: {
  mypackage = prev.callPackage ./pkg.nix {
    openssl = final.openssl;
  };
}
```

## Combining Multiple Overlays

```nix
let
  overlay1 = final: prev: { a = 1; };
  overlay2 = final: prev: { b = prev.a + 1; };

  pkgs = import nixpkgs {
    inherit system;
    overlays = [ overlay1 overlay2 ];  # Applied in order
  };
in
  pkgs.b  # equals 2
```
