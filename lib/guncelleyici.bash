#
#
#                           Ezanvakti Güncelleme  Bileşeni 1.8
#
#

# TODO: ilçeler için destek eklenecek

function guncelleme_yap() {
  local arayuz ulke sehir varsayilan_sehir

  test x"${ULKE}" = x && {
    ULKE=yok_boyle_bir_yer
  }
  test x"${SEHIR}" = x && {
    SEHIR=yok_boyle_bir_yer
  }
  test x"${ILCE}" = x && {
    ILCE=yok_boyle_bir_yer
  }
function arayuz_denetle() {

  if test -x "$(which yad 2>/dev/null)"
  then
      arayuz=1
  elif test -x "$(which kdialog 2>/dev/null)"
  then
      arayuz=2
  elif test -x "$(which zenity 2>/dev/null)"
  then
      arayuz=3
  else
      printf '%b\n%b\n%b\n' \
        "${RENK7}${RENK3}Bu özellik YAD, Zenity ya da Kdialog ile çalışmaktadır." \
        "Sisteminizde istenen uygulamalar bulunamadı." \
        "Konum bilgilerinizi ayarlar dosyasına elle girip yeniden deneyin${RENK0}"
      exit 1
  fi
}

IFS="
"
[[ -z $(grep -w ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER) ]] && {
  arayuz_denetle

  if (( arayuz == 1 ))
  then
      ulke=`yad --entry --entry-text 'TURKIYE' $( < ${VERI_DIZINI}/ulkeler/AAA-ULKELER) \
            --title 'Ülke belirleme'  --text 'Bulunduğunuz ülkeyi seçin'`
            (( $? == 1 )) && exit 1
  elif (( arayuz == 2 ))
  then
      ulke=`kdialog --combobox 'Bulunduğunuz ülkeyi seçin'  --title 'Ülke belirleme' \
            --default 'TURKIYE' $( < ${VERI_DIZINI}/ulkeler/AAA-ULKELER)`
            (( $? == 1 )) && exit 1
  elif (( arayuz == 3 ))
  then
      ulke=`zenity --entry --entry-text 'TURKIYE' $( < ${VERI_DIZINI}/ulkeler/AAA-ULKELER) \
            --title 'Ülke belirleme' --text 'Bulunduğunuz ülkeyi seçin'`
            (( $? == 1 )) && exit 1
  fi

  sed -i "s:\(ULKE=\).*:\1\'${ulke}\':" "${EZANVAKTI_AYAR}"
} || {
  ulke=${ULKE}
}


# Şehir bilgisi şehirler dosyasındakine uygun girilmiş mi?
# Uygunsa bilgiyi kullan, uygun değilse kullanıcıdan al.
[[ -z $(grep -w ${SEHIR} ${VERI_DIZINI}/ulkeler/${ulke}) ]] && {
  arayuz_denetle

  if [ "${ulke}" = "TURKIYE" ]
  then
      varsayilan_sehir=ISTANBUL
  else
      varsayilan_sehir="$(head -1 ${VERI_DIZINI}/ulkeler/${ulke})"
  fi

  if (( arayuz == 1 ))
  then
      sehir=`yad --entry --entry-text ${varsayilan_sehir} $( < ${VERI_DIZINI}/ulkeler/${ulke}) \
            --title 'Şehir belirleme' --text 'Bulunduğunuz şehri seçin'`
            (( $? == 1 )) && exit 1
  elif (( arayuz == 2 ))
  then
      sehir=`kdialog --combobox 'Bulunduğunuz şehri seçin' --title 'Şehir belirleme' \
            --default ${varsayilan_sehir} $( < ${VERI_DIZINI}/ulkeler/${ulke})`
            (( $? == 1 )) && exit 1
  elif (( arayuz == 3 ))
  then
      sehir=`zenity --entry --entry-text ${varsayilan_sehir} $( < ${VERI_DIZINI}/ulkeler/${ulke}) \
            --title 'Şehir belirleme' --text 'Bulunduğunuz şehri seçin'`
            (( $? == 1 )) && exit 1
  fi

  sed -i "s:\(SEHIR=\).*:\1\'${sehir}\':" "${EZANVAKTI_AYAR}"
} || {
  sehir=${SEHIR}
}

###### TODO:
####ILCE İŞLEMLERİ
###### TODO:

unset IFS

printf "${RENK7}${RENK3}${EZANVERI_ADI} dosyası güncelleniyor..${RENK0}\n"

# HACK: internet bağlantı sınaması yöntemini değiştir.
if ! { ping -q -w 1 -c 1 `ip r | grep default | cut -d' ' -f 3` &> /dev/null; }
then
    printf '%s\n%s\n' \
      "${RENK7}${RENK3}İnternet erişimi algılanamadı." \
      "Çıkılıyor....${RENK0}"
    exit 1
fi

${BILESEN_DIZINI}/ezanveri_guncelle.pl "${ulke}" "${sehir}" "${ilce}" | \
sed -e 's:[[:alpha:]]::g' -e 's:[^[:blank:]]*\.:\n&:2g' | sed -e '1,4d' -e 's: : :g' > /tmp/ezanveri-$$

echo -e "\
\n\n\n# BİLGİ: ${ilce} / ${sehir} / ${ulke} için 30 günlük namaz vakitleridir. Çizelge,
# 'http://www.diyanet.gov.tr/turkish/namazvakti/vakithes_namazvakti.asp'
# adresinden ezanvakti uygulaması tarafından istenerek oluşturulmuştur.

# Son güncelleme : $(date +%c)" >> /tmp/ezanveri-$$

  (( $(wc -l < /tmp/ezanveri-$$) >= 20 )) && {
    mv -f /tmp/ezanveri-$$ "${EZANVERI}"
    printf "${RENK7}${RENK2}Başarılı..${RENK0}\n"
    . "${EZANVAKTI_AYAR}"
    ## TODO: Buraya renk denetimi eklenecek
    notify-send "Ezanvakti $SURUM" "${EZANVERI_ADI} dosyası başarıyla güncellendi." \
      -i ${VERI_DIZINI}/simgeler/ezanvakti.png -t $GUNCELLEME_BILDIRIM_SURESI"000" -h int:transient:1
      :> /tmp/eznvrgncldntle_$(date +%d%m%y)
  } || {
    printf "${RENK7}${RENK3}Başarısız..${RENK0}\n"
    notify-send "Ezanvakti $SURUM" "${EZANVERI_ADI} dosyasının güncellenmesi başarısız oldu." \
      -i ${VERI_DIZINI}/simgeler/ezanvakti.png -t $GUNCELLEME_BILDIRIM_SURESI"000" -h int:transient:1
    exit 1
  }
}

# vim: set ft=sh ts=2 sw=2 et:
