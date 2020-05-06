#!/bin/bash
#
#
#
#


listele() {
  local ezv_sleep kalan_gun
  renk_denetle

  kalan_gun="$(gawk '$1 ~ /^[0-9]{2}.[0-9]{2}.[0-9]{4}/ {t++} END{tsatir=t;}; \
                    $1 ~ /^[0-9]{2}.[0-9]{2}.[0-9]{4}/ {b++} \
                    {if($1 ~ strftime("%d.%m.%Y")) bsatir=b;} \
                    END{print(tsatir-bsatir)}' "${EZANVERI}")"

  if pgrep ${AD}-sleep >/dev/null 2>&1
  then ezv_sleep="${RENK2}çalışıyor"
  else ezv_sleep="${RENK1}çalışmıyor"
  fi

  printf "${RENK2}Kullanıcı ayar dizini:       ${RENK3}%s\n${RENK0}" "${EZANVAKTI_DIZINI}"
  printf "${RENK2}Kullanıcı ayar dosyası:      ${RENK3}%s\n${RENK0}" "${EZANVAKTI_AYAR}"
  printf "${RENK2}Kullanıcı css dosya dizini:  ${RENK3}%s\n${RENK0}" "${EZANVAKTI_DIZINI}"
  printf "${RENK2}Önatınımlı ayar dosyası:     ${RENK3}%s\n${RENK0}" "${EZANVAKTI_ONT_AYAR}"
  printf "${RENK2}Bileşen dizini:              ${RENK3}%s\n${RENK0}" "${BILESEN_DIZINI}"
  printf "${RENK2}Veri dizini:                 ${RENK3}%s\n${RENK0}" "${VERI_DIZINI}"
  printf "${RENK2}Öntanımlı ses dosya dizini:  ${RENK3}%s\n${RENK0}" "${VERI_DIZINI/${AD}/}sounds/${AD}"
  printf "${RENK2}Öntanımlı meal dizini:       ${RENK3}%s\n${RENK0}" "${VERI_DIZINI}/mealler"
  printf "${RENK2}Öntanımlı css dosya dizini:  ${RENK3}%s\n${RENK0}" "${VERI_DIZINI}/veriler"
  printf "${RENK2}Uygulama başlatıcı konumu:   ${RENK3}%s\n${RENK0}" "$(dirname $0)"
  printf "${RENK2}Uygulama otomatik başlatıcı: ${RENK3}%s\n${RENK0}" "${XDG_CONFIG_HOME:-$HOME/.config}/autostart/${AD}.desktop"
  printf "${RENK2}%s-sleep durumu:      %b\n${RENK0}" "${AD}" "${ezv_sleep}"
  printf "${RENK2}Ezanveri dosyası kalan gün:  ${RENK3}%2d${RENK0}\n" "${kalan_gun}"
}
