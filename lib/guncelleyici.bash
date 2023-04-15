#!/bin/bash
#
#                           Ezanvakti Güncelleme  Bileşeni 3.1
#
#

guncelleme_yap() { ### Ana fonksiyon {{{
  local arayuz au ulke sehir ilce varsayilan_sehir varsayilan_ilce stn ESKI_IFS
  local ulke_kodu sehir_kodu ilce_kodu basamak_payi renksiz_payi bas_renksiz_payi
  local e=0 denetim=0

  SECONDS=0
  stn=$(tput cols)

  if [[ $1 = yenile ]]
  then
      ULKE=''
      SEHIR=''
      ILCE=''
  fi

  # konum bilgileri boş ise
  [[ -z "${ULKE}"  ]] && ULKE=yok_boyle_bir_yer
  [[ -z "${SEHIR}" ]] && SEHIR=yok_boyle_bir_yer
  [[ -z "${ILCE}"  ]] && ILCE=yok_boyle_bir_yer
  renk_denetle

  if (( ! ${RENK:-RENK_KULLAN} ))
  then
      renksiz_payi=17
      bas_renksiz_payi=11
  else
      renksiz_payi=0
      bas_renksiz_payi=0
  fi

arayuz_denetle() { ### Arayüz denetle {{{
  # Ülke, şehir, ilçe seçimlerinde
  # çağrılıyor. bir kez arayuz
  # seçildiyse bir daha denetim
  # yapmasın. (denetim=1 ise)
  if (( denetim ))
  then return 0
  else denetim=1
  fi

  printf '%b%s%b' "${RENK7}${RENK8}" \
    'Arayüz uygulaması denetleniyor...' "${RENK0}"

  if [[ -x $(type -p kdialog) ]]
  then
      arayuz=1
      au=Kdialog

  elif [[ -x $(type -p yad) ]]
  then
      arayuz=2
      au=Yad

  elif [[ -x $(type -p zenity) ]]
  then
      arayuz=3
      au=Zenity

  else
      printf '%b%*b' "${RENK7}${RENK8}" $(( stn - 14 - renksiz_payi )) \
        "[${RENK1}  BAŞARISIZ ${RENK8}]${RENK0}\n"

      printf '\n%b\n%b\n%b\n' \
        "${RENK7}${RENK3}Bu özellik YAD, Zenity ya da Kdialog ile çalışmaktadır." \
        "Sisteminizde istenen uygulamalardan herhangi biri bulunamadı." \
        "Konum bilgilerinizi ayarlar dosyasına elle girip yeniden deneyin.${RENK0}"
      exit 1

  fi
  printf '%b%*b' "${RENK7}${RENK8}" $(( stn - 14 - renksiz_payi )) \
    "[${RENK2}  BAŞARILI  ${RENK8}]${RENK0}\n"

  printf '%b\n' \
    "${RENK7}${RENK3} ->${RENK8} Kullanılacak uygulama:${RENK2} ${au}${RENK0}"
}
#}}}
ESKI_IFS="$IFS"
IFS=$'\n'
### Ülke işlemleri {{{
######################################################################
#                         ÜLKE İŞLEMLERİ                             #
######################################################################

if ! grep -qw ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER
then
    arayuz_denetle
    case "$arayuz" in
      1)
        ulke=$(kdialog --combobox 'Bulunduğunuz ülkeyi seçin' --title 'Ülke belirleme' \
              --default 'TURKIYE' $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/AAA-ULKELER))
        (( $? == 1 )) && exit 1 ;;

      2)
        ulke=$(yad --entry --entry-text 'TURKIYE' $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/AAA-ULKELER) \
              --width=300 --sticky --center --window-icon=${AD} \
              --title 'Ülke belirleme'  --text 'Bulunduğunuz ülkeyi seçin')
        (( $? == 1 )) && exit 1 ;;

      3)
        ulke=$(zenity --entry --entry-text 'TURKIYE' $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/AAA-ULKELER) \
              --title 'Ülke belirleme' --text 'Bulunduğunuz ülkeyi seçin')
        (( $? == 1 )) && exit 1 ;;

    esac
    printf "${RENK7}${RENK3} ->${RENK8} Seçilen ülke:${RENK2}  ${ulke}${RENK0}\n"
    sed -i "s:\(ULKE=\).*:\1\'${ulke}\':" "${EZANVAKTI_AYAR}"
else
    ulke=${ULKE}
fi
ulke_kodu=$(grep -w ${ulke} ${VERI_DIZINI}/ulkeler/AAA-ULKELER | cut -d, -f2)
#}}}

### Şehir işlemleri {{{
######################################################################
#                         ŞEHİR İŞLEMLERİ                            #
######################################################################

# Şehir bilgisi şehirler dosyasındakine uygun girilmiş mi?
# Uygunsa bilgiyi kullan, uygun değilse kullanıcıdan al.
if ! grep -qw ${SEHIR} ${VERI_DIZINI}/ulkeler/${ulke}
then
    arayuz_denetle

    if [[ ${ulke} = TURKIYE ]]
    then
        varsayilan_sehir='ISTANBUL'
    else
        varsayilan_sehir=$(head -1 ${VERI_DIZINI}/ulkeler/${ulke} | cut -d, -f1)
    fi

    case "$arayuz" in
      1)
        sehir=$(kdialog --combobox 'Bulunduğunuz şehri seçin' --title 'Şehir belirleme' \
                --default ${varsayilan_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}))
        (( $? == 1 )) && exit 1 ;;

      2)
        sehir=$(yad --entry --entry-text ${varsayilan_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}) \
                --width=300 --sticky --center --window-icon=${AD} \
                --title 'Şehir belirleme' --text 'Bulunduğunuz şehri seçin')
        (( $? == 1 )) && exit 1 ;;

      3)
        sehir=$(zenity --entry --entry-text ${varsayilan_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}) \
                --title 'Şehir belirleme' --text 'Bulunduğunuz şehri seçin')
        (( $? == 1 )) && exit 1 ;;

    esac
    printf "${RENK7}${RENK3} ->${RENK8} Seçilen şehir:${RENK2} ${sehir}${RENK0}\n"
    sed -i "s:\(SEHIR=\).*:\1\'${sehir}\':" "${EZANVAKTI_AYAR}"
else
    sehir=${SEHIR}
fi
sehir_kodu=$(grep -w ${sehir} ${VERI_DIZINI}/ulkeler/${ulke} | cut -d, -f2)
#}}}

### İlçe işlemleri {{{
######################################################################
#                         İLÇE İŞLEMLERİ                             #
######################################################################

if [[ ${ulke} = @(TURKIYE|ABD|ALMANYA|KANADA) ]]
then
    if ! grep -qw ${ILCE} ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}
    then
        if [[ $(wc -l < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) -eq 1 ]]
        then
            ilce=$(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir})
            printf "${RENK7}${RENK3} ->${RENK8} Seçilen ilçe:${RENK2}  ${ilce}${RENK3} (tek ilçe)${RENK0}\n"

        else
            arayuz_denetle
            [[ ${ulke} = TURKIYE ]] && g_sehir=${sehir} ||
                                       g_sehir=$(head -1 ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}| cut -d, -f1)
            case "$arayuz" in
              1)
                ilce=$(kdialog --combobox 'Bulunduğunuz ilçeyi seçin' --title 'İlçe belirleme' \
                      --default ${g_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}))
                (( $? == 1 )) && exit 1 ;;

              2)
                ilce=$(yad --entry --entry-text ${g_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) \
                      --width=300 --sticky --center --window-icon=${AD} --title 'İlçe belirleme' \
                      --text 'Bulunduğunuz ilçeyi seçin')
                (( $? == 1 )) && exit 1 ;;

              3)
                ilce=$(zenity --entry --entry-text ${g_sehir} $(cut -d, -f1 < ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir}) \
                      --title 'İlçe belirleme' --text 'Bulunduğunuz ilçeyi seçin')
                (( $? == 1 )) && exit 1 ;;

            esac
            printf "${RENK7}${RENK3} ->${RENK8} Seçilen ilçe:${RENK2}  ${ilce}${RENK0}\n"
        fi
        sed -i "s:\(ILCE=\).*:\1\'${ilce}\':" "${EZANVAKTI_AYAR}"
    else
        ilce=${ILCE}
    fi
    ilce_kodu=$(grep -w ${ilce} ${VERI_DIZINI}/ulkeler/${ulke}_ilceler/${sehir} | cut -d, -f2)
else
    ilce=${sehir}; ilce_kodu=${sehir_kodu}
    sed -i "s:\(ILCE=\).*:\1\'${sehir}\':" "${EZANVAKTI_AYAR}"
fi
#}}}

IFS="$ESKI_IFS"

printf '%b%s%b' "${RENK7}${RENK8}" \
  'İnternet erişimi denetleniyor...' "${RENK0}"

# internet erişimini denetle.
if ! internet_erisimi_var_mi
then
    printf '%b%*b' "${RENK7}${RENK8}" $(( stn - 13 - renksiz_payi )) \
      "[${RENK1}  BAŞARISIZ ${RENK8}]${RENK0}\n"
    printf '\n%b\n' \
      "${RENK7}${RENK3}İnternet erişimi algılanamadı.${RENK0}"
    exit 1
fi

printf '%b%*b' "${RENK7}${RENK8}" $(( stn - 13 - renksiz_payi )) \
  "[${RENK2}  BAŞARILI  ${RENK8}]${RENK0}\n"
#}}}

### Güncelleme işlemi {{{
# denetim=0 ise
# ULKE,SEHIR,ILCE adları
# sorunsuz, seçim yapılmamış.
if (( ! denetim ))
then
    printf "${RENK7}${RENK3} ->${RENK8} Seçilmiş ülke:${RENK2}  ${ulke}${RENK0}\n"
    printf "${RENK7}${RENK3} ->${RENK8} Seçilmiş şehir:${RENK2} ${sehir}${RENK0}\n"
    printf "${RENK7}${RENK3} ->${RENK8} Seçilmiş ilçe:${RENK2}  ${ilce}${RENK0}\n"
fi

printf '%b%b' "${RENK7}${RENK8}" \
  "${EZANVERI_ADI} dosyası güncelleniyor...${RENK0}"

printf '#Tarih       Sabah  Güneş  Öğle   İkindi Akşam  Yatsı\n' >> /tmp/ezanveri-$$
indirici "https://namazvakitleri.diyanet.gov.tr/tr-TR/${ilce_kodu}" | \
sed -n 's:<td>\(.*\)</td>:\1:p' | sed -e 's:^ *::' -e 's:[^[:print:]]: :g' -e \
's: Ocak :.01.:;s: Şubat :.02.:;
 s: Mart :.03.:;s: Nisan :.04.:;
 s: Mayıs :.05.:;s: Haziran :.06.:;
 s: Temmuz :.07.:;s: Ağustos :.08.:;
 s: Eyl&#252;l :.09.:;s: Ekim :.10.:;
 s: Kasım :.11.:;s: Aralık :.12.:'  \
 -e 's:[[:blank:]]*$::' -e '2~8d' >> /tmp/ezanveri-$$
sed -i -r '1!{s:\S+::2;}' /tmp/ezanveri-$$
sed -i '1!{N;N;N;N;N;N;s:\n:  :g}' /tmp/ezanveri-$$


cat << SON >> /tmp/ezanveri-$$



# BİLGİ: ${ilce} / ${sehir} için 30 günlük ezan vakitleridir.
# Çizelge, 'http://namazvakitleri.diyanet.gov.tr'
# adresinden ${AD} uygulaması tarafından istenerek oluşturulmuştur.

# Son güncelleme : $(date +%c)
SON


if (( $(wc -l < /tmp/ezanveri-$$) >= 20 ))
then
    mv -f /tmp/ezanveri-$$ "${EZANVERI}"
    printf '%b%*b' "${RENK7}${RENK8}" $(( stn - ${#EZANVERI_ADI} - 6 - renksiz_payi )) \
      "[${RENK2}  BAŞARILI  ${RENK8}]${RENK0}\n"
    # ayarlar dosyasındaki konum bilgileri
    # değişmiş olabilir. Ayarları yeniden al.
    . "${EZANVAKTI_AYAR}"

    renk_denetle
    notify-send "${AD^}" "${EZANVERI_ADI} dosyası başarıyla güncellendi." \
      -i ${AD} -t $GUNCELLEME_BILDIRIM_SURESI"000"
    :> /tmp/.${AD}_eznvrgncldntle_$(date +%d%m%y)

else
    printf '%b%*b' "${RENK7}${RENK8}" $(( stn - ${#EZANVERI_ADI} - 7 - renksiz_payi )) \
      "[${RENK1}  BAŞARISIZ ${RENK8}]${RENK0}"
    printf "${RENK7}${RENK4}\n!!! YENIDEN DENEYIN !!!${RENK0}\n"

    notify-send "${AD^}" "${EZANVERI_ADI} dosyasının güncellenmesi başarısız oldu." \
      -i ${AD} -t $GUNCELLEME_BILDIRIM_SURESI"000"

    rm -f /tmp/ezanveri-$$ > /dev/null 2>&1
    exit 1

fi #}}}

# şehir bilgisi değiştiği için ezanvakti-sleep bileşenini
# yeniden başlat.
if [[ $1 = yenile ]]
then
    if pgrep ${AD}-sleep > /dev/null
    then
        pkill ${AD}-sleep
    fi
    if (( ACILISTA_BASLAT ))
    then
        printf '%b%s%s%b' "${RENK7}${RENK8}" \
          "${AD}-sleep" ' bileşeni yeniden başlatılıyor...' "${RENK0}"

        ${BILESEN_DIZINI}/${AD}-sleep > /dev/null &
        disown

        printf '%b%*b' "${RENK7}${RENK8}" $(( stn - ${#AD} - 20 - renksiz_payi )) \
      "[${RENK2}  BAŞARILI  ${RENK8}]${RENK0}\n"
    fi
fi

case "${#SECONDS}" in
  1) basamak_payi='18' ;;
  2) basamak_payi='16' ;;
  3) basamak_payi='14' ;;
  *) basamak_payi='12' ;;
esac
printf '%b%*b' "${RENK7}${RENK8}Güncelleme için geçen süre: " \
  $(( stn - ${#SECONDS} - basamak_payi - bas_renksiz_payi )) \
  "${RENK2}${SECONDS} saniye${RENK0}\n"
} #}}}

# vim: set ft=sh ts=2 sw=2 et:
