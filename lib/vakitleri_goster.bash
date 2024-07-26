#!/bin/bash
#
#       Ezanvakti vakitleri gösterme bileşeni
#
#

vakitler() { # {{{
  ezanveri_denetle; bugun
  renk_denetle

  local sabah_kalan gunes_kalan ogle_kalan
  local ikindi_kalan aksam_kalan yatsi_kalan
  local istek="$1"

  # --osd/bildirim için renkleri sıfırla
  [[ ${istek} = bildirim ]] && { RENK1=''; RENK2=''; }

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah
      sabah_kalan="${RENK2} $kalan_sure"
  else
      sabah_kalan="${RENK1} OKUNDU"
  fi

  if (( UNIXSAAT < gunes ))
  then
      bekleme_suresi $gunes
      gunes_kalan="${RENK2} $kalan_sure"
  else
      gunes_kalan="${RENK1} DOĞDU"
  fi

  if (( UNIXSAAT < ogle ))
  then
      bekleme_suresi $ogle
      ogle_kalan="${RENK2} $kalan_sure"
  else
      ogle_kalan="${RENK1} OKUNDU"
  fi

  if (( UNIXSAAT < ikindi ))
  then
      bekleme_suresi $ikindi
      ikindi_kalan="${RENK2} $kalan_sure"
  else
      ikindi_kalan="${RENK1} OKUNDU"
  fi

  if (( UNIXSAAT < aksam ))
  then
      bekleme_suresi $aksam
      aksam_kalan="${RENK2} $kalan_sure"
  else
      aksam_kalan="${RENK1} OKUNDU"
  fi

  if (( UNIXSAAT < yatsi ))
  then
      bekleme_suresi $yatsi
      yatsi_kalan="${RENK2} $kalan_sure"
  else
      yatsi_kalan="${RENK1} OKUNDU"
  fi

  case ${istek} in
    sabah)
      printf "${RENK7}${RENK2}\nSabah ezanı  ${RENK3}: $sabah_n $sabah_kalan${RENK0}\n\n" ;;
    gunes)
      printf "${RENK7}${RENK2}\nGüneş        ${RENK3}: $gunes_n $gunes_kalan${RENK0}\n\n" ;;
    ogle)
      printf "${RENK7}${RENK2}\nÖğle ezanı   ${RENK3}: $ogle_n $ogle_kalan${RENK0}\n\n" ;;
    ikindi)
      printf "${RENK7}${RENK2}\nİkindi ezanı ${RENK3}: $ikindi_n $ikindi_kalan${RENK0}\n\n" ;;
    aksam)
      printf "${RENK7}${RENK2}\nAkşam ezanı  ${RENK3}: $aksam_n $aksam_kalan${RENK0}\n\n" ;;
    yatsi)
      printf "${RENK7}${RENK2}\nYatsı ezanı  ${RENK3}: $yatsi_n $yatsi_kalan${RENK0}\n\n" ;;
    aylik)
      if ! grep -qo "^$(date -d '30 days' +%d.%m.%Y)" "${EZANVERI}"
      then
          printf "${RENK3}30 günlük veri bulunmuyor..${RENK0}\n"
          exit 1
      fi

      printf "\n${RENK7}${RENK6}Tarih        Sabah   Güneş   Öğle    İkindi  Akşam   Yatsı${RENK0}\n"
      sed -n "/$(date +%d.%m.%Y)/,/$(date -d '30 days' +%d.%m.%Y)/p" "${EZANVERI}" |
        gawk -v r0=${RENK0} -v r2=${RENK2} -v r3=${RENK3} -v r7=${RENK7} \
          '{printf "%s%s%s%s   %s   %s   %s   %s   %s   %s%s\n"\
          , r7,r3,$1,r2,$2,$3,$4,$5,$6,$7,r0}' ;;

    haftalik)
      if ! grep -qo $(date -d 'next week' +%d.%m.%Y) "${EZANVERI}"
      then
          printf "${RENK3}7 günlük veri bulunmuyor..${RENK0}\n"
          exit 1
      fi

      printf "\n${RENK7}${RENK6}Tarih        Sabah   Güneş   Öğle    İkindi  Akşam   Yatsı${RENK0}\n"
      sed -n "/$(date +%d.%m.%Y)/,/$(date -d '7 days' +%d.%m.%Y)/p" "${EZANVERI}" |
        gawk -v r0=${RENK0} -v r2=${RENK2} -v r3=${RENK3} -v r7=${RENK7} \
          '{printf "%s%s%s%s   %s   %s   %s   %s   %s   %s%s\n"\
          , r7,r3,$1,r2,$2,$3,$4,$5,$6,$7,r0}' ;;

    bildirim)
      notify-send "${AD^} - vakitler" \
        "$(printf '%s\n%s\n%s\n%s\n%s' \
        "Sabah....$sabah_n....$sabah_kalan" \
        "Öğle......$ogle_n....$ogle_kalan" \
        "İkindi.....$ikindi_n....$ikindi_kalan" \
        "Akşam...$aksam_n....$aksam_kalan" \
        "Yatsı.......$yatsi_n....$yatsi_kalan" | sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:')" \
        -a ${AD} -i ${AD} -t $BILGI_BILDIRIM_SURESI"000" ;;

    tum_vakitler)
      printf '%b%b%b%b%b%b\n' \
        "${RENK7}${RENK3}\n${ILCE}${RENK5} için ezan vakitleri (${TARIH} $(date +%T))\n\n" \
        "${RENK2}Sabah ezanı  ${RENK3}: $sabah_n   $sabah_kalan\n" \
        "${RENK2}Öğle ezanı   ${RENK3}: $ogle_n   $ogle_kalan\n" \
        "${RENK2}İkindi ezanı ${RENK3}: $ikindi_n   $ikindi_kalan\n" \
        "${RENK2}Akşam ezanı  ${RENK3}: $aksam_n   $aksam_kalan\n" \
        "${RENK2}Yatsı ezanı  ${RENK3}: $yatsi_n   $yatsi_kalan${RENK0}\n" ;;
    esac
} # }}}

# vim: set ft=sh ts=2 sw=2 et:
