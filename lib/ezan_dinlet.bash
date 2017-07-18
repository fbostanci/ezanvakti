#!/bin/bash
#
#
#
#

function ezan_dinlet() {
  local vakit="$1" vakit_ezani="$2" ileti

  [[ "${vakit}" = "Cuma selası" ]] && {
    ileti=''
    EZAN_OKUYAN="${SELA_OKUYAN}"
  } || ileti='ezanı '

  bilesen_yukle mplayer_yonetici

  printf "${RENK7}${RENK2}${vakit}${RENK3} ${ileti}dinletiliyor...\n\n${RENK0}"
  printf "${RENK7}${RENK3}Okuyan : ${RENK2}${EZAN_OKUYAN}\n\n${RENK0}"
  mplayer_calistir "${vakit_ezani}"
}

# vim: set ft=sh ts=2 sw=2 et:
