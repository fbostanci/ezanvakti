#!/bin/bash
#
#       Ezanvakti Kuran dinletme bileşeni
#
#

function sure_no_denetimi() { # sure_no_yonetimi {{{
  if [[ -n $(tr -d 0-9 <<<$sure_no) ]]
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_no: \`$sure_no' " \
        'Sure kodu olarak 1-114 arası sayısal bir değer giriniz.'
      exit 1

  elif (( ! ${#sure_no} ))
  then
      printf "${AD}: Bu özelliğin kullanımı için ek olarak sure kodu girmelisiniz.\n"
      exit 1

  elif (( ${#sure_no} > 3 ))
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_no: \`$sure_no' " \
        'Girilen sure kodunun basamak sayısı <= 3 olmalı.'
      exit 1

  elif (( sure_no < 1 || sure_no > 114 ))
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

function kuran_dinletimi() {
  local -a sureler

  clear
  printf '%b%b\n\n' \
    "${RENK7}${RENK3}" \
    "$(gawk -v sure=$sure 'BEGIN{gsub("^0*","",sure);} NR==sure {print($4);}' \
    ${VERI_DIZINI}/veriler/sure_bilgisi)${RENK2} suresi dinletiliyor...${RENK0}"

  # Öncelikle kullanıcının girdiği dizinde dosya
  # var mı denetle. Yoksa çevrimiçi dinletime yönel.
  if [[ -f ${YEREL_SURE_DIZINI}/$sure.mp3 ]]
  then
      dinletilecek_sure="${YEREL_SURE_DIZINI}/$sure.mp3"
      kaynak='Yerel Dizin'
      okuyan='Yerel Okuyucu'
  else
      # Seçilen okuyucu koduna göre okuyucunun tam adını yeni değere ata.
      if [[ ${OKUYAN} = AlGhamdi ]]
      then
          okuyan='Saad el Ghamdi'
      elif [[ ${OKUYAN} = AsShatree ]]
      then
          okuyan='As Shatry'
      elif [[ ${OKUYAN} = AlAjmy ]]
      then
          okuyan='Ahmad el Ajmy'
      fi
  fi
  dinletilecek_sure="http://www.listen2quran.com/listen/${OKUYAN}/$sure.mp3"
  kaynak='http://www.listen2quran.com'

  bilesen_yukle mplayer_yonetici
  ucbirim_basligi "$(gawk -v sure=$sure 'BEGIN{gsub("^0*","",sure);} NR==sure {print($4);}' \
    ${VERI_DIZINI}/veriler/sure_bilgisi) Suresi"

  printf '%b%b\n%b\n' \
    "${RENK7}${RENK2}" \
    "Okuyan : ${RENK3} ${okuyan}${RENK2}" \
    "Kaynak : ${RENK3} ${kaynak}${RENK0}"

  mplayer_calistir "${dinletilecek_sure}"
}

function kuran_dinlet() { # kuran_dinlet_yonetimi {{{
  local dinletilecek_sure okuyan kaynak sure i
  local sure_no="$2"

  renk_denetle

  case $1 in
    secim) sure_no_denetimi; kuran_dinletimi ;;
    hatim)
      for ((i=1; i<=114; i++))
      {
        sure_no=$i
        sure_no_denetimi; kuran_dinletimi; sleep 1.5
      } ;;

    rastgele)
      sure_no=$(( RANDOM % 114 ))
      (( ! sure_no )) && sure_no=114
        sure_no_denetimi; kuran_dinletimi ;;

    gunluk)
      read -ra sureler <<<$SURELER

      for i in ${sureler[@]}
      do
        sure_no=$i
        sure_no_denetimi; kuran_dinletimi; sleep 1.5
      done ;;

  esac
} # }}}


# vim: set ft=sh ts=2 sw=2 et:
