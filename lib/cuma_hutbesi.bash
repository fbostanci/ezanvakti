#!/bin/bash
#
#     Ezanvakti cuma hutbesi bileşeni
#
#


hutbe_goster() {
  echo "Hazır değil"; exit 1
  local HUTBE_DIZINI="${EZANVAKTI_DIZINI}/hutbeler"
  local HUTBE_ADRESI='https://'
  export -f indirici

  [[ ! -f ${HUTBE_DIZINI} ]] && mkdir -p "${HUTBE_DIZINI}"
  yad --html --browser --width=550 --height=450  borders=0 --skip-taskbar \
    --title "${AD^} - Hutbe Listesi" --window-icon=${AD} --center \
    --uri="${HUTBE_ADRESI}"  --uri-handler=indirici > /dev/null 2>&1
    echo $?
}

# vim: set ft=sh ts=2 sw=2 et:
