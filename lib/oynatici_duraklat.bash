#!/bin/bash
#
#                           Ezanvakti Oynatıcı Duraklatma Bileşeni 2.0
#
#

oynatici_duraklat() {
  local oynatici
  DURDURULAN=()

  if ! [[ -x $(type -p playerctl) ]]
  then
      printf '%s: Bu özellik playerctl gerektirmektedir.\n' "${AD}" >&2
      return 1
  fi

  for oynatici in $(playerctl --list-all | cut -d. -f1)
  do
    if [[ $(playerctl status -p ${oynatici}) = Playing ]]
    then
        playerctl --player=${oynatici} pause
        DURDURULAN+=("${oynatici}")
    fi
  done
}

oynatici_devam() {
  local oynatici

  (( ${#DURDURULAN[@]} )) && {
    for oynatici in "${DURDURULAN[@]}"
    do
      playerctl --player=${oynatici} play > /dev/null 2>&1
    done
  }
}

# vim: set ft=sh ts=2 sw=2 et:
