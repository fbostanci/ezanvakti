#
#
#
#
#

function kuran_dinlet() { # kuran_dinlet_yonetimi {{{
  local dinletilecek_sure okuyan kaynak i

  case $1 in
    secim) sure_girdisi_denetimi ;;
    hatim)
      for ((i=1; i<=114; i++))
      {
        girdi=$i
        sure_girdisi_denetimi; sleep 1.5
      } ;;
    rastgele)
      girdi=$((RANDOM%114))
      (( ! girdi )) && girdi=114
      sure_girdisi_denetimi ;;
    gunluk)
      read -ra sureler <<<$SURELER
      for i in ${sureler[@]}
      do
        girdi=$i
        sure_girdisi_denetimi; sleep 1.5
      done
  esac

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

  clear
  printf '%b%b\n\n' \
    "${RENK7}${RENK3}" \
    "$(grep -w $sure ${VERI_DIZINI}/veriler/sureler | gawk '{print $2}')${RENK2} suresi dinletiliyor..."

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
    kaynak='http://www.quranlisten.com'
  }

  bilesen_yukle mplayer_calistir
  printf '%b%b\n%b\n' \
    "${RENK7}${RENK2}" \
    "Okuyan : ${RENK3} ${okuyan}${RENK2}" \
    "Kaynak : ${RENK3} ${kaynak}${RENK0}"

  mplayer_calistir "${dinletilecek_sure}"
} # }}}


# vim: set ft=sh ts=2 sw=2 et:
