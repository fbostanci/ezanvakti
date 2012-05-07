#
#
#                           Ezanvakti Gelişmiş Arayüz  Bileşeni 1.7
#

if ! [ -x "$(which yad 2>/dev/null)" ]
then
    printf "Bu özellik YAD gerektirmektedir...\n" >&2
    exit 1
fi

elx=''
for ((i=1; i<=CIZGI_UZUNLUGU; i++))
{
  elx+="${CIZGI_SIMGESI}"
}

export RENK=0

(( GUN_ANIMSAT )) && {
  if grep -q $(date +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler
  then
      ozel_ileti="\n\nBugün:  <b>$(grep $(date +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler | cut -d' ' -f2-)</b>"
  elif grep -q $(date -d 'tomorrow' +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler
  then
      ozel_ileti="\n\nYarın:  <b>$(grep $(date -d 'tomorrow' +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler | cut -d' ' -f2-)</b>"

  else
      ozel_ileti=''
  fi
}
. ${BILESEN_DIZINI}/yapilandirma_yoneticisi.bash

sure_listesi="!001-Fatiha!002-Bakara!003-Al-i İmran!004-Nisa!005-Maide!006-En'am!007-A'raf!\
008-Enfal!009-Tevbe!010-Yunus!011-Hud!012-Yusuf!013-Ra'd!014-İbrahim!015-Hicr!016-Nahl!017-İsra!018-Kehf!\
019-Meryem!020-Taha!021-Enbiya!022-Hac!023-Mü'minun!024-Nur!025-Furkan!026-Şu'ara!027-Neml!028-Kasas!\
029-Ankebut!030-Rum!031-Lokman!032-Secde!033-Ahzab!034-Sebe!035-Fatır!036-Yasin!037-Saffat!038-Sad!\
039-Zümer!040-Mü'min!041-Fussilet!042-Şura!043-Zuhruf!044-Duhan!045-Casiye!046-Ahkaf!047-Muhammed!\
048-Fetih!049-Hucurat!050-Kaf!051-Zariyat!052-Tur!053-Necm!054-Kamer!055-Rahman!056-Vakı'a!057-Hadid!\
058-Mücadele!059-Haşr!060-Mümtehine!061-Saff!062-Cuma!063-Münafikun!064-Teğabun!065-Talak!066-Tahrim!\
067-Mülk!068-Kalem!069-Hakka!070-Me'aric!071-Nuh!072-Cin!073-Müzzemmil!074-Müddessir!075-Kıyame!\
076-İnsan!077-Mürselat!078-Nebe!079-Nazi'at!080-Abese!081-Tekvir!082-İnfitar!083-Mutaffifin!084-İnşikak!\
085-Büruc!086-Tarık!087-A'la!088-Gaşiye!089-Fecr!090-Beled!091-Şems!092-Leyl!093-Duha!094-İnşirah!095-Tin!\
096-Alak!097-Kadr!098-Beyyine!099-Zilzal!100-Adiyat!101-Karia!102-Tekasür!103-Asr!104-Hümeze!105-Fil!\
106-Kureyş!107-Ma'un!108-Kevser!109-Kafirun!110-Nasr!111-Tebbet!112-İhlas!113-Felak!114-Nas"

function pencere_bilgi() {

yad --form --separator=' ' --title="Ezanvakti $SURUM" --text "${mplayer_ileti}" \
  --image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
  --button='gtk-cancel:127' --button='gtk-close:0' --sticky --mouse --fixed

  case $? in
    127)
      echo stop > /tmp/mplayer-$$.pipe 2>/dev/null;sleep .4
      echo stop > /tmp/mplayer-$$.pipe2 2>/dev/null
      rm -f /tmp/mplayer-$$.pipe{,2} &>/dev/null
      ;;
  esac
}

function secim_goster() {
  yad --title "Ezanvakti $SURUM" --text-info --filename=/tmp/ezanvakti-6 --width=360 --height=300 --wrap \
    --button='gtk-close' --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png --back="$ARKAPLAN_RENGI"\
    --fore="$YAZI_RENGI" --mouse --sticky
}

function hakkinda() {
  yad --text "\t\t<b><big>Ezanvakti ${SURUM}</big></b>
\"GNU/Linux için ezan vakti bildirici\"

   <a href= 'https://gitorious.org/ezanvakti' >https://gitorious.org/ezanvakti</a>

Copyright (c) 2010-2012 Fatih Bostancı
GPL 3 ile lisanslanmıştır.\n" \
  --title "Ezanvakti ${SURUM} - Hakkında" --fixed --image-on-top \
  --button='gtk-close' --sticky --center \
  --image=${VERI_DIZINI}/simgeler/ezanvakti2.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png
}

function ozel_pencere() {
  local strng donus str str2

strng=$(yad --form \
--field=Okuyucu:CB \
'!Saad el Ghamdi!As Shatry!Ahmad el Ajmy!Yerel Okuyucu' \
--field=Sure:CB \
"${sure_listesi}" \
--button='gtk-go-back:151' --button='gtk-media-play:152' --button='gtk-quit:153' \
--image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--title "Ezanvakti $SURUM" --sticky --center --fixed)

donus=$(echo $?)

declare -x $(echo "$strng" | sed 's:|: :g' | gawk '{print "str="$1 "\nstr2="$2}')

case $donus in
  151)
    arayuz ;;
  152)
    [[ -z $str2 ]] && ozel_pencere
    sure=$(cut -d'-' -f1 <<<"$str2")

     if [ "${str}" = "Saad el Ghamdi" ]
     then
        okuyucu=AlGhamdi
     elif [ "${str}" = "As Shatry" ]
     then
        okuyucu=AsShatree
     elif [ "${str}" = "Ahmad el Ajmy" ]
     then
        okuyucu=AlAjmy
     else
        okuyucu='Yerel Okuyucu'
     fi

    if [ "${okuyucu}" = "Yerel Okuyucu" ]
    then
        if [[ -f "${YEREL_SURE_DIZINI}/$sure.mp3" ]]
        then
            dinletilecek_sure="${YEREL_SURE_DIZINI}/$sure.mp3"
        else
            ozel_pencere
        fi
    else
        dinletilecek_sure="http://www.listen2quran.com/listen/${okuyucu}/$sure.mp3"
    fi
    rm -f /tmp/mplayer-$$.pipe 2>/dev/null
    mkfifo /tmp/mplayer-$$.pipe
    mplayer_ileti="$(grep -w $sure ${VERI_DIZINI}/veriler/sureler | gawk '{print $2}') suresi dinletiliyor..\
    \n\n Okuyan : ${str}"
    pencere_bilgi &
    $MPLAYER -slave -input file=/tmp/mplayer-$$.pipe "${dinletilecek_sure}" 2> /dev/null; clear
    pkill yad &>/dev/null
    ozel_pencere;;
  153)
    exit 0 ;;
esac
}

function arayuz() {
  denetle; bugun
  local strng donus str str2

  if [ $SAAT -lt $sabah ]
  then
      ileti='Sabah ezanına kalan süre :'
      v_kalan=$("${ezanvakti_xc}" -v -s)
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'

  elif [ $SAAT -lt $ogle ]
  then
      ileti='Öğle ezanına kalan süre :'
      v_kalan=$("${ezanvakti_xc}" -v -o)
      if [ $SAAT -eq $gunes ]
      then
          vakit_bilgisi='<b>Güneş Doğuş Vakti</b>'
      elif [ $SAAT -gt $gunes ]
      then
          vakit_bilgisi='<b>Şimdi Kuşluk Vakti</b>'
      else
          vakit_bilgisi='<b>Şimdi Sabah Vakti</b>'
      fi
  elif [ $SAAT -lt $ikindi ]
  then
      ileti='İkindi ezanına kalan süre :'
      v_kalan=$("${ezanvakti_xc}" -v -i)
      vakit_bilgisi='<b>Şimdi Öğle Vakti</b>'
  elif [ $SAAT -lt $aksam ]
  then
      ileti='Akşam ezanına kalan süre :'
      v_kalan=$("${ezanvakti_xc}" -v -a)
      vakit_bilgisi='<b>Şimdi İkindi Vakti</b>'
  elif [ $SAAT -lt $yatsi ]
  then
      ileti='Yatsı ezanına kalan süre :'
      v_kalan=$("${ezanvakti_xc}" -v -y)
      vakit_bilgisi='<b>Şimdi Akşam Vakti</b>'
  elif [ $SAAT -le 2359 ]
  then
      ileti='Yeni gün için bekleniyor..'
      v_kalan=
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'
  fi

strng=$(yad --form --text "$(printf "${GELISMIS_ARAYUZ_BICIMI}" "${TARIH}" "$(date +%H:%M:%S)" \
  "${ILCE} / ${ULKE}" "${elx}" "${vakit_bilgisi}${ozel_ileti}" "${elx}" \
  "$("${ezanvakti_xc}" --arayuzlericin)" "${ileti}" \
  "$(cut -d' ' -f5- <<<${v_kalan})")" \
--field='Ezanlar:CB' \
'!Sabah!Öğle!İkindi!Akşam!Yatsı' \
--field='Sureler:CB' \
"!000-Özel Pencere$sure_listesi" \
--field='Seçimler:CB' \
'!Ayet!Hadis!Bilgi!Esma-ül Hüsna' \
--button="gtk-about:160" --button="gtk-properties:170" --button='gtk-ok:150' --button="gtk-quit:121" \
--image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
--title "Ezanvakti $SURUM" --sticky --center --fixed)

donus=$(echo $?)

declare -x $(echo "$strng" | sed 's:|: :g' | gawk '{print "str="$1 "\nstr2="$2}')

[[ -n $str2 ]] && arayuz

if (( $donus == 150 ))
then
    if [ "$str" = "Sabah" ]
    then
        mplayer_ileti=" Sabah ezanı dinletiliyor..\n\n Okuyan : ${EZAN_OKUYAN}"
        pencere_bilgi &
        "${ezanvakti_xc}" --dinle -s
        pkill yad &>/dev/null
        arayuz
    elif [ "$str" = "Öğle" ]
    then
        mplayer_ileti=" Öğle ezanı dinletiliyor..\n\n Okuyan : ${EZAN_OKUYAN}"
        pencere_bilgi &
        "${ezanvakti_xc}" --dinle -o
        pkill yad &>/dev/null
        arayuz
    elif [ "$str" = "İkindi" ]
    then
        mplayer_ileti=" İkindi ezanı dinletiliyor..\n\n Okuyan : ${EZAN_OKUYAN}"
        pencere_bilgi &
        "${ezanvakti_xc}" --dinle -i
        pkill yad &>/dev/null
        arayuz
    elif [ "$str" = "Akşam" ]
    then
        mplayer_ileti=" Akşam ezanı dinletiliyor..\n\n Okuyan : ${EZAN_OKUYAN}"
        pencere_bilgi &
        "${ezanvakti_xc}" --dinle -a
        pkill yad &>/dev/null
        arayuz
    elif [ "$str" = "Yatsı" ]
    then
        mplayer_ileti=" Yatsı ezanı dinletiliyor..\n\n Okuyan : ${EZAN_OKUYAN}"
        pencere_bilgi &
        "${ezanvakti_xc}" --dinle -y
        pkill yad &>/dev/null
        arayuz
    elif [ "$str" = "Ayet" ]
    then
        "${ezanvakti_xc}" --ayet -u | sed 's/\x1b\[[0-9]\{1,2\}\(;[0-9]\{1,2\}\)\{0,2\}m//g' > /tmp/ezanvakti-6
        secim_goster;arayuz
    elif [ "$str" = "Hadis" ]
    then
        "${ezanvakti_xc}" --hadis -u | sed 's/\x1b\[[0-9]\{1,2\}\(;[0-9]\{1,2\}\)\{0,2\}m//g' > /tmp/ezanvakti-6
        secim_goster;arayuz
    elif [ "$str" = "Esma-ül Hüsna" ]
    then
        "${ezanvakti_xc}" --esma | sed 's/\x1b\[[0-9]\{1,2\}\(;[0-9]\{1,2\}\)\{0,2\}m//g' > /tmp/ezanvakti-6
        secim_goster;arayuz
    elif [ "$str" = "Bilgi" ]
    then
        "${ezanvakti_xc}" --bilgi -u | sed 's/\x1b\[[0-9]\{1,2\}\(;[0-9]\{1,2\}\)\{0,2\}m//g' > /tmp/ezanvakti-6
        secim_goster;arayuz
    elif [ `echo $str | grep [0-9]` ]
    then
        sure=$(echo "$str" | cut -d'-' -f1)

        if [ $sure = 000 ]
        then
            ozel_pencere
        else
            if [[ -f "${YEREL_SURE_DIZINI}/$sure.mp3" ]]
            then
                okuyan='Yerel Okuyucu'
            elif [ ${OKUYAN} = AlGhamdi ]
            then
                okuyan="Saad el Ghamdi"
            elif [ ${OKUYAN} = AsShatree ]
            then
                okuyan="As Shatry"
            elif [ ${OKUYAN} = AlAjmy ]
            then
                okuyan="Ahmad el Ajmy"
            fi
        fi

        mplayer_ileti=" $(grep -w $sure ${VERI_DIZINI}/veriler/sureler | gawk '{print $2}') suresi dinletiliyor..\n\n Okuyan : ${okuyan}"
        pencere_bilgi &
        "${ezanvakti_xc}"  --kuran -s $sure
        pkill yad &>/dev/null
        arayuz
    else
        arayuz
    fi

elif (( $donus == 160 ))
then
    hakkinda
    arayuz
elif (( $donus == 170 ))
then
    yapilandirma
elif (( $donus == 121 ))
then
    exit 0
fi
};arayuz

# vim: set ft=sh ts=2 sw=2 et:
