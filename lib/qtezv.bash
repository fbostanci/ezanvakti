#!/bin/bash
#
# Ezanvati Qt Gui yardımcı bileşeni
#
#

ezv_qt_vakitler() {
  ezanveri_denetle; bugun
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
