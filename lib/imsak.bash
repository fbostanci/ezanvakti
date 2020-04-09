#!/bin/bash
#
#
#
#

ezv_imsak() {
  ezanveri_denetle; bugun
  renk_denetle

  # Eğer şu anki saat sabah değerinden küçükse
  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah_n
      kalan

      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİmsak saati : ${RENK3}$sabah_n" \
        "${RENK7}${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  else
      # Yarının sabah vakti ezanveri dosyasında var mı denetle önc..
      if ! grep -qo "^$(date -d 'tomorrow' +%d.%m.%Y)" "${EZANVERI}"
      then
          if (( GUNCELLEME_YAP ))
          then
              bilesen_yukle guncelleyici
              guncelleme_yap
          else
              printf '%s: %s dosyanızda yarına ait veri bulunmuyor.\n' "${AD}" "${EZANVERI_ADI}"
              exit 1
          fi
      fi
      export $(gawk '{printf "sabah_n=%s", $2}' \
        <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
      bekleme_suresi_yarin $sabah_n
      kalan

      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİmsak saati : ${RENK3}$sabah_n${RENK5} (Yarın)" \
        "${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  fi
}

# vim: set ft=sh ts=2 sw=2 et:
