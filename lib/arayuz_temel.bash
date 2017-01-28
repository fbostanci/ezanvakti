#
#
#
#
#

sure_listesi='!1-Fatiha!2-Bakara!3-Al-i İmran!4-Nisa!5-Maide!6-Enam!7-Araf!8-Enfal!9-Tevbe!10-Yunus'
sure_listesi+='!11-Hud!12-Yusuf!13-Rad!14-İbrahim!15-Hicr!16-Nahl!17-İsra!18-Kehf!19-Meryem!20-Taha'
sure_listesi+='!21-Enbiya!22-Hac!23-Müminun!24-Nur!25-Furkan!26-Şuara!27-Neml!28-Kasas!29-Ankebut'
sure_listesi+='!30-Rum!31-Lokman!32-Secde!33-Ahzab!34-Sebe!35-Fatır!36-Yasin!37-Saffat!38-Sad'
sure_listesi+='!39-Zümer!40-Mümin!41-Fussilet!42-Şura!43-Zuhruf!44-Duhan!45-Casiye!46-Akaf'
sure_listesi+='!47-Muhammed!48-Fetih!49-Hucurat!50-Kaf!51-Zariyat!52-Tur!53-Necm!54-Kamer'
sure_listesi+='!55-Rahman!56-Vakia!57-Hadid!58-Mücadele!59-Haşr!60-Mümtehine!61-Saf!62-Cuma'
sure_listesi+='!63-Münafikun!64-Tegabun!65-Talak!66-Tahrim!67-Mülk!68-Kalem!69-Hakka!70-Mearic'
sure_listesi+='!71-Nuh!72-Cin!73-Müzzemmil!74-Müddessir!75-Kıyame!76-İnsan!77-Mürselat!78-Nebe'
sure_listesi+='!79-Naziat!80-Abese!81-Tekvir!82-İnfitar!83-Mutaffifın!84-İnşikak!85-Büruc'
sure_listesi+='!86-Tarık!87-Ala!88-Gaşiye!89-Fecr!90-Beled!91-Şems!92-Leyl!93-Duha!94-İnşirah'
sure_listesi+='!95-Tin!96-Alak!97-Kadir!98-Beyyine!99-Zilzal!100-Adiyat!101-Karia!102-Tekasür'
sure_listesi+='!103-Asr!104-Hümeze!105-Fil!106-Kureyş!107-Maun!108-Kevser!109-Kafirun!110-Nasr'
sure_listesi+='!111-Tebbet!112-İhlas!113-Felak!114-Nas'

tamamlama_listesi='!Ayarlar!Ayet!Sabah!Öğle!İkindi!Akşam!Yatsı!yapilandirma!Hadis!Esma-ül Hüsna'
tamamlama_listesi+='!Bilgi!Aylık Vakitler!Haftalık Vakitler!Dini Günler ve Geceler!hakkında' 
tamamlama_listesi+="!güncelle!yardım!arayuz2!000!özel pencere!$sure_listesi"

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
      v_ileti='Öğle ezanına kalan süre :'
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
      v_ileti='İkindi ezanına kalan süre :'
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
  yad --title "Ezanvakti $SURUM - ${secim_basligi}" --text-info --filename=/tmp/ezanvakti-6 --width=560 --height=300 --wrap \
      --button='gtk-close' --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png --back="$ARKAPLAN_RENGI"\
      --fore="$YAZI_RENGI" --mouse --sticky
}

function g_hakkinda() {
  yad --text "\t\t<b><big>Ezanvakti ${SURUM}</big></b>
\"GNU/Linux için ezan vakti bildirici\"

   <a href= 'https://gitlab.com/ironic/ezanvakti' >Ezanvakti Sayfası</a>

Copyright (c) 2010-2017 Fatih Bostancı
GPL 3 ile lisanslanmıştır.\n" \
  --title "Ezanvakti ${SURUM} - Hakkında" --fixed --image-on-top \
  --button='gtk-close' --sticky --center \
  --image=${VERI_DIZINI}/simgeler/ezanvakti2.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png
}

function pencere_bilgi() {

yad --form --separator=' ' --title="Ezanvakti $SURUM" --text "${mplayer_ileti}" \
  --image=${VERI_DIZINI}/simgeler/ezanvakti.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png \
  --button='gtk-cancel:127' --button='gtk-close:0' --sticky --mouse --fixed

  case $? in
    *)
      echo stop > /tmp/mplayer-$$.pipe 2>/dev/null
      echo stop > /tmp/mplayer-$$.pipe2 2>/dev/null
      rm -f /tmp/mplayer-$$.pipe{,2} &>/dev/null
      ;;
  esac
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

    if [[ ${str} = Saad el Ghamdi ]]
    then
        okuyucu=AlGhamdi
    elif [[ ${str} = As Shatry ]]
    then
        okuyucu=AsShatree
    elif [[ ${str} = Ahmad el Ajmy ]]
    then
        okuyucu=AlAjmy
    else
        okuyucu='Yerel Okuyucu'
    fi

    if (( ${#sure} == 1 ))
    then
        sure=00$sure
    elif (( ${#sure} == 2 ))
    then
        sure=0$sure
    fi

    if [[ ${okuyucu} = Yerel Okuyucu ]]
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

    mplayer_ileti="$(gawk -v sira=$sure '{if(NR==sira) print $4;}' < ${VERI_DIZINI}/veriler/sure_bilgisi) suresi dinletiliyor..\
    \n\n Okuyan : ${str}"
    mplayer_calistir "${dinletilecek_sure}" &
    pencere_bilgi; ozel_pencere ;;
  153)
    exit 0 ;;
esac
}

# vim: set ft=sh ts=2 sw=2 et:
