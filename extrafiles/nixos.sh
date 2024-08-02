#!/usr/bin/env bash
set -euo pipefail

CMD=$1
shift

case "$CMD" in
  rb|rebuild|sw|switch)
    nixos-rebuild switch "$@";;
  t|test)
    nixos-rebuild test "$@";;
  gen|generate)
    nixos-generate-config "$@";;
  vm|build-vm)
    nixos-rebuild build-vm "$@";;
  rollback)
    nixos-rebuild --rollback switch "$@";;
  up|update|upgrade)
    if [ $# == 0 ]
    then
      ARGS=(--recreate-lock-file)
    else
      ARGS=()
      INPUTS="$@"
      for INPUT in $INPUTS
      do
        ARGS+=(--update-input "$INPUT")
      done
    fi
    FINALARGS="${ARGS[@]}"
    nix flake lock /etc/nixos "$FINALARGS";;
  help|h)
    echo "rb|rebuild|sw|switch -- Switch to the new generation and add it to the bootloader"
    echo "t|test               -- Switch to the new generation but don't add it to the bootloader"
    echo "gen|generate         -- Generate a new NixOS config"
    echo "vm|build-vm          -- Build a QEMU VM with the new generation. Symlink to VM outputed as 'result'"
    echo "rollback             -- Rollback to the previous generation"
    echo "up|update|upgrade    -- Update one or more NixOS Config flake inputs (no arguments for all)"
    echo "h|help               -- View this";;
esac

