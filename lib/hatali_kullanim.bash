#!/bin/bash
#
#   Ezanvakti hatalı komut yardımcısı bileşeni
#
#

hatali_kullanim() {
  local -a dinle_uzun vakitler_uzun kuran_uzun
  local -a bildirim_uzun butun_uzun ortam_uzun
  local oneri oneriler ileti
  renk_denetle

  dinle_uzun=(--sabah --ogle --ikindi --aksam --yatsi --cuma)
  vakitler_uzun=(--sabah --ogle --gunes --ikindi --aksam --yatsi
                 --aylik --haftalik --bildirim --siradaki --kerahat
                 --bayram --nafile)

  kuran_uzun=(--secim --rastgele --hatim --gunluk --arayuz)
  bildirim_uzun=(--bildirim)

  butun_uzun=(--vakitler --conky --iftar --ayet --esma --bilgi
              --hadis --kuran --dinle --arayuz --arayuz2
              --arayuz3 --ucbirim --gui --gui2 --gui3 --tui
              --sureler --guncelle --yardim  --surum --gunler
              --aralik --kalan --config --renk --hutbe --imsak
              --yapilandirma --listele --ortam --help)

  ortam_uzun=(--tv --radyo)


  printf "%s: -- \`%s' geçerli değil.\n" "${AD}" "$2" >&2
  case "$1" in
    b) oneriler="$(printf -- '%s\n' "${bildirim_uzun[@]}" | grep -- "$2")" ;;
    d) oneriler="$(printf -- '%s\n' "${dinle_uzun[@]}" | grep -- "$2")" ;;
    k) oneriler="$(printf -- '%s\n' "${kuran_uzun[@]}" | grep -- "$2")" ;;
    o) oneriler="$(printf -- '%s\n' "${ortam_uzun[@]}" | grep -- "$2")" ;;
    t) oneriler="$(printf -- '%s\n' "${butun_uzun[@]}" | grep -- "$2")" ;;
    v) oneriler="$(printf -- '%s\n' "${vakitler_uzun[@]}" | grep -- "$2")" ;;
  esac

  if [[ -n ${oneriler} && $2 != @(-|--) ]]
  then
      if (( $(echo ${oneriler} | wc -w) == 1 ))
      then ileti='Bunu mu'
      else ileti='Bunlardan birini mi'
      fi

      printf "${RENK5}%s: ${RENK8}%s demek istediniz?\n${RENK0}" \
        "${AD}" "${ileti}" >&2
      for oneri in ${oneriler}
      do
        printf -- "${RENK3}%s${RENK0}\n" "${oneri}"
      done
  else
      printf "Yardım için '%s --yardım' kullanın.\n"  "${AD}" >&2
  fi
  exit 1
}

# vim: set ft=sh ts=2 sw=2 et:
