#!/bin/bash
#
#
#
#

ayet_goster() {
  renk_denetle; meal_denetle

  satir=$(( RANDOM % 6236 + 1 ))

  case $1 in
    ucbirim)
      printf '%b%b%b\n' \
        "${RENK3}\nGünlük Ayet ${RENK2}(${RENK8}" \
        "$(sed -n "${satir}p" ${VERI_DIZINI}/veriler/sureler_ayetler) $satir/6236${RENK2})${RENK8}\n\n" \
        "$(sed -n "${satir}p" "${MEAL}")${RENK0}" ;;

    bildirim)
      notify-send "Günlük Ayet ($(sed -n "${satir}p" ${VERI_DIZINI}/veriler/sureler_ayetler))" \
        "$(sed -n "${satir}p" "${MEAL}")" -t $AYET_BILDIRIM_SURESI"000"
      exit 0 ;;
  esac
}

# vim: set ft=sh ts=2 sw=2 et:
