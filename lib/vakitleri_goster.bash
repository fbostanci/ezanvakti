#
#
#
#
#

function vakitler() { # {{{
  denetle; bugun
  renk_denetle

  local istek="$1"

  # --osd/bildirim için renkleri sıfırla
  [[ ${istek} = bildirim ]] && { RENK1=''; RENK2=''; }

  (( UNIXSAAT < sabah )) && {
    bekleme_suresi $sabah_n; kalan
    sabah_kalan="${RENK2} $kalan_sure"
  } || sabah_kalan="${RENK1} OKUNDU"

  (( UNIXSAAT < ogle )) && {
    bekleme_suresi $ogle_n; kalan
    ogle_kalan="${RENK2} $kalan_sure"
  } || ogle_kalan="${RENK1} OKUNDU"

  (( UNIXSAAT < ikindi )) && {
    bekleme_suresi $ikindi_n; kalan
    ikindi_kalan="${RENK2} $kalan_sure"
  } || ikindi_kalan="${RENK1} OKUNDU"

  (( UNIXSAAT < aksam )) && {
    bekleme_suresi $aksam_n; kalan
    aksam_kalan="${RENK2} $kalan_sure"
  } || aksam_kalan="${RENK1} OKUNDU"

  (( UNIXSAAT < yatsi )) && {
    bekleme_suresi $yatsi_n; kalan
    yatsi_kalan="${RENK2} $kalan_sure"
  } || yatsi_kalan="${RENK1} OKUNDU"

  case ${istek} in
    sabah)
      printf "${RENK7}${RENK2}\nSabah ezanı  ${RENK3}: $sabah_n $sabah_kalan${RENK0}\n\n" ;;
    ogle)
      printf "${RENK7}${RENK2}\nÖğle ezanı   ${RENK3}: $ogle_n $ogle_kalan${RENK0}\n\n" ;;
    ikindi)
      printf "${RENK7}${RENK2}\nİkindi ezanı ${RENK3}: $ikindi_n $ikindi_kalan${RENK0}\n\n" ;;
    aksam)
      printf "${RENK7}${RENK2}\nAkşam ezanı  ${RENK3}: $aksam_n $aksam_kalan${RENK0}\n\n" ;;
    yatsi)
      printf "${RENK7}${RENK2}\nYatsı ezanı  ${RENK3}: $yatsi_n $yatsi_kalan${RENK0}\n\n" ;;
    aylik)
      if ! grep -qo $(date -d 'next week' +%d.%m.%Y) "${EZANVERI}"
      then
          printf "${RENK3}7 günlük veri bulunmuyor..${RENK0}\n"
          exit 1
      fi

      printf "\n${RENK7}${RENK6}Tarih        Sabah   Güneş   Öğle    İkindi  Akşam   Yatsı${RENK0}\n"
      gawk -v r0=${RENK0} -v r2=${RENK2} -v r3=${RENK3} -v r7=${RENK7} \
        '/^[0-9][0-9]\.[0-9]*\.[0-9]*/ \
        {printf "%s%s%s%s   %s   %s   %s   %s   %s   %s%s\n"\
        , r7,r3,$1,r2,$2,$3,$4,$5,$6,$7,r0}' "${EZANVERI}" ;;
    haftalik)
      if ! grep -qo $(date -d 'next week' +%d.%m.%Y) "${EZANVERI}"
      then
          printf "${RENK3}7 günlük veri bulunmuyor..${RENK0}\n"
          exit 1
      fi

      printf "\n${RENK7}${RENK6}Tarih        Sabah   Güneş   Öğle    İkindi  Akşam   Yatsı${RENK0}\n"
      grep '^[0-9][0-9]\.[0-9]*\.[0-9]*' "${EZANVERI}" | grep -B7 $(date -d 'next week' +%d.%m.%Y) |
        gawk -v r0=${RENK0} -v r2=${RENK2} -v r3=${RENK3} -v r7=${RENK7} \
        '{printf "%s%s%s%s   %s   %s   %s   %s   %s   %s%s\n"\
        , r7,r3,$1,r2,$2,$3,$4,$5,$6,$7,r0}' ;;
    bildirim)
      notify-send "Ezanvakti ${SURUM} - vakitler" \
        "$(printf '%s\n%s\n%s\n%s\n%s' \
        "Sabah   $sabah_n   $sabah_kalan" \
        "Öğle    $ogle_n    $ogle_kalan" \
        "İkindi   $ikindi_n    $ikindi_kalan" \
        "Akşam  $aksam_n    $aksam_kalan" \
        "Yatsı     $yatsi_n    $yatsi_kalan" | sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:')" \
        -t $BILGI_BILDIRIM_SURESI"000" -h int:transient:1 ;;
    tum_vakitler)
      printf '%b%b%b%b%b%b\n' \
        "${RENK7}${RENK3}\n${ILCE}${RENK5} için ezan vakitleri (${TARIH} $(date +%H:%M:%S))\n\n" \
        "${RENK2}Sabah ezanı  ${RENK3}: $sabah_n   $sabah_kalan\n" \
        "${RENK2}Öğle ezanı   ${RENK3}: $ogle_n   $ogle_kalan\n" \
        "${RENK2}İkindi ezanı ${RENK3}: $ikindi_n   $ikindi_kalan\n" \
        "${RENK2}Akşam ezanı  ${RENK3}: $aksam_n   $aksam_kalan\n" \
        "${RENK2}Yatsı ezanı  ${RENK3}: $yatsi_n   $yatsi_kalan${RENK0}\n" ;;
    esac
} # }}}

# vim: set ft=sh ts=2 sw=2 et:
