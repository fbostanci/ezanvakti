#!/bin/bash
#
#       Ezanvakti Kuran dinletme bileşeni
#
#
# 
sure_no_denetimi() { # sure_no_yonetimi {{{
  sure_no="$(sed 's/^0*//' <<<$sure_no)"
  if [[ -n ${sure_no//[[:digit:]]/} ]]
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_no: \`$sure_no' " \
        'Sure kodu olarak 1-114 arası sayısal bir değer giriniz.'
      exit 1

  elif (( ! ${#sure_no} ))
  then
          printf '%s: bu özelliğin kullanımı için ek olarak sure kodu girmelisiniz.\n' "${AD}" >&2
          exit 1

  fi

  if (( sure_no < 1 || sure_no > 114 ))
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_no: \`$sure_no' " \
        'Girilen sure kodu 1 <= sure_kodu <= 114 arasında olmalı.'
      exit 1

  else  # Girilen sure koduna göre değişkenin önüne sıfır ekle.
      if (( ${#sure_no} == 1 ))
      then
          sure=00$sure_no
      elif (( ${#sure_no} == 2 ))
      then
          sure=0$sure_no
      else
          sure=$sure_no
      fi
  fi

} # }}}

kuran_dinletimi() {
  local parca_suresi parca_suresi_n okuyan kaynak dinletilecek_sure
  local sure_adi sure_ayet_sayisi cuz yer

  clear
  export $(gawk -v sira=$sure '{if(NR==sira) {printf \
    "sure_adi=%s\nsure_ayet_sayisi=%s\ncuz=%s\nyer=%s",$4,$2,$5,$6}}' \
    < ${VERI_DIZINI}/veriler/sure_bilgisi)

  printf '%b%b\n\n' \
    "${RENK7}${RENK3}" \
    "${sure_adi}${RENK2} suresi dinletiliyor...${RENK0}"

  # Öncelikle kullanıcının girdiği dizinde dosya
  # var mı denetle. Yoksa çevrimiçi dinletime yönel.
  if [[ -f ${YEREL_SURE_DIZINI}/$sure.mp3 ]]
  then
      dinletilecek_sure="${YEREL_SURE_DIZINI}/$sure.mp3"
      kaynak='Yerel Dizin'
      okuyan='Yerel Okuyucu'
  else
      # Seçilen okuyucu koduna göre okuyucunun tam adını yeni değere ata.
      if [[ ${KURAN_OKUYAN} = AlGhamdi ]]
      then
          okuyan='Saad el Ghamdi'
      elif [[ ${KURAN_OKUYAN} = AsShatree ]]
      then
          okuyan='As Shatry'
      elif [[ ${KURAN_OKUYAN} = AlAjmy ]]
      then
          okuyan='Ahmad el Ajmy'
      else
          printf '%s: Deskteklenmeyen KURAN_OKUYAN adı: %s\n' \
            "${AD}" "${KURAN_OKUYAN}" >&2
          exit 1
      fi
      dinletilecek_sure="http://www.listen2quran.com/listen/${KURAN_OKUYAN}/$sure.mp3"
      kaynak='http://www.listen2quran.com'
  fi


  bilesen_yukle oynatici_yonetici
  ucbirim_basligi "${sure_adi} Suresi"

  parca_suresi="$(oynatici_sure_al "${dinletilecek_sure}")"
  parca_suresi_n="$(oynatici_sure_cevir)"

  printf '%b%b\n%b\n%b\n%b\n%b\n%b\n%b\n' \
    "${RENK7}${RENK2}" \
    "Sure no     : ${RENK3} ${sure}${RENK2}" \
    "Ayet sayısı : ${RENK3} ${sure_ayet_sayisi}${RENK2}" \
    "Cüz         : ${RENK3} ${cuz}${RENK2}" \
    "İndiği yer  : ${RENK3} ${yer}${RENK2}" \
    "Okuyan      : ${RENK3} ${okuyan}${RENK2}" \
    "Süre        : ${RENK3} ${parca_suresi_n}${RENK2}" \
    "Kaynak      : ${RENK3} ${kaynak}${RENK0}"

  oynatici_calistir "${dinletilecek_sure}"
}

kuran_dinlet() { # kuran_dinlet_yonetimi {{{
  local sure_no="$2"
  local -a sureler

  renk_denetle

  case $1 in
    secim) sure_no_denetimi; kuran_dinletimi ;;
    hatim)
      for ((i=1; i<=114; i++))
      do
        sure_no=$i
        sure_no_denetimi; kuran_dinletimi
        sleep 1
      done ;;

    rastgele)
      sure_no=$(( RANDOM % 114 ))
      (( ! sure_no )) && sure_no=114
      sure_no_denetimi; kuran_dinletimi ;;

    gunluk)
      read -ra sureler <<<$SURELER

      for i in ${sureler[@]}
      do
        sure_no=$i
        sure_no_denetimi; kuran_dinletimi
        sleep 1
      done ;;

  esac
} # }}}


# vim: set ft=sh ts=2 sw=2 et:
