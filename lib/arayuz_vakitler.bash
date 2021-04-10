#!/bin/bash
#
#   Arayuz 1 ve 3 için vakitler bileşeni
#
#

g_vakitleri_al() {
  ezanveri_denetle; bugun

  local kerahat_suresi kv_gunes kv_ogle kv_aksam

  kerahat_suresi=$(( KERAHAT_SURESI * 60 ))
  kv_gunes=$(( gunes + kerahat_suresi ))
  kv_ogle=$(( ogle - kerahat_suresi ))
  kv_aksam=$(( aksam - kerahat_suresi ))

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah
      v_ileti='Sabah ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'

  elif (( UNIXSAAT >= sabah && UNIXSAAT < gunes ))
  then
      bekleme_suresi $gunes
      v_ileti='Gün doğumuna kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 1</b>'

  elif (( UNIXSAAT == gunes ))
  then
      bekleme_suresi $ogle
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Güneş Doğuş Vakti</b>'

  elif (( UNIXSAAT > gunes && UNIXSAAT < kv_gunes ))
  then
      bekleme_suresi $ogle
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 2</b>'

  elif (( UNIXSAAT >= kv_gunes && UNIXSAAT < kv_ogle ))
  then
      bekleme_suresi $ogle
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kuşluk Vakti</b>'

  elif (( UNIXSAAT < ogle && UNIXSAAT >= kv_ogle ))
  then
      bekleme_suresi $ogle
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 3</b>'

  elif (( UNIXSAAT >= ogle && UNIXSAAT < ikindi ))
  then
      bekleme_suresi $ikindi
      v_ileti='İkindi ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Öğle Vakti</b>'

  elif (( UNIXSAAT >= ikindi && UNIXSAAT < kv_aksam ))
  then
      bekleme_suresi $aksam
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 4</b>'

  elif (( UNIXSAAT < aksam && UNIXSAAT >= kv_aksam ))
  then
      bekleme_suresi $aksam
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 5</b>'

  elif (( UNIXSAAT >= aksam && UNIXSAAT < yatsi ))
  then
      bekleme_suresi $yatsi
      v_ileti='Yatsı ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Akşam Vakti</b>'

  elif (( UNIXSAAT < yeni_gun ))
  then
      bekleme_suresi $ysabah
      v_ileti="Sabah ($ysabah_n) ezanına kalan süre:"
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'
  fi
}

g_vakitleri_yaz() {
  local sabah gunes ogle ikindi aksam yatsi vakitsiz ikindi_kerahat

  vakitsiz="<b>Şimdi Kerahat Vakti 2</b>|<b>Şimdi Kerahat Vakti 3</b>"
  vakitsiz+="|<b>Şimdi Kuşluk Vakti</b>"
  ikindi_kerahat="<b>Şimdi Kerahat Vakti 4</b>|<b>Şimdi Kerahat Vakti 5</b>"

  if [[ ${vakit_bilgisi} = '<b>Şimdi Yatsı Vakti</b>'  ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Kerahat Vakti 1</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Güneş Doğuş Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Öğle Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = @(${ikindi_kerahat}) ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Akşam Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = @(${vakitsiz}) ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"
  fi

  printf "${VAKIT_BICIMI}" "${sabah}" "$sabah_n" "${gunes}" \
         "$gunes_n" "${ogle}" "$ogle_n" "${ikindi}" "$ikindi_n" \
         "${aksam}" "$aksam_n" "${yatsi}" "$yatsi_n"
}

# vim: set ft=sh ts=2 sw=2 et:
