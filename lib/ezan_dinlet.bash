#!/bin/bash
#
#
#
#

ezan_dinlet() {
  local vakit="$1" ileti

  if [[ ${vakit} = Cuma ]]
  then
      ileti=''
      vakit='Cuma Selası'
      vakit_ezani="${CUMA_SELASI}"
      EZAN_OKUYAN="${SELA_OKUYAN}"

  else
      ileti='ezanı '
      case ${vakit} in
        Sabah)  vakit_ezani="${SABAH_EZANI}" ;;
        Öğle)   vakit_ezani="${OGLE_EZANI}" ;;
        İkindi) vakit_ezani="${IKINDI_EZANI}" ;;
        Akşam)  vakit_ezani="${AKSAM_EZANI}" ;;
        Yatsı)  vakit_ezani="${YATSI_EZANI}" ;;
      esac
  fi

  bilesen_yukle oynatici_yonetici

  printf "${RENK7}${RENK2}${vakit}${RENK3} ${ileti}dinletiliyor\n\n${RENK0}"
  printf "${RENK7}${RENK3}Okuyan : ${RENK2}${EZAN_OKUYAN}\n\n${RENK0}"
  oynatici_calistir "${vakit_ezani}"
}

# vim: set ft=sh ts=2 sw=2 et:
