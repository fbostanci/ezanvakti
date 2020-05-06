#!/bin/bash
#
#       Ezanvakti Kuran dinletme bileşeni
#
#
#

kuran_dinletimi() {
  local parca_suresi parca_suresi_n okuyan kaynak dinletilecek_sure
  local sure_adi sure_ayet_sayisi cuz yer

  # girileni denetleyip
  # sure_kod değişkenine atayacak. (temel_islevler.bash)
  sure_no_denetle "$1"
  export $(gawk -v sira=$sure_kod '{if(NR==sira) {printf \
    "sure_adi=%s\nsure_ayet_sayisi=%s\ncuz=%s\nyer=%s",$4,$2,$5,$6}}' \
    < ${VERI_DIZINI}/veriler/sure_bilgisi)

  clear
  # okuyan, kaynak, dinletilecek_sure
  # değerlerini bu fonksiyon gönderiyor. (temel_islevler.bash)
  kuran_okuyan_denetle "$sure_kod"
  printf '%b%b\n\n' \
    "${RENK7}${RENK3}" \
    "${sure_adi}${RENK2} suresi dinletiliyor...${RENK0}"

  bilesen_yukle oynatici_yonetici
  ucbirim_basligi "${sure_adi} Suresi"

  # verilen ses dosyasının süresini sa,dk,ve sn'ye çevirip
  # parca_suresi_n değişkenine atar. (oynatici_yonetici.bash)
  oynatici_sure_al "${dinletilecek_sure}"

  printf '%b%b\n%b\n%b\n%b\n%b\n%b\n%b\n' \
    "${RENK7}${RENK2}" \
    "Sure no     : ${RENK3} ${sure_kod}${RENK2}" \
    "Ayet sayısı : ${RENK3} ${sure_ayet_sayisi}${RENK2}" \
    "Cüz         : ${RENK3} ${cuz}${RENK2}" \
    "İndiği yer  : ${RENK3} ${yer}${RENK2}" \
    "Okuyan      : ${RENK3} ${okuyan}${RENK2}" \
    "Süre        : ${RENK3} ${parca_suresi_n}${RENK2}" \
    "Kaynak      : ${RENK3} ${kaynak}${RENK0}"
  # (oynatici_yonetici.bash)
  oynatici_calistir "${dinletilecek_sure}"
}

kuran_dinlet() { # kuran_dinlet_yonetimi {{{
  local -a sureler
  renk_denetle

  case $1 in
    secim) kuran_dinletimi "${2:-null}";;
    hatim)
      for ((i=1; i<=114; i++))
      do
        kuran_dinletimi "$i"
        sleep 1
      done ;;
    rastgele)
      sure_no=$(( RANDOM % 114 ))
      (( ! sure_no )) && sure_no=114
      kuran_dinletimi "$sure_no" ;;
    gunluk)
      read -ra sureler <<<$SURELER
      for i in ${sureler[@]}
      do
        kuran_dinletimi "$i"
        sleep 1
      done ;;
  esac
} # }}}

# vim: set ft=sh ts=2 sw=2 et:
