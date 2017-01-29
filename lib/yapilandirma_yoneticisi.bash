#
#
#                           Ezanvakti Yapılandırma Yöneticisi Bileşeni 1.2
#

function yapilandirma() {
  local d1 d2 d3 d4 d5 d6 d7 d8 d9
  local ayr1 ayr2 ayr3 ayr4
  local _GUNCELLEME_YAP _OYNATICI_DURAKLAT _EZAN_DUASI_OKU 

(( GUNCELLEME_YAP      )) && d1=TRUE || d1=FALSE
(( OYNATICI_DURAKLAT )) && d2=TRUE || d2=FALSE
(( EZAN_DUASI_OKU      )) && d3=TRUE || d3=FALSE
(( SABAH_EZANI_OKU    )) && d4=TRUE || d4=FALSE
(( OGLE_EZANI_OKU      )) && d5=TRUE || d5=FALSE
(( IKINDI_EZANI_OKU     )) && d6=TRUE || d6=FALSE
(( AKSAM_EZANI_OKU   )) && d7=TRUE || d7=FALSE
(( YATSI_EZANI_OKU     )) && d8=TRUE || d8=FALSE
(( RENK_KULLAN           )) && d9=TRUE || d9=FALSE


ayr1=/tmp/ezanvakti_ayr1
ayr2=/tmp/ezanvakti_ayr2
ayr3=/tmp/ezanvakti_ayr3
ayr4=/tmp/ezanvakti_ayr4
#ayr4=$(mktemp --tmpdir tab4.XXXXXXXX)

ipcrm -M 190707  > /dev/null 2>&1

yad --plug=190707 --tabnum=1 --form \
--field='Ezanveri Adı:' \
--field='Ülke:' \
--field='Şehir:' \
--field='İlçe' \
--field='Otomatik Ezanveri Güncelleme:CHK' \
"${EZANVERI_ADI}" "${ULKE}" "${SEHIR}" "${ILCE}" "$d1" > $ayr1 &
yad --plug=190707 --tabnum=2 --form \
--field='Oynatıcı Duraklat:CHK' \
--field='Ezan Duası Oku:CHK' \
--field='Ezan Okunma Süresi Farkı:NUM' \
--field='Vakit animsat:NUM' \
--field='Sabah Ezanı:FL' \
--field='Öğle Ezanı:FL' \
--field='İkindi Ezanı:FL' \
--field='Akşam Ezanı:FL' \
--field='Yatsı Ezanı:FL' \
--field='Ezan Duası:FL' \
--field='Ezan okuyan:' \
"$d2" "$d3"  -- "$EZAN_OKUNMA_SURESI_FARKI[!-600..600][!60]]" \
 "$VAKIT_ANIMSAT[!0..60[!1]]"  "${SABAH_EZANI}" \
 "${OGLE_EZANI}" "${IKINDI_EZANI}" "${AKSAM_EZANI}" \
 "${YATSI_EZANI}" "${EZAN_DUASI}" "${EZAN_OKUYAN}"  > $ayr2 &
yad --plug=190707 --tabnum=3 --form \
--field='Sabah ezanı okunsun mu:CHK' \
--field='Öğle ezanı okunsun mu:CHK' \
--field='İkindi ezanı okunsun mu:CHK' \
--field='Akşam ezanı okunsun mu:CHK' \
--field='Yatsı ezanı okunsun mu:CHK' \
--field='Dini gün anımsat (sn. 0 ise kapalı):NUM' \
--field='Mplayer ses seviyesi:NUM' \
--field='Ezan Bildirim Süresi (sn):NUM' \
--field='Ayet Bildirim Süresi (sn):NUM' \
--field='Hadis Bildirim Süresi (sn):NUM' \
--field='Bilgi Bildirim Süresi (sn):NUM' \
--field='Güncelleme Bildirim Süresi (sn):NUM' \
"$d4" "$d5" "$d6" "$d7" "$d8" \
"$GUN_ANIMSATI[!0..30[!1]]" "$SES[!0..100[!1]]" \
"$EZAN_BILDIRIM_SURESI[!10..300[!1]]" \
"$AYET_BILDIRIM_SURESI[!10..30[!1]]" \
"$HADIS_BILDIRIM_SURESI[!10..30[!1]]" \
"$BILGI_BILDIRIM_SURESI[!10..30[!1]]" \
"$GUNCELLEME_BILDIRIM_SURESI[!10..30[!1]]" > $ayr3  &
yad --plug=190707 --tabnum=4 --form \
--field='Uçbirimde renk kullan:CHK' \
--field='RENK1 (Kırmızı):' \
--field='RENK2 (Yeşil):' \
--field='RENK3 (Sarı hareketli):' \
--field='RENK4 (Sarı hareketli):' \
--field='RENK5 (Türk mavisi):' \
--field='RENK6 (Türk mavisi altı çizgili):' \
--field='RENK7 (Artalan rengi):' \
--field='RENK8 (Beyaz):' \
--field=' Metin kutusu arka plan rengi:CLR' \
--field='Metin kutusu yazı rengi:CLR' \
"$d9" "${RENK1}" "${RENK2}" "${RENK3}" \
"${RENK4}" "${RENK5}" "${RENK6}" \
"${RENK7}" "${RENK8}" "${ARKAPLAN_RENGI}" \
"${YAZI_RENGI}"  > $ayr4 &
yad --notebook --key=190707 \
--title "Ezanvakti ${SURUM} - Yapılandırma Yöneticisi" \
--tab="Ezanveri Ayarları" --tab="Ezan Ayarları" \
--tab="Bildirim Ayarları"  --tab="Renk Ayarları" \
--fixed --sticky --center  --tab-borders=4 \
--window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--button='gtk-go-back:171' --button='gtk-open:172' \
--button='gtk-save:174' --button='gtk-quit:121'
ret=$?
# echo '111111111111111111111111111111111111111111111111111111111111111'
# cat "$ayr1"
# echo '222222222222222222222222222222222222222222222222222222222222222'
#  cat "$ayr2"
echo '333333333333333333333333333333333333333333333333333333333333333'
cat "$ayr3"
# echo '444444444444444444444444444444444444444444444444444444444444444'
# cat "$ayr4"

 case $ret in
    171)
            arayuz ;;
    172)
            xdg-open "${EZANVAKTI_AYAR}"; arayuz ;;
    174)
            IFS="|"
            liste1=(); liste2=(); liste3=(); liste4=()

            read -ra liste1 < "$ayr1"
            read -ra liste2 < "$ayr2"
            read -ra liste3 < "$ayr3"
            read -ra liste4 < "$ayr4"
 
            unset IFS

            if [[ ${liste1[0]} != ${EZANVERI_ADI} ]]
            then
                    sed -i "s:\(EZANVERI_ADI=\).*:\1\'${liste1[0]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste1[1]} != ${ULKE} ]]
            then
                    sed -i "s:\(ULKE=\).*:\1\'${liste1[1]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste[2]} != ${SEHIR} ]]
            then
                    sed -i "s:\(SEHIR=\).*:\1\'${liste1[2]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste1[3]} != ${ILCE} ]]
            then
                    sed -i "s:\(ILCE=\).*:\1\'${liste1[3]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste1[4]} != TRUE ]]
            then
                    _GUNCELLEME_YAP=0
            else
                    _GUNCELLEME_YAP=1
            fi

            if (( GUNCELLEME_YAP != _GUNCELLEME_YAP ))
            then
                    sed -i "s:\(GUNCELLEME_YAP=\).*:\1$_GUNCELLEME_YAP:" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste2[0]} != TRUE ]]
            then
                    _OYNATICI_DURAKLAT=0
            else
                    _OYNATICI_DURAKLAT=1
            fi

            if (( OYNATICI_DURAKLAT != _OYNATICI_DURAKLAT ))
            then
                    sed -i "s:\(OYNATICI_DURAKLAT=\).*:\1$_OYNATICI_DURAKLAT:" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste2[1]} != TRUE ]]
            then
                    _EZAN_DUASI_OKU=0
            else
                    _EZAN_DUASI_OKU=1
            fi

            if (( EZAN_DUASI_OKU != _EZAN_DUASI_OKU ))
            then
                    sed -i "s:\(EZAN_DUASI_OKU=\).*:\1$_EZAN_DUASI_OKU:" "${EZANVAKTI_AYAR}"
            fi

            if (( EZAN_OKUNMA_SURESI_FARKI != ${liste2[2]} ))
            then
                    sed -i "s:\(EZAN_OKUNMA_SURESI_FARKI=\).*:\1${liste2[2]}:" "${EZANVAKTI_AYAR}"
            fi

            if (( VAKIT_ANIMSAT != ${liste2[3]} ))
            then
                    sed -i "s:\(VAKIT_ANIMSAT=\).*:\1${liste2[3]}:" "${EZANVAKTI_AYAR}"
            fi
    
            if [[ ${SABAH_EZANI} != ${liste2[4]} ]]
            then
                    sed -i "s:\(SABAH_EZANI=\).*:\1\'${liste2[4]}\':" "${EZANVAKTI_AYAR}"
            fi

             if [[ ${OGLE_EZANI} != ${liste2[5]} ]]
            then
                    sed -i "s:\(OGLE_EZANI=\).*:\1\'${liste2[5]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${IKINDI_EZANI} != ${liste2[6]} ]]
            then
                    sed -i "s:\(IKINDI_EZANI=\).*:\1\'${liste2[6]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${AKSAM_EZANI} != ${liste2[7]} ]]
            then
                    sed -i "s:\(AKSAM_EZANI=\).*:\1\'${liste2[7]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${YATSI_EZANI} != ${liste2[8]} ]]
            then
                    sed -i "s:\(YATSI_EZANI=\).*:\1\'${liste2[8]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${EZAN_DUASI} != ${liste2[9]} ]]
            then
                    sed -i "s:\(EZAN_DUASI=\).*:\1\'${liste2[9]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${EZAN_OKUYAN} != ${liste2[10]} ]]
            then
                    sed -i "s:\(EZAN_OKUYAN=\).*:\1\'${liste2[10]}\':" "${EZANVAKTI_AYAR}"
            fi


            . "${EZANVAKTI_AYAR}" ;denetle;  arayuz ;;


# _EZAN_BILDIRIM=$(sed -n 's:[,|.].*::p' <<<${list[6]})
# _SURE_FARKI=$(sed -n 's:[,|.].*::p' <<<${list[7]})
# _SES_SEVIYE=$(sed -n 's:[,|.].*::p' <<<${list[8]})
# _VAKIT_ANIMSAT=$(sed -n 's:[,|.].*::p' <<<${list[9]})
# 
# if [[ $EZAN_BILDIRIM_SURESI -ne $_EZAN_BILDIRIM ]]
# then
#     sed -i "s:\(EZAN_BILDIRIM_SURESI=\).*:\1$_EZAN_BILDIRIM:" "${EZANVAKTI_AYAR}"
# fi
# if [[ $EZAN_OKUNMA_SURESI_FARKI -ne $_SURE_FARKI ]]
# then
#     sed -i "s:\(EZAN_OKUNMA_SURESI_FARKI=\).*:\1$_SURE_FARKI:" "${EZANVAKTI_AYAR}"
# fi
# if [[ $SES -ne $_SES_SEVIYE ]]
# then
#     sed -i "s:\(SES=\).*:\1$_SES_SEVIYE:" "${EZANVAKTI_AYAR}"
# fi
# if [[ $VAKIT_ANIMSAT -ne $_VAKIT_ANIMSAT ]]
# then
#     sed -i "s:\(VAKIT_ANIMSAT=\).*:\1$_VAKIT_ANIMSAT:" "${EZANVAKTI_AYAR}"
# fi
# if [[ "${list[10]}" != "${SABAH_EZANI}" ]]
# then
#     sed -i "s:\(SABAH_EZANI=\).*:\1\'${list[10]}\':" "${EZANVAKTI_AYAR}"
# fi
# if [[ "${list[11]}" != "${OGLE_EZANI}" ]]
# then
#     sed -i "s:\(OGLE_EZANI=\).*:\1\'${list[11]}\':" "${EZANVAKTI_AYAR}"
# fi
# if [[ "${list[12]}" != "${IKINDI_EZANI}" ]]
# then
#     sed -i "s:\(IKINDI_EZANI=\).*:\1\'${list[12]}\':" "${EZANVAKTI_AYAR}"
# fi
# if [[ "${list[13]}" != "${AKSAM_EZANI}" ]]
# then
#     sed -i "s:\(AKSAM_EZANI=\).*:\1\'${list[13]}\':" "${EZANVAKTI_AYAR}"
# fi
# if [[ "${list[14]}" != "${YATSI_EZANI}" ]]
# then
#     sed -i "s:\(YATSI_EZANI=\).*:\1\'${list[14]}\':" "${EZANVAKTI_AYAR}"
# fi
# if [[ "${list[15]}" != "${EZAN_DUASI}" ]]
# then
#     sed -i "s:\(EZAN_DUASI=\).*:\1\'${list[15]}\':" "${EZANVAKTI_AYAR}"
# fi
# 
# # source

 121)
 exit 0 ;;
 esac
 }
# 
# # vim: set ft=sh ts=2 sw=2 et:
