#!/bin/bash
#
#
#
#

function ezv_iftar() {
  ezanveri_denetle; bugun
  renk_denetle

  # Eğer şu anki saat aksam değerinden küçükse
  (( UNIXSAAT < aksam )) && {
     bekleme_suresi $aksam_n; kalan

     printf '%b\n%b\n\n' \
       "${RENK7}${RENK2}\nİftar saati : ${RENK3}$aksam_n" \
       "${RENK7}${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  } || {
    # Akşam değeri şu anki saatten büyük ya da eşitse
    (( UNIXSAAT >= aksam )) && {
      # Yarının aksam vakti ezanveri dosyasında var mı denetle önc..
      [[ -z $(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}") ]] && {
        (( GUNCELLEME_YAP )) && { bilesen_yukle guncelleyici; guncelleme_yap; } || {
          printf "${EZANVERI_ADI} dosyanızda yarına ait veri bulunmuyor.\n"
          exit 1
        }
      }

      export $(gawk '{printf "aksam_n=%s", $6}' \
        <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
      bekleme_suresi_yarin $aksam_n; kalan

      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİftar saati : ${RENK3}$aksam_n${RENK5} (Yarın)" \
        "${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
    }
  }
}

# vim: set ft=sh ts=2 sw=2 et:
