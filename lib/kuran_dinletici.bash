#
#
#
#
#

function sure_girdisi_denetimi() { # sure_girdisi_yonetimi {{{
  if [[ -n $(tr -d 0-9 <<<$girdi) ]]
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı girdi: \`$girdi' " \
        'Sure kodu olarak 1-114 arası sayısal bir değer giriniz.'
      exit 1
  elif (( ! ${#girdi} ))
  then
      printf "${AD}: Bu özelliğin kullanımı için ek olarak sure kodu girmelisiniz.\n"
      exit 1
  elif (( ${#girdi} > 3 ))
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı girdi: \`$girdi' " \
        'Girilen sure kodunun basamak sayısı <= 3 olmalı.'
      exit 1
  elif (( girdi < 1 || girdi > 114 ))
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı girdi: \`$girdi' " \
        'Girilen sure kodu 1 <= sure_kodu <= 114 arasında olmalı.'
      exit 1
  else  # Girilen sure koduna göre değişkenin önüne sıfır ekle.
      if (( ${#girdi} == 1 ))
      then
          sure=00$girdi
      elif (( ${#girdi} == 2 ))
      then
          sure=0$girdi
      else
          sure=$girdi
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
  [[ -f "${YEREL_SURE_DIZINI}/$sure.mp3" ]] && {
    dinletilecek_sure="${YEREL_SURE_DIZINI}/$sure.mp3"
    kaynak='Yerel Dizin'
    okuyan='Yerel Okuyucu'
  } || {
          # Seçilen okuyucu koduna göre okuyucunun tam adını yeni değere ata.
          [ ${OKUYAN} = AlGhamdi  ] && okuyan='Saad el Ghamdi' \
          || {
          [ ${OKUYAN} = AsShatree ] && okuyan='As Shatry'
          } || {
          [ ${OKUYAN} = AlAjmy    ] && okuyan='Ahmad el Ajmy'
          }

    dinletilecek_sure="http://www.listen2quran.com/listen/${OKUYAN}/$sure.mp3"
    kaynak='http://www.listen2quran.com'
  }

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
  local girdi="$2"

  case $1 in
    secim) sure_girdisi_denetimi; kuran_dinletimi ;;
    hatim)
      for ((i=1; i<=114; i++))
      {
        girdi=$i
        sure_girdisi_denetimi; kuran_dinletimi; sleep 1.5
      } ;;
    rastgele)
      girdi=$((RANDOM%114))
      (( ! girdi )) && girdi=114
      sure_girdisi_denetimi; kuran_dinletimi ;;
    gunluk)
      read -ra sureler <<<$SURELER
      for i in ${sureler[@]}
      do
        girdi=$i
        sure_girdisi_denetimi; kuran_dinletimi; sleep 1.5
      done ;;
  esac
} # }}}


# vim: set ft=sh ts=2 sw=2 et:
