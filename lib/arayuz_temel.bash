#!/bin/bash
#
#
#
#

if ! [[ -x $(type -p yad) ]]
then
    printf '%s: Bu özellik YAD gerektirmektedir.\n' "${AD}" >&2
    exit 1
fi

# --arayuz css dosyası
if [[ -f ${EZANVAKTI_DIZINI}/ezanvakti-gui.css ]]
then
    EZV_CSS="${EZANVAKTI_DIZINI}/ezanvakti-gui.css"
else
    EZV_CSS="${VERI_DIZINI}/veriler/ezanvakti-gui.css"
fi
# --arayuz2 css dosyası
if [[ -f ${EZANVAKTI_DIZINI}/ezanvakti-gui2.css ]]
then
    EZV_CSS2="${EZANVAKTI_DIZINI}/ezanvakti-gui2.css"
else
    EZV_CSS2="${VERI_DIZINI}/veriler/ezanvakti-gui2.css"
fi
# --arayuz3 css dosyası
if [[ -f ${EZANVAKTI_DIZINI}/ezanvakti-gui3.css ]]
then
    EZV_CSS3="${EZANVAKTI_DIZINI}/ezanvakti-gui3.css"
else
    EZV_CSS3="${VERI_DIZINI}/veriler/ezanvakti-gui3.css"
fi

if (( ARAYUZ_SIMGE_GOSTER ))
then
    simge_goster="--image=${AD}"
else
    simge_goster=''
fi

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

tamamlama_listesi='!Ayarlar!Ayet!Sabah!Öğle!İkindi!Akşam!Yatsı!Sela!yapilandirma!Hadis!Esma-ül Hüsna'
tamamlama_listesi+='!Bilgi!Aylık Vakitler!Haftalık Vakitler!Dini Günler ve Geceler!hakkında!Bayram Namazı Vakitleri'
tamamlama_listesi+="!about!güncelle!güncelle yeni!yardım!Kerahat!000!özel pencere!$sure_listesi"

secim_listesi='!Yapılandırma Yöneticisi!Kerahat Vakitleri!Dini Günler ve Geceler!Günlük Vakitler!Haftalık Vakitler'
secim_listesi+='!Aylık Vakitler!Ayet!Hadis!Bilgi!Esma-ül Hüsna!Bayram Namazı Vakitleri'

cikti_dosyasi="/tmp/${AD}-6"
# düz komut çıktıları için rengi sıfırla.
export RENK_KULLAN=0 RENK=0
acilisa_baslatici_ekle

# arayüz ve bileşenlerinin
# çoklu çalışmasını önlemek için
# denetleme fonksiyonu
arayuz_pid_denetle() {
  # p=1: arayuz1
  # p=2: arayuz2
  # p=3: arayuz3
  # p=4: eylem_menu
  local p="$1" ypid=$$

  case $p in
    1) p='arayuz1' ;;
    2) p='arayuz2' ;;
    3) p='arayuz3' ;;
    4) p='eylem_menu' ;;
    *) printf '%s: desteklenmeyen istek: %s\n' "${AD}" "${p}" >&2; return 1 ;;
  esac

  if [[ -f /tmp/.${AD}_yad_${p}.pid && \
        -n $(ps -p $( < /tmp/.${AD}_yad_${p}.pid) -o comm=) ]]
  then
      printf '%s: Yalnızca bir %s örneği çalışabilir.\n' "${AD}" "${p}" >&2
      exit 1
  else
      printf "$ypid" > /tmp/.${AD}_yad_${p}.pid
  fi
}

temizlik() {
  rm -f "${cikti_dosyasi}" > /dev/null 2>&1
}

g_vakitleri_al() {
  ezanveri_denetle; bugun

  local kerahat_suresi kv_gunes kv_ogle kv_aksam

  kerahat_suresi=$(( KERAHAT_SURESI * 60 ))
  kv_gunes=$(( gunes + kerahat_suresi ))
  kv_ogle=$(( ogle - kerahat_suresi ))
  kv_aksam=$(( aksam - kerahat_suresi ))

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah_n; kalan
      v_ileti='Sabah ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'

  elif (( UNIXSAAT >= sabah && UNIXSAAT < gunes ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 1</b>'

  elif (( UNIXSAAT == gunes ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Güneş Doğuş Vakti</b>'

  elif (( UNIXSAAT > gunes && UNIXSAAT < kv_gunes ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 2</b>'

  elif (( UNIXSAAT >= kv_gunes && UNIXSAAT < kv_ogle ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kuşluk Vakti</b>'

  elif (( UNIXSAAT < ogle && UNIXSAAT >= kv_ogle ))
  then
      bekleme_suresi $ogle_n; kalan
      v_ileti='Öğle ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 3</b>'

  elif (( UNIXSAAT >= ogle && UNIXSAAT < ikindi ))
  then
      bekleme_suresi $ikindi_n; kalan
      v_ileti='İkindi ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Öğle Vakti</b>'

  elif (( UNIXSAAT >= ikindi && UNIXSAAT < kv_aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 4</b>'

  elif (( UNIXSAAT < aksam && UNIXSAAT >= kv_aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      v_ileti='Akşam ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Kerahat Vakti 5</b>'

  elif (( UNIXSAAT >= aksam && UNIXSAAT < yatsi ))
  then
      bekleme_suresi $yatsi_n; kalan
      v_ileti='Yatsı ezanına kalan süre :'
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Akşam Vakti</b>'

  elif (( UNIXSAAT < yeni_gun ))
  then
      bekleme_suresi_yarin $ysabah_n; kalan
      v_ileti="Sabah ($ysabah_n) ezanına kalan süre:"
      v_kalan="$kalan_sure"
      vakit_bilgisi='<b>Şimdi Yatsı Vakti</b>'
  fi
}

g_vakitleri_yaz() {
  local sabah gunes ogle ikindi aksam yatsi vakitsiz ikindi_kerahat

  vakitsiz="<b>Şimdi Kerahat Vakti 2</b>|<b>Şimdi Kerahat Vakti 3</b>"
  vakitsiz+="|<b>Şimdi Kuşluk Vakti</b>"
  ikindi_kerahat="<b>Şimdi Kerahat Vakti 4</b>|<b>Şimdi Kerahat Vakti 5</b>"

  if [[ ${vakit_bilgisi} = '<b>Şimdi Yatsı Vakti</b>'  ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Kerahat Vakti 1</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Güneş Doğuş Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Öğle Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = @(${ikindi_kerahat}) ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = '<b>Şimdi Akşam Vakti</b>' ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_SECILI_VAKIT_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"

  elif [[ ${vakit_bilgisi} = @(${vakitsiz}) ]]
  then
      sabah="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Sabah</span>"
      sabah_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$sabah_n</span>"
      gunes="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Güneş</span>"
      gunes_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$gunes_n</span>"
      ogle="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Öğle</span>"
      ogle_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ogle_n</span>"
      ikindi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>İkindi</span>"
      ikindi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$ikindi_n</span>"
      aksam="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Akşam</span>"
      aksam_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$aksam_n</span>"
      yatsi="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>Yatsı</span>"
      yatsi_n="<span foreground=\'${ARAYUZ_VAKITLER_RENGI}\'>$yatsi_n</span>"
  fi

  printf "${VAKIT_BICIMI}" "${sabah}" "$sabah_n" "${gunes}" \
         "$gunes_n" "${ogle}" "$ogle_n" "${ikindi}" "$ikindi_n" \
         "${aksam}" "$aksam_n" "${yatsi}" "$yatsi_n"
}

g_secim_goster() {
  yad --title "${AD^} - ${secim_basligi}" --text-info --filename="${cikti_dosyasi}" \
      --width=560 --height=300 --wrap --button='yad-close' --window-icon=${AD} \
      --back="$ARKAPLAN_RENGI" --fore="$YAZI_RENGI" --mouse --sticky
}

pencere_bilgi() {
  # verilen ses dosyasının süresini alır. (oynatici_yonetici.bash)
  # $parca_suresi = saniye cinsinden süre
  # $parca_suresi_n = sürenin sa,dk,ve sn'ye çevrilmiş hali
  oynatici_sure_al "$1"

  yad --form --separator=' ' --title="${AD^}" --image=${AD} --window-icon=${AD} \
      --text "${oynatici_ileti}\n Süre        : $parca_suresi_n" --mouse --fixed \
      --button='yad-cancel:127' --button='yad-close:0' --timeout=$parca_suresi \
      --gtkrc="${EZV_CSS}"

  case $? in
    *)
      echo stop > /tmp/ezv-oynatici-$$.pipe 2>/dev/null
      rm -f /tmp/ezv-oynatici-$$.pipe 2>/dev/null
      pkill ffplay
      ;;
  esac
}

ozel_pencere() {
  local strng donus str str2 sure dinletilecek_sure okuyucu oynatici_ileti

strng=$(yad --form \
--field=Okuyucu:CB \
'!Saad el Ghamdi!As Shatry!Ahmad el Ajmy!Yerel Okuyucu' \
--field=Sure:CB \
"${sure_listesi}" \
--button='Geri:151' --button='Oynat:152' \
--button='yad-quit:153' \
--image=${AD} --window-icon=${AD} --gtkrc="${EZV_CSS}" \
--title "${AD^}" --sticky --center --fixed)

donus=$(echo $?)

declare -x $(sed 's:|: :g' <<< "$strng" | gawk '{print "str="$1 "\nstr2="$2}')

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
        if [[ -f "${YEREL_SURE_DIZINI}/${KURAN_OKUYAN}/$sure.mp3" ]]
        then
            dinletilecek_sure="${YEREL_SURE_DIZINI}/${KURAN_OKUYAN}/$sure.mp3"
        else
            ozel_pencere
        fi
    else
        dinletilecek_sure="http://www.listen2quran.com/listen/${okuyucu}/$sure.mp3"
    fi

    oynatici_ileti="$(gawk -v sira=$sure '{if(NR==sira) print $4;}' \
      < ${VERI_DIZINI}/veriler/sure_bilgisi) suresi dinletiliyor\n\n Okuyan : ${str}"

    pencere_bilgi "${dinletilecek_sure}" &
    oynatici_calistir "${dinletilecek_sure}"
    ozel_pencere ;;

  153)
    exit 0 ;;
esac
}

# vim: set ft=sh ts=2 sw=2 et:
