{ pkgs ? import <nixpkgs> {} }:

# Rust
pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc cargo clippy
    rust-analyzer
  ];
  RUST_BACKTRACE = 1;
}
