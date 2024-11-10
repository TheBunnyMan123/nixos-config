#!/usr/bin/env zsh

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '
NEWLINE=$'\n'

setopt PROMPT_SUBST
PROMPT='${(r:$COLUMNS::-:)}${NEWLINE}%F{cyan}%n%f%F{white}%f@%F{green}%m%f %B%F{white}:%f%b %F{magenta}%d%f %F{yellow}${vcs_info_msg_0_}%f${NEWLINE}%B%F{red}${?##0}%f>%b '

# Transient prompt. see https://www.zsh.org/mla/users/2019/msg00633.html
zle-line-init() {
  emulate -L zsh

  [[ $CONTEXT == start ]] || return 0

  while true; do
    zle .recursive-edit
    local -i ret=$?
    [[ $ret == 0 && $KEYS == $'\4' ]] || break
    [[ -o ignore_eof ]] || exit 0
  done

  local saved_prompt=$PROMPT
  local saved_rprompt=$RPROMPT
  PROMPT='${(r:$COLUMNS::-:)}${NEWLINE}%B%F{red}${?##0}%f>%b '
  RPROMPT=''
  zle .reset-prompt
  PROMPT=$saved_prompt
  RPROMPT=$saved_rprompt

  if (( ret )); then
    zle .send-break
  else
    zle .accept-line
  fi
  return ret
}

zle -N zle-line-init

