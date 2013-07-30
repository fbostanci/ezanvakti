#
#
#                           Ezanvakti Yapılandırma Yöneticisi Bileşeni 1.2
#

function yapilandirma() {
  local d1 d2 d3 ayr _GUNCELLEME_YAP _OYNATICI_DURAKLAT _EZAN_DUASI_OKU _EZAN_BILDIRIM _SURE_FARKI _SES_SEVIYE _VAKIT_ANIMSAT

if (( GUNCELLEME_YAP ))
then
    d1=TRUE
else
    d1=FALSE
fi
if (( OYNATICI_DURAKLAT ))
then
    d2=TRUE
else
    d2=FALSE
fi
if (( EZAN_DUASI_OKU ))
then
    d3=TRUE
else
    d3=FALSE
fi


ayr=`yad --form --title "Ezanvakti ${SURUM} - Yapılandırma Yöneticisi" \
--field='Ezanveri Adı:' \
--field='Ülke:' \
--field='Şehir:' \
--field='Otomatik Ezanveri Güncelleme:CHK' \
--field='Oynatıcı Duraklat:CHK' \
--field='Ezan Duası Oku:CHK' \
--field='Ezan Bildirim Süresi:NUM' \
--field='Ezan Okunma Süresi Farkı:NUM' \
--field='Mplayer ses seviyesi:NUM' \
--field='Vakit animsat:NUM' \
--field='Sabah Ezanı:FL' \
--field='Öğle Ezanı:FL' \
--field='İkindi Ezanı:FL' \
--field='Akşam Ezanı:FL' \
--field='Yatsı Ezanı:FL' \
--field='Ezan Duası:FL' \
--window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--button='gtk-go-back:171' --button='gtk-open:172' --button='gtk-save:174' --button='gtk-quit:121' \
--fixed --sticky --center \
"${EZANVERI_ADI}" "${ULKE}" "${KONUM}"  "$d1" "$d2" "$d3" "$EZAN_BILDIRIM_SURESI[!10..300[!1]]" \
-- "$EZAN_OKUNMA_SURESI_FARKI[!-600..600][!10]]" "$SES[!0..100[!1]]" "$VAKIT_ANIMSAT[!0..60[!1]]" \
"${SABAH_EZANI}" "${OGLE_EZANI}" "${IKINDI_EZANI}" "${AKSAM_EZANI}" "${YATSI_EZANI}" \
"${EZAN_DUASI}"`


case $? in
171)
arayuz ;;
172)
xdg-open "${EZANVAKTI_AYAR}"
arayuz ;;
174)
IFS="|"
list=()

for i in ${ayr}
do
  list+=("$i")
done

unset IFS

if [[ "${list[0]}" != "${EZANVERI_ADI}" ]]
then
    sed -i "s:\(EZANVERI_ADI=\).*:\1\'${list[0]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[1]}" != "${ULKE}" ]]
then
    sed -i "s:\(ULKE=\).*:\1\'${list[1]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[2]}" != "${SEHIR}" ]]
then
    sed -i "s:\(SEHIR=\).*:\1\'${list[2]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[3]}" != "TRUE" ]]
then
    _GUNCELLEME_YAP=0
else
    _GUNCELLEME_YAP=1
fi


if [[ $GUNCELLEME_YAP -ne $_GUNCELLEME_YAP ]]
then
    sed -i "s:\(GUNCELLEME_YAP=\).*:\1$_GUNCELLEME_YAP:" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[4]}" != "TRUE" ]]
then
    _OYNATICI_DURAKLAT=0
else
    _OYNATICI_DURAKLAT=1
fi
if [[ $OYNATICI_DURAKLAT -ne $_OYNATICI_DURAKLAT ]]
then
    sed -i "s:\(OYNATICI_DURAKLAT=\).*:\1$_OYNATICI_DURAKLAT:" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[5]}" != "TRUE" ]]
then
    _EZAN_DUASI_OKU=0
else
    _EZAN_DUASI_OKU=1
fi
if [[ $EZAN_DUASI_OKU -ne $_EZAN_DUASI_OKU ]]
then
    sed -i "s:\(EZAN_DUASI_OKU=\).*:\1$_EZAN_DUASI_OKU:" "${EZANVAKTI_AYAR}"
fi

_EZAN_BILDIRIM=$(sed -n 's:[,|.].*::p' <<<${list[6]})
_SURE_FARKI=$(sed -n 's:[,|.].*::p' <<<${list[7]})
_SES_SEVIYE=$(sed -n 's:[,|.].*::p' <<<${list[8]})
_VAKIT_ANIMSAT=$(sed -n 's:[,|.].*::p' <<<${list[9]})

if [[ $EZAN_BILDIRIM_SURESI -ne $_EZAN_BILDIRIM ]]
then
    sed -i "s:\(EZAN_BILDIRIM_SURESI=\).*:\1$_EZAN_BILDIRIM:" "${EZANVAKTI_AYAR}"
fi
if [[ $EZAN_OKUNMA_SURESI_FARKI -ne $_SURE_FARKI ]]
then
    sed -i "s:\(EZAN_OKUNMA_SURESI_FARKI=\).*:\1$_SURE_FARKI:" "${EZANVAKTI_AYAR}"
fi
if [[ $SES -ne $_SES_SEVIYE ]]
then
    sed -i "s:\(SES=\).*:\1$_SES_SEVIYE:" "${EZANVAKTI_AYAR}"
fi
if [[ $VAKIT_ANIMSAT -ne $_VAKIT_ANIMSAT ]]
then
    sed -i "s:\(VAKIT_ANIMSAT=\).*:\1$_VAKIT_ANIMSAT:" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[10]}" != "${SABAH_EZANI}" ]]
then
    sed -i "s:\(SABAH_EZANI=\).*:\1\'${list[10]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[11]}" != "${OGLE_EZANI}" ]]
then
    sed -i "s:\(OGLE_EZANI=\).*:\1\'${list[11]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[12]}" != "${IKINDI_EZANI}" ]]
then
    sed -i "s:\(IKINDI_EZANI=\).*:\1\'${list[12]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[13]}" != "${AKSAM_EZANI}" ]]
then
    sed -i "s:\(AKSAM_EZANI=\).*:\1\'${list[13]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[14]}" != "${YATSI_EZANI}" ]]
then
    sed -i "s:\(YATSI_EZANI=\).*:\1\'${list[14]}\':" "${EZANVAKTI_AYAR}"
fi
if [[ "${list[15]}" != "${EZAN_DUASI}" ]]
then
    sed -i "s:\(EZAN_DUASI=\).*:\1\'${list[15]}\':" "${EZANVAKTI_AYAR}"
fi

# source
. "${EZANVAKTI_AYAR}" && arayuz
;;
121)
exit 0
;;
esac
}

# vim: set ft=sh ts=2 sw=2 et:
