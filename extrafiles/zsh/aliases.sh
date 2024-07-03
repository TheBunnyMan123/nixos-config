#!/usr/bin/env zsh

alias ll="ls -l"
alias l="ls -al"

if (( $+commands[bat] ))
then
  alias cat="bat"
  alias gcat="/bin/cat"
fi

alias grep="grep --color=always"

alias archwiki="w3m \"wiki.archlinux.org\""

alias obsidian='NIXPKGS_ALLOW_UNFREE=1 nix-shell -p obsidian --command "exec obsidian"'

alias rm="mvtotrash"

alias espeak="espeak -a 200 -g 0 -k 16 -p 46"
alias espeak-ng="espeak-ng -a 200 -g 0 -k 16 -p 46"

alias start="./start.sh"
