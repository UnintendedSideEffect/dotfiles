let
  #nixpkgs = https://github.com/NixOS/nixpkgs-channels/archive/nixos-19.09.tar.gz;
  #nixpkgs = https://github.com/NixOS/nixpkgs-channels/archive/nixos-20.03.tar.gz;
  nixpkgs = https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
  pkgs = import (builtins.fetchTarball "${nixpkgs}"){};
in
pkgs.mkShell {
  buildInputs = [
    pkgs.nixops
    pkgs.home-manager
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs}:."
  '';
}
