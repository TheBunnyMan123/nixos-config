#!/usr/bin/env bash

set -xeo pipefail

NAME="$(pwd | grep --color=never -oE "[^/]+$" | sed "s/[^a-zA-Z0-9 -_]//g")"
SESSION=""

if [ -n "$1" ]
then
   if [ "$1" == "-h" ]
   then
      echo "First argument: Session ID"
      exit
   else
      SESSION="$1"
   fi
else
   SESSION="$(tmux display-message -p "#S")"
fi

tmux new-window -t "$SESSION:" -n "$NAME" nvim \; split-window -h lazygit \; split-window

