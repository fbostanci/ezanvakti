#
#
#                           Ezanvakti Basit Arayüz  Bileşeni 1.1
#

if ! [ -x "$(which yad 2>/dev/null)" ]
then
    printf "Bu özellik YAD gerektirmektedir...\n" >&2
    exit 1
fi

# düz komut çıktıları için rengi sıfırla.
export RENK=0

# TODO: denetle öncelikle.
ezanvakti_xc="$(type -p ezanvakti)"

function arayuz2() {
  denetle; bugun

if [ $SAAT -lt $sabah ]
then
    ileti='Sabah ezanına kalan süre :'
    v_kalan=$("${ezanvakti_xc}" -v -s)
elif [ $SAAT -lt $ogle ]
then
    ileti='Öğle ezanına kalan süre :'
    v_kalan=$("${ezanvakti_xc}" -v -o)
elif [ $SAAT -lt $ikindi ]
then
    ileti='İkindi ezanına kalan süre :'
    v_kalan=$("${ezanvakti_xc}" -v -i)
elif [ $SAAT -lt $aksam ]
then
    ileti='Akşam ezanına kalan süre :'
    v_kalan=$("${ezanvakti_xc}" -v -a)
elif [ $SAAT -lt $yatsi ]
then
    ileti='Yatsı ezanına kalan süre :'
    v_kalan=$("${ezanvakti_xc}" -v -y)
elif [ $SAAT -le 2359 ]
then
    ileti='Yeni gün için bekleniyor..'
    v_kalan=
fi

yad --title "Ezanvakti $SURUM" \
--text "$("${ezanvakti_xc}" --arayuzlericin | sed 's:\t::g')\n\n${ileti}\n$(cut -d' ' -f5- <<<${v_kalan})" \
--button="gtk-refresh:172" --button="gtk-close:173" \
--image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--mouse --fixed --sticky

case $? in
  172)
    arayuz2
    ;;
  173)
    exit 0
    ;;
esac
}; arayuz2

# vim: set ft=sh ts=2 sw=2 et:
