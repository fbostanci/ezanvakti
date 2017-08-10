#!/bin/bash
#
#
#
#

siradaki_vakit() {
  ezanveri_denetle; bugun

  if (( UNIXSAAT < sabah ))
  then
      siradaki_ezan='Sabah ezanı'
      siradaki_ezan_vakti=$sabah_n

  elif (( UNIXSAAT < ogle ))
  then
      siradaki_ezan='Öğle ezanı'
      siradaki_ezan_vakti=$ogle_n

  elif (( UNIXSAAT < ikindi ))
  then
      siradaki_ezan='İkindi ezanı'
      siradaki_ezan_vakti=$ikindi_n

  elif (( UNIXSAAT < aksam ))
  then
      siradaki_ezan='Akşam ezanı'
      siradaki_ezan_vakti=$aksam_n

  elif (( UNIXSAAT < yatsi ))
  then
      siradaki_ezan='Yatsı ezanı'
      siradaki_ezan_vakti=$yatsi_n

  elif (( UNIXSAAT < yeni_gun ))
  then
      siradaki_ezan='Yeni gün'
      siradaki_ezan_vakti='00:00'
  fi
}

kalan_sure() {
  renk_denetle
  clear

  ucbirim_basligi "Kalan Süre Gösterici"
  siradaki_vakit
  printf "${RENK7}${RENK4}${siradaki_ezan} için bekleniyor...${RENK0}\n"

  if [[ ${siradaki_ezan} = "Yeni gün" ]]
  then
      bekle=$(( yeni_gun - $(date +%s) ))
  else
      bekleme_suresi ${siradaki_ezan_vakti}
  fi

  while (( bekle ))
  do
    # sistemin askıya alınma durumuna karşı her 59 saniyede bir vakitleri yine al.
    (( bekle % 59 == 0 )) && siradaki_vakit
    # Her 12 saniyede bir süreyi sapmaya karşı düzelt.
    (( bekle % 12 == 0 )) && {
      if [[ ${siradaki_ezan} = "Yeni gün" ]]
      then
          bekle=$(( yeni_gun - $(date +%s) ))
      else
          bekleme_suresi ${siradaki_ezan_vakti}
      fi
    }

    printf "${RENK7}${RENK2}Kalan süre:${RENK5} %02d saat : %02d dakika : %02d saniye ${RENK2}(${RENK1}%s${RENK2})${RENK0}\r" \
            $(( bekle / 3600 )) \
            $(( bekle % 3600 / 60 )) \
            $(( bekle % 60 )) \
            "${siradaki_ezan_vakti}"
    (( bekle-- ))
    sleep 1
  done
}

# vim: set ft=sh ts=2 sw=2 et:
