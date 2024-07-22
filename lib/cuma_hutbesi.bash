#!/bin/bash
#
#     Ezanvakti cuma hutbesi bileşeni
#
#


hutbe_goster() {
  local HUTBE_ADRESI='https://dinhizmetleri.diyanet.gov.tr/kategoriler/yayinlarimiz/hutbeler/t%C3%BCrk%C3%A7e#row'

  yad --html --browser --width=560 --height=600  borders=0 --skip-taskbar \
    --title "${AD^} - Hutbe Listesi" --window-icon=${AD} --center \
    --uri="${HUTBE_ADRESI}"
}

# vim: set ft=sh ts=2 sw=2 et:

