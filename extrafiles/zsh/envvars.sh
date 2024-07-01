#!/usr/bin/env zsh

if (( $+commands[nvim] ))
then
  export EDITOR="nvim"
fi
export PAGER=w3m

PATH=$PATH:$HOME/.local/bin
