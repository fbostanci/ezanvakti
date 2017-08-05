#!/bin/bash
#
#
#
#

bekleme_goster() {
  local vakit="$1" vakit_saati="$2"
  renk_denetle

  clear
  printf "${RENK7}${RENK4}${vakit} için bekleniyor...${RENK0}\n"
  bekleme_suresi ${vakit_saati}
  while (( bekle ))
  do
    # Her 12 saniyede bir süreyi sapmaya karşı düzelt.
    (( bekle % 12 == 0 )) && bekleme_suresi ${vakit_saati}

    printf "${RENK7}${RENK2}Kalan süre:${RENK5} %02d saat : %02d dakika : %02d saniye ${RENK2}(${RENK1}%s${RENK2})${RENK0}\r" \
            $(( bekle / 3600 )) \
            $(( bekle % 3600 / 60 )) \
            $(( bekle % 60 )) \
            "${vakit_saati}"
    (( bekle-- ))
    sleep 1
  done
}

kalan_sure() {
  ezanveri_denetle; bugun

  ucbirim_basligi "Kalan Süre Gösterici"

  (( UNIXSAAT < sabah )) && {
    bekleme_goster "Sabah ezanı" $sabah_n
    kalan_sure
  }

  (( UNIXSAAT < ogle )) && {
    bekleme_goster "Öğle ezanı" $ogle_n
    kalan_sure
  }

  (( UNIXSAAT < ikindi )) && {
    bekleme_goster "İkindi ezanı" $ikindi_n
    kalan_sure
  }

  (( UNIXSAAT < aksam )) && {
    bekleme_goster "Akşam ezanı" $aksam_n
    kalan_sure
  }

  (( UNIXSAAT < yatsi )) && {
    bekleme_goster "Yatsı ezanı" $yatsi_n
    kalan_sure
  }

  (( UNIXSAAT < yeni_gun )) && {
    bekleme_goster "Yeni gün" "23:59:59"
    sleep 1; kalan_sure
  }
}

# vim: set ft=sh ts=2 sw=2 et:
