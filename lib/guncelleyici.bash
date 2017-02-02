#
#
#                           Ezanvakti Güncelleme  Bileşeni 2.3
#
#

# TODO: uçbirim çıktılarını geometriye uydur.
function guncelleme_yap() { ### Ana fonksiyon {{{
  local arayuz au ulke sehir ilce varsayilan_sehir pm varsayilan_ilce dn sure ulke_kodu sehir_kodu ilce_kodu
  local e=0 denetim=0
  local -a pmler

  sure="${SECONDS}"
  test x"${ULKE}"  = x"" && ULKE=yok_boyle_bir_yer
  test x"${SEHIR}" = x"" && SEHIR=yok_boyle_bir_yer
  test x"${ILCE}"  = x"" && ILCE=yok_boyle_bir_yer
  renk_denetle

### Perl denetleme {{{
printf '%-59b' \
  "${RENK7}${RENK8}Perl bileşenleri denetleniyor..${RENK0}"

# Perl bileşenlerini denetle.
for pm in 'WWW::Mechanize'
do
    perl -M${pm} -e 1 2>/dev/null
    dn=$(echo $?)
    if [[ $dn -ne 0 ]]
    then
        pmler+=("$pm")
    fi
done

(( ${#pmler[@]} )) && {
  printf "${RENK7}${RENK8} [${RENK1}BAŞARISIZ${RENK8}]${RENK0}\n"
  printf '\n%b\n' \
    "${RENK7}${RENK3}Aşağıdaki perl bileşen(ler)i bulunamadı.${RENK0}"

  for pm in ${pmler[@]}
  do
      printf '%b\n' \
        "${RENK7}${RENK1} ->${RENK8} ${pmler[$e]}${RENK0}"
      ((e++))
  done
  exit 1
}

printf "${RENK7}${RENK8} [${RENK2}BAŞARILI${RENK8}]${RENK0}\n"
#}}}

function arayuz_denetle() { ### Arayüz denetle {{{
  (( denetim )) && return 0 || denetim=1
  printf '%-60b' \
    "${RENK7}${RENK8}Arayüz uygulaması denetleniyor..${RENK0}"

  if test -x "$(type -p kdialog)"
  then
      arayuz=1
      au=Kdialog
  elif test -x "$(type -p yad)"
  then
      arayuz=2
      au=Yad
  elif test -x "$(type -p zenity)"
  then
      arayuz=3
      au=Zenity
  else
      printf "${RENK7}${RENK8} [${RENK1}BAŞARISIZ${RENK8}]${RENK0}\n"
      printf '\n%b\n%b\n%b\n' \
        "${RENK7}${RENK3}Bu özellik YAD, Zenity ya da Kdialog ile çalışmaktadır." \
        "Sisteminizde istenen uygulamalar bulunamadı." \
        "Konum bilgilerinizi ayarlar dosyasına elle girip yeniden deneyin.${RENK0}"
      exit 1
  fi
  printf "${RENK7}${RENK8} [${RENK2}BAŞARILI${RENK8}]${RENK0}\n"
  printf '%b\n' \
    "${RENK7}${RENK3} ->${RENK8} Kullanılacak uygulama:${RENK2} ${au}${RENK0}"
}
#}}}

IFS="
"
### Ülke işlemleri {{{
######################################################################
#                         ÜLKE İŞLEMLERİ                             #
######################################################################

[[ -z $(grep -w ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER) ]] && {
  arayuz_denetle

  if (( arayuz == 1 ))
  then
      ulke=$(kdialog --combobox 'Bulunduğunuz ülkeyi seçin'  --title 'Ülke belirleme' \
             --default 'TURKIYE' $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/AAA-ULKELER))
      (( $? == 1 )) && exit 1


  elif (( arayuz == 2 ))
  then
      ulke=$(yad --entry --entry-text 'TURKIYE' $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/AAA-ULKELER) \
             --width=300 --sticky --center --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
             --title 'Ülke belirleme'  --text 'Bulunduğunuz ülkeyi seçin')
      (( $? == 1 )) && exit 1

  elif (( arayuz == 3 ))
  then
      ulke=$(zenity --entry --entry-text 'TURKIYE' $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/AAA-ULKELER) \
             --title 'Ülke belirleme' --text 'Bulunduğunuz ülkeyi seçin')
      (( $? == 1 )) && exit 1
  fi

  printf "${RENK7}${RENK3} ->${RENK8} Seçilen ülke:${RENK2}  ${ulke}${RENK0}\n"

  sed -i "s:\(ULKE=\).*:\1\'${ulke}\':" "${EZANVAKTI_AYAR}"
} || ulke=${ULKE}
ulke_kodu=$(grep -w ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER | cut -d, -f2)
#}}}

### Şehir işlemleri {{{
######################################################################
#                         ŞEHİR İŞLEMLERİ                            #
######################################################################

# Şehir bilgisi şehirler dosyasındakine uygun girilmiş mi?
# Uygunsa bilgiyi kullan, uygun değilse kullanıcıdan al.
[[ -z $(grep -w ${SEHIR} ${VERI_DIZINI}/ulkeler/${ulke}) ]] && {
  arayuz_denetle

  if [[ ${ulke} = TURKIYE ]]
  then
      varsayilan_sehir=ISTANBUL
  else
      varsayilan_sehir=$(head -1 ${VERI_DIZINI}/ulkeler/${ulke} | cut -d, -f1)
  fi

  if (( arayuz == 1 ))
  then
      sehir=$(kdialog --combobox 'Bulunduğunuz şehri seçin' --title 'Şehir belirleme' \
              --default ${varsayilan_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}))
      (( $? == 1 )) && exit 1

  elif (( arayuz == 2 ))
  then
      sehir=$(yad --entry --entry-text ${varsayilan_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}) \
              --width=300 --sticky --center --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
              --title 'Şehir belirleme' --text 'Bulunduğunuz şehri seçin')
      (( $? == 1 )) && exit 1

  elif (( arayuz == 3 ))
  then
      sehir=$(zenity --entry --entry-text ${varsayilan_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}) \
              --title 'Şehir belirleme' --text 'Bulunduğunuz şehri seçin')
      (( $? == 1 )) && exit 1
  fi

  printf "${RENK7}${RENK3} ->${RENK8} Seçilen şehir:${RENK2} ${sehir}${RENK0}\n"
  sed -i "s:\(SEHIR=\).*:\1\'${sehir}\':" "${EZANVAKTI_AYAR}"
} || sehir=${SEHIR}
sehir_kodu=$(grep -w ${SEHIR} ${VERI_DIZINI}/ulkeler/${ulke} | cut -d, -f2)
#}}}

### İlçe işlemleri {{{
######################################################################
#                         İLÇE İŞLEMLERİ                             #
######################################################################

if [[ ${ulke} = @(TURKIYE|ABD|KANADA) ]]
then
    [[ -z $(grep -w ${ILCE} ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) ]] && {
      if [[ $(wc -l < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) -eq 1 ]]
      then
          ilce=$(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir})
          printf "${RENK7}${RENK3} ->${RENK8} Seçilen ilçe:${RENK2}  ${ilce}${RENK3} (tek ilçe)${RENK0}\n"
      else
          arayuz_denetle
          [[ ${ulke} = TURKIYE ]] && g_sehir=${sehir} || 
                                     g_sehir=$(head -1 ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}| cut -d, -f1)

          if (( arayuz == 1 ))
          then
              ilce=$(kdialog --combobox 'Bulunduğunuz ilçeyi seçin' --title 'İlçe belirleme' \
                     --default ${g_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}))
              (( $? == 1 )) && exit 1

          elif (( arayuz == 2 ))
          then
              ilce=$(yad --entry --entry-text ${g_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) \
                     --width=300 --sticky --center --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
                     --title 'İlçe belirleme' --text 'Bulunduğunuz ilçeyi seçin')
              (( $? == 1 )) && exit 1

          elif (( arayuz == 3 ))
          then
              ilce=$(zenity --entry --entry-text ${g_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) \
                     --title 'İlçe belirleme' --text 'Bulunduğunuz ilçeyi seçin')
              (( $? == 1 )) && exit 1
          fi
          printf "${RENK7}${RENK3} ->${RENK8} Seçilen ilçe:${RENK2}  ${ilce}${RENK0}\n"
      fi

      sed -i "s:\(ILCE=\).*:\1\'${ilce}\':" "${EZANVAKTI_AYAR}"
    } || ilce=${ILCE}
    ilce_kodu=$(grep -w ${ILCE} ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir} | cut -d, -f2)

else
    ilce=${sehir}; ilce_kodu=${sehir_kodu}
    sed -i "s:\(ILCE=\).*:\1\'${sehir}\':" "${EZANVAKTI_AYAR}"
fi
#}}}

unset IFS

printf '%-60b' \
  "${RENK7}${RENK8}İnternet erişimi denetleniyor..${RENK0}"

# internet erişimini denetle.
wget -t 3 -T 10 www.google.com -O /tmp/baglantisina &>/dev/null
if ! [[ -s /tmp/baglantisina ]]
then
    printf "${RENK7}${RENK8} [${RENK1}BAŞARISIZ${RENK8}]${RENK0}\n"
    printf '\n%b\n%b\n' \
      "${RENK7}${RENK3}İnternet erişimi algılanamadı." \
      "Çıkılıyor...${RENK0}"
    exit 1
fi
rm -f /tmp/baglantisina &>/dev/null
printf "${RENK7}${RENK8} [${RENK2}BAŞARILI${RENK8}]${RENK0}\n"
#}}}

### Güncelleme işlemi {{{
printf '%-60b' \
  "${RENK7}${RENK8}${EZANVERI_ADI} dosyası güncelleniyor..${RENK0}"

printf "Tarih       Sabah  Güneş  Öğle   İkindi Akşam  Yatsı  Kıble\n" >> /tmp/ezanveri-$$
${BILESEN_DIZINI}/ezanveri_istemci.pl "${ulke_kodu}" "${sehir_kodu}" "${ilce_kodu}" 2>/tmp/ezv-perl-hata-$$ |
sed -n 's:<td class=".*">\(.*\)</td>:\1:p' | sed -e 's:^ *::' -e 's:[^[:print:]]: :g' |
gawk 'NR != 1 && /[0-9]+[.]/ { printf("\n") } { printf("%s ", $0); } END { printf("\n") }' >> /tmp/ezanveri-$$

cat << SON >> /tmp/ezanveri-$$



# BİLGİ: ${sehir} / ${ilce} için 30 günlük ezan vakitleridir.
# Çizelge, 'http://www.diyanet.gov.tr/tr/PrayerTime/WorldPrayerTimes'
# adresinden ezanvakti uygulaması tarafından istenerek oluşturulmuştur.

# Son güncelleme : $(date +%c)
SON


  (( $(wc -l < /tmp/ezanveri-$$) >= 20 )) && {
    mv -f /tmp/ezanveri-$$ "${EZANVERI}"
    printf "${RENK7}${RENK8} [${RENK2}BAŞARILI${RENK8}]${RENK0}\n"
    rm -f /tmp/ezv-perl-hata-$$ &>/dev/null
    . "${EZANVAKTI_AYAR}"

    renk_denetle
    notify-send "Ezanvakti $SURUM" "${EZANVERI_ADI} dosyası başarıyla güncellendi." \
      -i ${VERI_DIZINI}/simgeler/ezanvakti.png -t $GUNCELLEME_BILDIRIM_SURESI"000" -h int:transient:1
    :> /tmp/eznvrgncldntle_$(date +%d%m%y)
  } || {
    printf "${RENK7}${RENK8} [${RENK1}BAŞARISIZ${RENK8}]${RENK0}\n"
    printf "${RENK7}${RENK3}\n$( < /tmp/ezv-perl-hata-$$)${RENK0}\n"
    rm -f /tmp/ezv-perl-hata-$$ &>/dev/null
    printf "${RENK7}${RENK4}\n!!! YENIDEN DENEYIN !!!${RENK0}\n"

    notify-send "Ezanvakti $SURUM" "${EZANVERI_ADI} dosyasının güncellenmesi başarısız oldu." \
      -i ${VERI_DIZINI}/simgeler/ezanvakti.png -t $GUNCELLEME_BILDIRIM_SURESI"000" -h int:transient:1
    rm -f /tmp/ezanveri-$$ &>/dev/null
    exit 1
  } #}}}

printf '%-60b%b' \
  "${RENK7}${RENK8}Güncelleme için geçen süre: " \
  "${RENK2}$((${SECONDS}-${sure})) saniye${RENK0}\n"
} #}}}

# vim: set ft=sh ts=2 sw=2 et:
