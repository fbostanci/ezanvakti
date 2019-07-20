#!/bin/bash
#
#
#
#

# oynatılacak ses dosyasının
# parça süresini al.
oynatici_sure_al() {
  if [[ -x $(type -p ffprobe) ]]
  then
      ffprobe -i "$1"  -show_entries format=duration \
        -v quiet -of csv="p=0" | cut -d. -f1

  elif [[ -x $(type -p mplayer) ]]
  then
      mplayer -vo null -ao null -frames 0 -identify "$1" 2>/dev/null | \
        gawk  -F'=' '/^ID_LENGTH/ {print int($2);}'
  fi
}

# parca_suresi değerinden gelen saniyeyi saat,dakika ve saniyeye
# çevirir.
oynatici_sure_cevir() {
  (( ! parca_suresi )) && return 1

  printf '%02d saat : %02d dakika : %02d saniye' \
         $(( parca_suresi / 3600 )) \
         $(( parca_suresi % 3600 / 60 )) \
         $(( parca_suresi % 60 ))
}

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

  # ses oynatma önceliği mplayer
  # uygulamasına verildi.
  if [[ -x $(type -p mplayer) ]]
  then
      rm -f /tmp/ezv-oynatici-$$.pipe 2>/dev/null
      mkfifo /tmp/ezv-oynatici-$$.pipe

      $MPLAYER -slave -input \
        file=/tmp/ezv-oynatici-$$.pipe "${dinletilecek_oge}" 2>/dev/null
      rm -f /tmp/ezv-oynatici-$$.pipe 2>/dev/null

  elif [[ -x $(type -p ffplay) ]]
  then
      ffplay -loglevel quiet -volume ${SES} -nodisp \
        -i "${dinletilecek_oge}" 2>/dev/null

  else
      printf '%s: desteklenen bir ses oynatıcısı bulunamadı.\n' "${AD}" >&2
      exit 1
  fi
  clear
}

# vim: set ft=sh ts=2 sw=2 et:
