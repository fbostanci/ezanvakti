#!/bin/bash
#
#          Ezanvakti Çokluortam Bileşeni
#
#

radyo_ac() {
  bilesen_yukle oynatici_yonetici
  local radyo
  PS3='Dinlemek istediğiniz radyoyu seçiniz: '

  select radyo in "${!RADYOLAR[@]}"
  do
    [[ -v RADYOLAR[$radyo] ]] || exit 1
    if [[ -x $(type -p vlc) ]]
    then
         vlc -I curses "${RADYOLAR[$radyo]}"
    else
        ortam_deger=e
        printf "${RENK7}${RENK2} $radyo${RENK3} dinletiliyor...${RENK0}\n"
        oynatici_calistir "${RADYOLAR[$radyo]}"
    fi
    break
  done
}

tv_ac() {
  bilesen_yukle oynatici_yonetici
  local tv
  ortam_deger=e
  tv_deger=e
  PS3='Seyretmek istediğiniz yayını seçiniz: '

  select tv in "${!TVLER[@]}"
  do
    [[ -v TVLER[$tv] ]] || exit 1
    printf "${RENK7}${RENK2} $tv${RENK3} oynatılıyor...${RENK0}\n"
    oynatici_calistir "${TVLER[$tv]}"
    break
  done
}
