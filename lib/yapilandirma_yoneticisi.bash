#
#
#                           Ezanvakti Yapılandırma Yöneticisi Bileşeni 2.0
#
#

function yapilandirma() {
  local d1 d2 d3 d4 d5 d6 d7 d8 d9
  local ayr1 ayr2 ayr3 ayr4
  local _GUNCELLEME_YAP _OYNATICI_DURAKLAT _EZAN_DUASI_OKU _RENK_KULLAN _GUNCELLEME_GEREKLI
  local _SABAH_OKUNSUN_MU _OGLE_OKUNSUN_MU  _IKINDI_OKUNSUN_MU _AKSAM_OKUNSUN_MU _YATSI_OKUNSUN_MU


(( GUNCELLEME_YAP    )) && d1=TRUE || d1=FALSE
(( OYNATICI_DURAKLAT )) && d2=TRUE || d2=FALSE
(( EZAN_DUASI_OKU    )) && d3=TRUE || d3=FALSE
(( SABAH_EZANI_OKU   )) && d4=TRUE || d4=FALSE
(( OGLE_EZANI_OKU    )) && d5=TRUE || d5=FALSE
(( IKINDI_EZANI_OKU  )) && d6=TRUE || d6=FALSE
(( AKSAM_EZANI_OKU   )) && d7=TRUE || d7=FALSE
(( YATSI_EZANI_OKU   )) && d8=TRUE || d8=FALSE
(( $(gawk -F'=' '/^RENK_KULLAN/{print($2);}' "${EZANVAKTI_AYAR}") )) && d9=TRUE || d9=FALSE


_GUNCELLEME_GEREKLI=0
ayr1=/tmp/ezanvakti_ayr1
ayr2=/tmp/ezanvakti_ayr2
ayr3=/tmp/ezanvakti_ayr3
ayr4=/tmp/ezanvakti_ayr4
#ayr4=$(mktemp --tmpdir tab4.XXXXXXXX)

ipcrm -M 190707  > /dev/null 2>&1

yad --plug=190707 --tabnum=1 --form \
--item-separator='\n' \
--field='Ezanveri Adı:' \
--field='Ülke:' \
--field='Şehir:' \
--field='İlçe' \
--field='Otomatik Ezanveri Güncelleme:CHK' \
"${EZANVERI_ADI}" "${ULKE}" "${SEHIR}" \
"${ILCE}" "$d1" > $ayr1 &
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
"$d2" "$d3" -- "$EZAN_OKUNMA_SURESI_FARKI[!-600..600][!60]]" \
 "$VAKIT_ANIMSAT[!0..60[!1]]" "${SABAH_EZANI}" \
 "${OGLE_EZANI}" "${IKINDI_EZANI}" "${AKSAM_EZANI}" \
 "${YATSI_EZANI}" "${EZAN_DUASI}" "${EZAN_OKUYAN}" > $ayr2 &
yad --plug=190707 --tabnum=3 --form \
--field='Sabah ezanı okunsun mu:CHK' \
--field='Öğle ezanı okunsun mu:CHK' \
--field='İkindi ezanı okunsun mu:CHK' \
--field='Akşam ezanı okunsun mu:CHK' \
--field='Yatsı ezanı okunsun mu:CHK' \
--field='Mplayer ses seviyesi:SCL' \
--field='Dini gün anımsat (sn. 0 ise kapalı):NUM' \
--field='Ezan Bildirim Süresi (sn):NUM' \
--field='Ayet Bildirim Süresi (sn):NUM' \
--field='Hadis Bildirim Süresi (sn):NUM' \
--field='Bilgi Bildirim Süresi (sn):NUM' \
--field='Güncelleme Bildirim Süresi (sn):NUM' \
"$d4" "$d5" "$d6" "$d7" "$d8" \
"$SES[!0..100[!1]]" "$GUN_ANIMSAT[!0..30[!1]]" \
"$EZAN_BILDIRIM_SURESI[!15..300[!15]]" \
"$AYET_BILDIRIM_SURESI[!10..30[!1]]" \
"$HADIS_BILDIRIM_SURESI[!10..30[!1]]" \
"$BILGI_BILDIRIM_SURESI[!10..30[!1]]" \
"$GUNCELLEME_BILDIRIM_SURESI[!10..30[!1]]" > $ayr3 &
yad --plug=190707 --tabnum=4 --form \
--field='Uçbirimde renk kullan:CHK' \
--field='Kullanılacak Tefsir:CB' \
--field='Kuran okuyan:CB' \
--field='\nGelişmiş arayüzde açılan metin kutusu renk seçimleri\n:LBL' \
--field='Metin kutusu arka plan rengi:CLR' \
--field='Metin kutusu yazı rengi:CLR' \
"$d9" "^${TEFSIR_SAHIBI}!diyanet!ozturk!ates!yazir" \
"^${OKUYAN}!AlGhamdi!AsShatree!AlAjmy" " " \
"${ARKAPLAN_RENGI}" "${YAZI_RENGI}" > $ayr4 &
yad --notebook --key=190707 \
--title "${AD^} ${SURUM} - Yapılandırma Yöneticisi" \
--tab="Ezanveri Ayarları" --tab="Ezan Ayarları" \
--tab="Bildirim Ayarları" --tab="Çeşitli Ayarlar" \
--fixed --center --tab-pos=top --buttons-layout='spread' \
--window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--button='gtk-go-back:171' --button='gtk-open:172' \
--button='gtk-save:174' --button='gtk-quit:121'

 case $? in
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
######################################################################
#                         LİSTE 1 İŞLEMLERİ                          #
######################################################################
            if [[ ${liste1[0]} != ${EZANVERI_ADI} ]]
            then
                if [[ -n ${liste1[0]} ]]
                then
                    sed -i "s:\(EZANVERI_ADI=\).*:\1\'${liste1[0]}\':" "${EZANVAKTI_AYAR}"
                    _GUNCELLEME_GEREKLI=1
                fi
            fi

            if [[ ${liste1[1]} != ${ULKE} ]]
            then
                if [[ -n ${liste1[1]} ]]
                then
                    sed -i "s:\(ULKE=\).*:\1\'${liste1[1]}\':" "${EZANVAKTI_AYAR}"
                    _GUNCELLEME_GEREKLI=1
                fi
            fi

            if [[ ${liste1[2]} != ${SEHIR} ]]
            then
                if [[ -n ${liste1[2]} ]]
                then
                    sed -i "s:\(SEHIR=\).*:\1\'${liste1[2]}\':" "${EZANVAKTI_AYAR}"
                    _GUNCELLEME_GEREKLI=1
                fi
            fi

            if [[ ${liste1[3]} != ${ILCE} ]]
            then
                if [[ -n ${liste1[3]} ]]
                then
                    sed -i "s:\(ILCE=\).*:\1\'${liste1[3]}\':" "${EZANVAKTI_AYAR}"
                    _GUNCELLEME_GEREKLI=1
                fi
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
######################################################################
#                         LİSTE 2 İŞLEMLERİ                          #
######################################################################
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
                if [[ -n ${liste2[10]} ]]
                then
                    sed -i "s:\(EZAN_OKUYAN=\).*:\1\'${liste2[10]}\':" "${EZANVAKTI_AYAR}"
                fi
            fi
######################################################################
#                         LİSTE 3 İŞLEMLERİ                          #
######################################################################
            if [[ ${liste3[0]} != TRUE ]]
            then
                _SABAH_OKUNSUN_MU=0
            else
                _SABAH_OKUNSUN_MU=1
            fi

            if [[ ${liste3[1]} != TRUE ]]
            then
                _OGLE_OKUNSUN_MU=0
            else
                _OGLE_OKUNSUN_MU=1
            fi

            if [[ ${liste3[2]} != TRUE ]]
            then
                _IKINDI_OKUNSUN_MU=0
            else
                _IKINDI_OKUNSUN_MU=1
            fi

            if [[ ${liste3[3]} != TRUE ]]
            then
                _AKSAM_OKUNSUN_MU=0
            else
                _AKSAM_OKUNSUN_MU=1
            fi

            if [[ ${liste3[4]} != TRUE ]]
            then
                _YATSI_OKUNSUN_MU=0
            else
                _YATSI_OKUNSUN_MU=1
            fi

            if (( SABAH_EZANI_OKU != _SABAH_OKUNSUN_MU ))
            then
                sed -i "s:\(SABAH_EZANI_OKU=\).*:\1$_SABAH_OKUNSUN_MU:" "${EZANVAKTI_AYAR}"
            fi

            if (( OGLE_EZANI_OKU != _OGLE_OKUNSUN_MU ))
            then
                sed -i "s:\(OGLE_EZANI_OKU=\).*:\1$_OGLE_OKUNSUN_MU:" "${EZANVAKTI_AYAR}"
            fi

            if (( IKINDI_EZANI_OKU != _IKINDI_OKUNSUN_MU ))
            then
                sed -i "s:\(IKINDI_EZANI_OKU=\).*:\1$_IKINDI_OKUNSUN_MU:" "${EZANVAKTI_AYAR}"
            fi

            if (( AKSAM_EZANI_OKU != _AKSAM_OKUNSUN_MU ))
            then
                sed -i "s:\(AKSAM_EZANI_OKU=\).*:\1$_AKSAM_OKUNSUN_MU:" "${EZANVAKTI_AYAR}"
            fi

            if (( YATSI_EZANI_OKU != _YATSI_OKUNSUN_MU ))
            then
                sed -i "s:\(YATSI_EZANI_OKU=\).*:\1$_YATSI_OKUNSUN_MU:" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${SES} != ${liste3[5]} ]]
            then
                sed -i "s:\(SES=\).*:\1\'${liste3[5]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${GUN_ANIMSAT} != ${liste3[6]} ]]
            then
                sed -i "s:\(GUN_ANIMSAT=\).*:\1\'${liste3[6]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${EZAN_BILDIRIM_SURESI} != ${liste3[7]} ]]
            then
                sed -i "s:\(EZAN_BILDIRIM_SURESI=\).*:\1\'${liste3[7]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${AYET_BILDIRIM_SURESI} != ${liste3[8]} ]]
            then
                sed -i "s:\(AYET_BILDIRIM_SURESI=\).*:\1\'${liste3[8]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${HADIS_BILDIRIM_SURESI} != ${liste3[9]} ]]
            then
                sed -i "s:\(HADIS_BILDIRIM_SURESI=\).*:\1\'${liste3[9]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${BILGI_BILDIRIM_SURESI} != ${liste3[10]} ]]
            then
                sed -i "s:\(BILGI_BILDIRIM_SURESI=\).*:\1\'${liste3[10]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${GUNCELLEME_BILDIRIM_SURESI} != ${liste3[11]} ]]
            then
                sed -i "s:\(GUNCELLEME_BILDIRIM_SURESI=\).*:\1\'${liste3[11]}\':" "${EZANVAKTI_AYAR}"
            fi
######################################################################
#                         LİSTE 4 İŞLEMLERİ                          #
######################################################################
            if [[ ${liste4[0]} != TRUE ]]
            then
                _RENK_KULLAN=0
            else
                _RENK_KULLAN=1
            fi

            if (( $(gawk -F'=' '/^RENK_KULLAN/{print($2);}' "${EZANVAKTI_AYAR}") != _RENK_KULLAN ))
            then
                sed -i "s:\(^RENK_KULLAN=\).*:\1$_RENK_KULLAN:" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste4[1]} != ${TEFSIR_SAHIBI} ]]
            then
                if [[ -n ${liste4[1]} ]]
                then
                    sed -i "s:\(TEFSIR_SAHIBI=\).*:\1\'${liste4[1]}\':" "${EZANVAKTI_AYAR}"
                fi
            fi

            if [[ ${liste4[2]} != ${OKUYAN} ]]
            then
                if [[ -n ${liste4[2]} ]]
                then
                    sed -i "s:\(^OKUYAN=\).*:\1\'${liste4[2]}\':" "${EZANVAKTI_AYAR}"
                fi
            fi

#             if [[ ${liste4[3]} != ${RENK3} ]]
#             then
#                 sed -i "s:\(RENK3=\).*:\1\'${liste4[3]}\':" "${EZANVAKTI_AYAR}"
#             fi
# 
#             if [[ ${liste4[4]} != ${RENK4} ]]
#             then
#                 sed -i "s:\(RENK4=\).*:\1\'${liste4[4]}\':" "${EZANVAKTI_AYAR}"
#             fi
# 
#             if [[ ${liste4[5]} != ${RENK5} ]]
#             then
#                 sed -i "s:\(RENK5=\).*:\1\'${liste4[5]}\':" "${EZANVAKTI_AYAR}"
#             fi
# 
#             if [[ ${liste4[6]} != ${RENK6} ]]
#             then
#                 sed -i "s:\(RENK6=\).*:\1\'${liste4[6]}\':" "${EZANVAKTI_AYAR}"
#             fi
# 
#             if [[ ${liste4[7]} != ${RENK7} ]]
#             then
#                 sed -i "s:\(RENK7=\).*:\1\'${liste4[7]}\':" "${EZANVAKTI_AYAR}"
#             fi
# 
#             if [[ ${liste4[8]} != ${RENK8} ]]
#             then
#                 sed -i "s:\(RENK8=\).*:\1\'${liste4[8]}\':" "${EZANVAKTI_AYAR}"
#             fi

            if [[ ${liste4[4]} != ${ARKAPLAN_RENGI} ]]
            then
                sed -i "s:\(ARKAPLAN_RENGI=\).*:\1\'${liste4[4]}\':" "${EZANVAKTI_AYAR}"
            fi

            if [[ ${liste4[5]} != ${YAZI_RENGI} ]]
            then
                sed -i "s:\(YAZI_RENGI=\).*:\1\'${liste4[5]}\':" "${EZANVAKTI_AYAR}"
            fi

#           # source
            . "${EZANVAKTI_AYAR}"
            (( _GUNCELLEME_GEREKLI )) && {
                bilesen_yukle guncelleyici
                (
                  guncelleme_yap
                ) | yad  --progress --title="${AD^} $SURUM" --progress-text="${EZANVERI_ADI} güncelleniyor" \
                         --pulsate --auto-close --width=300 --center --fixed --no-buttons\
                         --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png
                . "${EZANVAKTI_AYAR}"
            }
            arayuz ;;

# _SES_SEVIYE=$(sed -n 's:[,|.].*::p' <<<${list[8]})

    121)
            exit 0 ;;
 esac
}

# vim: set ft=sh ts=2 sw=2 et:
