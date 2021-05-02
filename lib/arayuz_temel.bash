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
