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
      bekleme_suresi $sabah_n; kalan
      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİmsak saati : ${RENK3}$sabah_n" \
        "${RENK7}${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  else
      bekleme_suresi_yarin $ysabah_n; kalan
      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİmsak saati : ${RENK3}$ysabah_n${RENK5} (Yarın)" \
        "${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  fi
}

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
      export $(gawk '{printf "yaksam_n=%s", $6}' \
        <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
      bekleme_suresi_yarin $yaksam_n; kalan

      printf '%b\n%b\n\n' \
        "${RENK7}${RENK2}\nİftar saati : ${RENK3}$yaksam_n${RENK5} (Yarın)" \
        "${RENK2}Kalan süre  : ${RENK3}$kalan_sure${RENK0}"
  fi
}

# vim: set ft=sh ts=2 sw=2 et:
