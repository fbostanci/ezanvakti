#!/bin/bash
#
# Ezanvati Qt Gui yardımcı bileşeni
#
#

ezv_qt_vakitler() {
  ezanveri_denetle 1>&2; bugun
  local kerahat_suresi kv_gunes kv_ogle kv_aksam

  kerahat_suresi="$KERAHAT_SURESI minutes" #dk
  kv_gunes=$(date -d "$gunes_n $kerahat_suresi" +%H:%M)
  kv_ogle=$(date -d "-$kerahat_suresi $ogle_n" +%H:%M)
  kv_aksam=$(date -d "-$kerahat_suresi $aksam_n" +%H:%M)

  echo -e "$sabah_n $gunes_n $ogle_n $ikindi_n $aksam_n $yatsi_n $kv_gunes $kv_ogle $kv_aksam"
}

ezv_qt_konum() {
  echo -e "${ULKE}+${ILCE}"
}

ezv_qt_ezanlar() {
  printf "%s+%s+%s+%s+%s+%s+%s\n" \
         "${SABAH_EZANI}" \
         "${OGLE_EZANI}" \
         "${IKINDI_EZANI}" \
         "${AKSAM_EZANI}" \
         "${YATSI_EZANI}" \
         "${EZAN_DUASI}" \
         "${CUMA_SELASI}"
}

ezv_qt_basla() {
  case $1 in
      v) ezv_qt_vakitler ;;
      k) ezv_qt_konum ;;
      e) ezv_qt_ezanlar ;;
  esac
}
