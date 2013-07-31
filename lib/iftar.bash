#
#
#
#
#

function ezv_iftar() {
  denetle; bugun

  # Eğer şu anki saat aksam değerinden küçükse
  [[ $SAAT -lt $aksam ]] && {
     bekleme_suresi $aksam_n; kalan

     printf '%b\n%b\n\n' \
       "${RENK7}${RENK2}\nİftar saati : ${RENK3}$aksam_n" \
       "${RENK7}${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  } || {
    # Akşam değeri şu anki saatten büyük ya da eşitse
    [[ $SAAT -ge $aksam ]] && {
       export $(gawk '{printf "aksam_n=%s:%s", $10,$11}' \
         <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
       bekleme_suresi_yarin $aksam_n; kalan
       printf '%b\n%b\n\n' \
         "${RENK7}${RENK2}\nİftar saati : ${RENK3}$aksam_n${RENK5} (Yarın)" \
         "${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
    }
  }
}

# vim: set ft=sh ts=2 sw=2 et:
