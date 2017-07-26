#!/bin/bash
#
#
#
#

ezv_iftar() {
  ezanveri_denetle; bugun
  renk_denetle

  # Eğer şu anki saat aksam değerinden küçükse
  if (( UNIXSAAT < aksam ))
  then
      bekleme_suresi $aksam_n
      kalan

      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİftar saati : ${RENK3}$aksam_n" \
        "${RENK7}${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  else
      # Akşam değeri şu anki saatten büyük ya da eşitse
      # Yarının aksam vakti ezanveri dosyasında var mı denetle önc..
      [[ -z $(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}") ]] && {
        if (( GUNCELLEME_YAP ))
        then
            bilesen_yukle guncelleyici
            guncelleme_yap
       else
           printf '%s: %s dosyanızda yarına ait veri bulunmuyor.\n' "${AD}" "${EZANVERI_ADI}"
           exit 1
       fi

       export $(gawk '{printf "aksam_n=%s", $6}' \
         <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
       bekleme_suresi_yarin $aksam_n
       kalan

       printf '%b\n%b\n\n' \
         "${RENK7}${RENK2}\nİftar saati : ${RENK3}$aksam_n${RENK5} (Yarın)" \
         "${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
      }
  fi
}

# vim: set ft=sh ts=2 sw=2 et:
