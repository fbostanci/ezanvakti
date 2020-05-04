#!/bin/bash
#
#       Ezanvakti sıradaki vakit gösterme bileşeni
#
#

siradaki_vakit_al() { # {{{
  ezanveri_denetle; bugun

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah_n; kalan
      siradaki_vakit_adi="Sabah"
      siradaki_vakit_kalan="$kalan_sure"

  elif (( UNIXSAAT < ogle ))
  then
      bekleme_suresi $ogle_n; kalan
      siradaki_vakit_adi="Öğle"
      siradaki_vakit_kalan="$kalan_sure"

  elif (( UNIXSAAT < ikindi ))
  then
      bekleme_suresi $ikindi_n; kalan
      siradaki_vakit_adi="İkindi"
      siradaki_vakit_kalan="$kalan_sure"

  elif (( UNIXSAAT < aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      siradaki_vakit_adi="Akşam"
      siradaki_vakit_kalan="$kalan_sure"

  elif (( UNIXSAAT < yatsi ))
  then
      bekleme_suresi $yatsi_n; kalan
      siradaki_vakit_adi="Yatsı"
      siradaki_vakit_kalan="$kalan_sure"

  elif  (( UNIXSAAT < yeni_gun ))
  then
      bekleme_suresi_yarin $ysabah_n; kalan
      siradaki_vakit_adi="Sabah (yarın)"
      siradaki_vakit_kalan="$kalan_sure"
  fi
}

siradaki_vakit() {
  local istek="$1"
  renk_denetle

  case $istek in
    siradaki)
      printf "${RENK7}${RENK3}\n${siradaki_vakit_adi} ezanı : ${RENK2}$siradaki_vakit_kalan${RENK0}\n\n" ;;
    conky_siradaki)
      printf "${siradaki_vakit_adi} : ${siradaki_vakit_kalan}\n"  |
        sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:' ;;
    bildirim)
      notify-send "${AD^} - Sıradaki vakit" \
        "$(printf "${siradaki_vakit_adi} : ${siradaki_vakit_kalan}\n" | sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:')" \
        -t $BILGI_BILDIRIM_SURESI"000" -i ${AD} ;;
  esac
}

kalan_sure() {
  local printf_bicim
  siradaki_vakit_al; renk_denetle
  clear

  ucbirim_basligi "Kalan Süre Gösterici"
  printf "${RENK7}${RENK4}${siradaki_vakit_adi} için bekleniyor...${RENK0}\n"

  while (( bekle ))
  do
    # Her 12 saniyede bir süreyi sapmaya karşı düzelt.
    (( bekle % 12 == 0 )) && siradaki_vakit_al

    printf_bicim="${RENK7}${RENK2}Kalan süre:"
    printf_bicim+="${RENK5} %02d saat : %02d dakika : %02d saniye "
    printf_bicim+="${RENK2}(${RENK1}%s${RENK2})${RENK0}\r"

    printf "${printf_bicim}" \
            $(( bekle / 3600 )) \
            $(( bekle % 3600 / 60 )) \
            $(( bekle % 60 )) \
            "${siradaki_vakit_kalan}"
    (( bekle-- ))
    sleep 1
  done
  kalan_sure
}
# }}}

# vim: set ft=sh ts=2 sw=2 et:
