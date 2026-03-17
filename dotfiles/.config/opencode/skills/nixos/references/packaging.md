# Nix Packaging Reference

## stdenv.mkDerivation

```nix
{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "mypackage";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "owner";
    repo = "repo";
    rev = "v${version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  # Build-time only dependencies
  nativeBuildInputs = [ ];

  # Runtime and compile-time dependencies
  buildInputs = [ ];

  # Build phases (all optional, have defaults)
  configurePhase = ''
    runHook preConfigure
    # custom configure
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    make
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp myapp $out/bin/
    runHook postInstall
  '';

  meta = {
    description = "Description";
    homepage = "https://example.com";
    license = lib.licenses.mit;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
}
```

## Fetchers

```nix
# GitHub release
fetchFromGitHub {
  owner = "owner";
  repo = "repo";
  rev = "v1.0.0";
  hash = "sha256-...";
}

# GitLab (including self-hosted)
fetchFromGitLab {
  domain = "gitlab.example.com";  # optional, defaults to gitlab.com
  owner = "group";
  repo = "project";
  rev = "abc123";
  hash = "sha256-...";
}

# URL
fetchurl {
  url = "https://example.com/file.tar.gz";
  hash = "sha256-...";
}

# Zip/tarball with auto-extract
fetchzip {
  url = "https://example.com/archive.zip";
  hash = "sha256-...";
}

# Git repository
fetchgit {
  url = "https://github.com/owner/repo";
  rev = "abc123";
  hash = "sha256-...";
}
```

## Getting Hashes

```bash
# Prefetch URL
nix-prefetch-url https://example.com/file.tar.gz

# Prefetch and unpack
nix-prefetch-url --unpack https://example.com/archive.tar.gz

# Prefetch GitHub
nix-prefetch-github owner repo --rev v1.0.0

# From failed build (shows expected hash)
nix build 2>&1 | grep 'got:' | awk '{print $2}'

# SRI format (preferred)
nix hash to-sri --type sha256 <hash>
```

## runCommand (Simple Derivations)

```nix
# Basic command
pkgs.runCommand "name" {} ''
  echo "hello" > $out
''

# With dependencies
pkgs.runCommand "name" {
  buildInputs = [ pkgs.jq ];
} ''
  echo '{"a":1}' | jq '.a' > $out
''

# With source files
pkgs.runCommand "name" {
  src = ./source;
} ''
  cp -r $src $out
''
```

## OCI Image Packaging (Airgapped)

```nix
# Single image to OCI archive
imagePackage = pkgs.runCommand "nginx-1.25" {
  buildInputs = [ pkgs.skopeo ];
  outputHashMode = "flat";
  outputHashAlgo = "sha256";
  outputHash = "sha256-...";  # for reproducibility
} ''
  skopeo copy docker://nginx:1.25 oci-archive:$out
'';

# From images.list file
imagesListToPackages = { pkgs, listFile }:
  let
    lines = lib.filter (x: x != "")
      (lib.splitString "\n" (builtins.readFile listFile));
    parseRef = line:
      let parts = lib.splitString ":" line;
      in { image = lib.head parts; tag = lib.last parts; };
    sanitizeName = ref: lib.replaceStrings ["/"] ["-"] "${ref.image}-${ref.tag}";
  in lib.listToAttrs (map (line:
    let ref = parseRef line;
    in {
      name = sanitizeName ref;
      value = pkgs.runCommand (sanitizeName ref) {
        buildInputs = [ pkgs.skopeo ];
      } ''
        skopeo copy docker://${ref.image}:${ref.tag} oci-archive:$out
      '';
    }
  ) lines);
```

## Docker Image Building

```nix
# Build Docker image with Nix
pkgs.dockerTools.buildImage {
  name = "myapp";
  tag = "latest";

  copyToRoot = pkgs.buildEnv {
    name = "image-root";
    paths = [ pkgs.myapp pkgs.bashInteractive pkgs.coreutils ];
    pathsToLink = [ "/bin" ];
  };

  config = {
    Cmd = [ "/bin/myapp" ];
    ExposedPorts = { "8080/tcp" = {}; };
    Env = [ "PATH=/bin" ];
  };
}

# Layered image (better caching)
pkgs.dockerTools.buildLayeredImage {
  name = "myapp";
  tag = "latest";
  contents = [ pkgs.myapp ];
  config.Cmd = [ "${pkgs.myapp}/bin/myapp" ];
}

# Stream (no intermediate tarball)
pkgs.dockerTools.streamLayeredImage {
  name = "myapp";
  tag = "latest";
  contents = [ pkgs.myapp ];
}
```

## Helm + Kustomize Pattern

```nix
# Render helm chart with kustomize overlays
manifests = pkgs.runCommand "k3s-manifests" {
  buildInputs = [ pkgs.kubernetes-helm pkgs.kustomize ];
} ''
  mkdir -p base

  # Render helm chart
  helm template myrelease ${./chart} \
    --namespace my-namespace \
    --values ${./values.yaml} \
    > base/manifests.yaml

  # Create kustomization pointing to base
  cat > kustomization.yaml << EOF
  apiVersion: kustomize.config.k8s.io/v1beta1
  kind: Kustomization
  resources:
    - base/manifests.yaml
  patches:
    - path: ${./overlays/patches.yaml}
  EOF

  kustomize build . > $out
'';
```

## callPackage Pattern

```nix
# In flake.nix
packages.x86_64-linux.mypackage = pkgs.callPackage ./pkgs/mypackage.nix {};

# pkgs/mypackage.nix - arguments auto-injected
{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation {
  # ...
}

# With overrides
packages.x86_64-linux.mypackage = pkgs.callPackage ./pkgs/mypackage.nix {
  cmake = pkgs.cmake_3_25;
};
```

## writeShellApplication

```nix
# Preferred over writeShellScriptBin (has shellcheck, set -euo pipefail)
pkgs.writeShellApplication {
  name = "my-script";
  runtimeInputs = [ pkgs.curl pkgs.jq ];
  text = ''
    response=$(curl -s https://api.example.com/data)
    echo "$response" | jq '.result'
  '';
}
```

## Common Build Helpers

```nix
# Install from Makefile
installPhase = ''
  make install PREFIX=$out
'';

# Install manually
installPhase = ''
  mkdir -p $out/bin $out/share/man/man1
  cp myapp $out/bin/
  cp myapp.1 $out/share/man/man1/
'';

# Wrap with environment
postInstall = ''
  wrapProgram $out/bin/myapp \
    --prefix PATH : ${lib.makeBinPath [ pkgs.git ]} \
    --set MY_VAR "value"
'';

# Patch shebangs
postPatch = ''
  patchShebangs scripts/
'';

# Substitute variables
postPatch = ''
  substituteInPlace src/config.h \
    --replace "/usr/local" "$out"
'';
```
