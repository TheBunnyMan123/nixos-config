#!/usr/bin/env zsh

urlencode() {
    setopt localoptions extendedglob
    input=( ${(s::)1} )
    print ${(j::)input/(#b)([^A-Za-z0-9_.\!~*\'\(\)-])/%${(l:2::0:)$(([##16]#match))}}
}

gsearch() {
  if [ $1 ]
  then
    w3m "https://www.google.com/search?q=$(urlencode $(sed 's/^"\(.*\)"$/\1/' <<<"$1"))"
  else
    echo "Please provide search string"
  fi
}

mvtotrash() {
  mkdir ~/.trash &>/dev/null
  for var in $@
  do
    mv "$var" "$HOME/.trash/$(basename $var) - $(date -u +'%y-%m-%d-%H-%M-%S-%N')"
  done
}

runpkg() {
  bash -c "nix run nixpkgs#$1"
}
