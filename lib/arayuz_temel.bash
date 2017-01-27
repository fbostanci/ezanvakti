#
#
#
#
#

sure_listesi='!1-Fatiha!2-Bakara!3-Al-i İmran!4-Nisa!5-Maide!6-Enam!7-Araf!8-Enfal!9-Tevbe!10-Yunus
!11-Hud!12-Yusuf!13-Rad!14-İbrahim!15-Hicr!16-Nahl!17-İsra!18-Kehf!19-Meryem!20-Taha!21-Enbiya!22-Hac
!23-Müminun!24-Nur!25-Furkan!26-Şuara!27-Neml!28-Kasas!29-Ankebut!30-Rum!31-Lokman!32-Secde!33-Ahzab
!34-Sebe!35-Fatır!36-Yasin!37-Saffat!38-Sad!39-Zümer!40-Mümin!41-Fussilet!42-Şura!43-Zuhruf!44-Duhan
!45-Casiye!46-Akaf!47-Muhammed!48-Fetih!49-Hucurat!50-Kaf!51-Zariyat!52-Tur!53-Necm!54-Kamer!55-Rahman
!56-Vakia!57-Hadid!58-Mücadele!59-Haşr!60-Mümtehine!61-Saf!62-Cuma!63-Münafikun!64-Tegabun!65-Talak
!66-Tahrim!67-Mülk!68-Kalem!69-Hakka!70-Mearic!71-Nuh!72-Cin!73-Müzzemmil!74-Müddessir!75-Kıyame
!76-İnsan!77-Mürselat!78-Nebe!79-Naziat!80-Abese!81-Tekvir!82-İnfitar!83-Mutaffifın!84-İnşikak
!85-Büruc!86-Tarık!87-Ala!88-Gaşiye!89-Fecr!90-Beled!91-Şems!92-Leyl!93-Duha!94-İnşirah!95-Tin
!96-Alak!97-Kadir!98-Beyyine!99-Zilzal!100-Adiyat!101-Karia!102-Tekasür!103-Asr!104-Hümeze
!105-Fil!106-Kureyş!107-Maun!108-Kevser!109-Kafirun!110-Nasr!111-Tebbet!112-İhlas!113-Felak!114-Nas'

function g_vakitleri_al() {
  denetle; bugun

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah_n; kalan
       v_ileti='Sabah ezanına kalan süre :'
       v_kalan="$kalan_sure"
       vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'

  elif (( UNIXSAAT < ogle ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Sabah ezanına kalan süre :'
      v_kalan="$kalan_sure"
      if (( UNIXSAAT == gunes ))
      then
          vakit_bilgisi='<b>Güneş Doğuş Vakti</b>'
      elif (( UNIXSAAT > gunes ))
      then
          vakit_bilgisi='<b>Şimdi Kuşluk Vakti</b>'
      else
          vakit_bilgisi='<b>Şimdi Sabah Vakti</b>'
      fi

  elif (( UNIXSAAT < ikindi ))
  then
      bekleme_suresi $ikindi_n; kalan
      v_ileti='Sabah ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Öğle Vakti</b>'

  elif (( UNIXSAAT < aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi İkindi Vakti</b>'

  elif (( UNIXSAAT < yatsi ))
  then
      bekleme_suresi $yatsi_n; kalan
      v_ileti='Yatsı ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Akşam Vakti</b>'

  elif (( UNIXSAAT >= yenigun ))
  then
      v_ileti='Yeni gün için bekleniyor..'
      v_kalan=
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'
  fi
}

function g_vakitleri_yaz() {
  printf "${VAKIT_BICIMI}" 'Sabah' "$sabah_n" 'Güneş' \
         "$gunes_n" 'Öğle' "$ogle_n" 'İkindi' "$ikindi_n" 'Akşam' \
         "$aksam_n" 'Yatsı' "$yatsi_n"
}

function g_secim_goster() {
  yad --title "Ezanvakti $SURUM" --text-info --filename=/tmp/ezanvakti-6 --width=360 --height=300 --wrap \
      --button='gtk-close' --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png --back="$ARKAPLAN_RENGI"\
      --fore="$YAZI_RENGI" --mouse --sticky
}

function g_hakkinda() {
  yad --text "\t\t<b><big>Ezanvakti ${SURUM}</big></b>
\"GNU/Linux için ezan vakti bildirici\"

   <a href= 'https://gitlab.com/ironic/ezanvakti' >https://gitlab.com/ironic/ezanvakti</a>

Copyright (c) 2010-2017 Fatih Bostancı
GPL 3 ile lisanslanmıştır.\n" \
  --title "Ezanvakti ${SURUM} - Hakkında" --fixed --image-on-top \
  --button='gtk-close' --sticky --center \
  --image=${VERI_DIZINI}/simgeler/ezanvakti2.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png
}

export -f g_hakkinda

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

# vim: set ft=sh ts=2 sw=2 et:
