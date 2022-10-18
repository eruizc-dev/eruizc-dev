{ pkgs ? import <nixpkgs> {} }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in
pkgs.mkShell {
  # Rust
  buildInputs = with pkgs; [
    rustc cargo clippy
    rust-analyzer
  ];
  RUST_BACKTRACE = 1;

  # Node JS
  buildInputs = with pkgs; [
    nodejs
    nodePackages.typescript
    nodePackages.ts-node
    unstable.nodePackages.typescript-language-server
  ];
}
