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

cikti_dosyasi="/tmp/${AD}-7"
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
  local mpid p="$1" ypid=$$

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
      mpid="$( < /tmp/.${AD}_yad_${p}.pid)"
      printf '%s: Yalnızca bir %s örneği çalışabilir. (pid: %d)\n' \
        "${AD}" "${p}" "$mpid"  >&2
      exit 1
  else
      printf "$ypid" > /tmp/.${AD}_yad_${p}.pid
  fi
}

g_secim_goster() {
  yad --title "${AD^} - ${secim_basligi}" --text-info --filename="${cikti_dosyasi}" \
      --width=560 --height=300 --wrap --button='yad-close' --window-icon=${AD} \
      --back="$ARKAPLAN_RENGI" --fore="$YAZI_RENGI" --mouse --sticky --skip-taskbar
}

temizlik() {
  rm -f "${cikti_dosyasi}" > /dev/null 2>&1
}

pencere_bilgi() {
  # verilen ses dosyasının süresini alır. (oynatici_yonetici.bash)
  # $parca_suresi = saniye cinsinden süre
  # $parca_suresi_n = sürenin sa,dk,ve sn'ye çevrilmiş hali
  oynatici_sure_al "$1"

  yad --form --separator=' ' --title="${AD^}" --image=${AD} --window-icon=${AD} \
      --text "${oynatici_ileti}\n Süre        : $parca_suresi_n" --mouse --fixed \
      --button='yad-cancel:127' --button='yad-close:0' --timeout=$parca_suresi \
      --css="${EZV_CSS}"

  case $? in
    *)
      echo stop > /tmp/ezv-oynatici-$$.pipe 2>/dev/null
      rm -f /tmp/ezv-oynatici-$$.pipe 2>/dev/null
      pkill ffplay
      ;;
  esac
}

# vim: set ft=sh ts=2 sw=2 et:
