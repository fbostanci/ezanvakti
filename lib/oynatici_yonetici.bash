#!/bin/bash
#
#
#
#

oynatici_calistir() {
  local dinletilecek_oge="$1"

  if [[ ${dinletilecek_oge} =~ ^http.* ]]
  then
      # internet erişimini denetle.
      if ! ping -q -c 1 -W 1 google.com > /dev/null 2>&1
      then
          printf '%s: internet erişimi algılanamadı.\n' "${AD}" >&2
          return 1
      fi
  elif [[ ! -f ${dinletilecek_oge} ]]
  then
      printf '%s: istenilen ses dosyası -> %s <- bulunamadı.\n' \
        "${AD}" "${dinletilecek_oge}" >&2
      return 1
  fi

  rm -f /tmp/ezv-oynatici-$$.pipe 2>/dev/null
  mkfifo /tmp/ezv-oynatici-$$.pipe

  if [[ -x $(type -p ffplay) ]]
  then
      ffplay -loglevel quiet -volume ${SES} -nodisp \
        -i "${dinletilecek_oge}"  </tmp/ezv-oynatici-$$.pipe 2>/dev/null
      echo "play" > /tmp/ezv-oynatici-$$.pipe

  elif [[ -x $(type -p mplayer) ]]
  then
      $MPLAYER -slave -input file=/tmp/ezv-oynatici-$$.pipe "${dinletilecek_oge}" 2>/dev/null
  fi
  clear
  rm -f /tmp/ezv-oynatici-$$.pipe 2>/dev/null
}

# vim: set ft=sh ts=2 sw=2 et:
