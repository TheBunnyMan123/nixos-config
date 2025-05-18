#!/usr/bin/env bash

set -eo pipefail

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

tmux rename-window -t "$SESSION:" "$NAME" \; send-keys "exec nvim" Enter \; split-window -h lazygit \; split-window

