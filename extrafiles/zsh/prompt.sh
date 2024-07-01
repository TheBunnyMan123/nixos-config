#!/usr/bin/env zsh

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '
NEWLINE=$'\n'

setopt PROMPT_SUBST
PROMPT='%F{blue}%n%f%F{white}%f@%F{green}%m%f %B%F{white}:%f%b %F{magenta}%d%f %F{yellow}${vcs_info_msg_0_}%f${NEWLINE}> '

