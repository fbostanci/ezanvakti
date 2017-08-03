#!/bin/bash
#
#
#
#

bilesen_yukle arayuz_temel

eylem_pid_denetle() {
  local ypid=$$

  if [[ -f /tmp/.ezanvakti_eylem_menu.pid && \
        -n $(ps -p $( < /tmp/.ezanvakti_eylem_menu.pid) -o comm=) ]]
  then
      printf "%s: Yalnızca bir arayüz örneği çalışabilir.\n" "${AD}" >&2
      exit 1
  else
      printf "$ypid" > /tmp/.ezanvakti_eylem_menu.pid
  fi
}

eylem_menu() {
  eylem_pid_denetle

  case $1 in
    vakitler)
      secim_basligi='Günlük Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler tum_vakitler > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    v7)
      secim_basligi='Haftalık Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler haftalik > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    v30)
      secim_basligi='Aylık Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler aylik > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    kerahat)
      secim_basligi='Kerahat Vakitleri'
      bilesen_yukle kerahat
      kerahat_vakitleri ucbirim > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    kuran)
      bilesen_yukle mplayer_yonetici
      arayuz() { true; }
      ozel_pencere ;;

    gunler)
      secim_basligi="$(date +%Y) Dini Günler ve Geceler"
      bilesen_yukle dini_gunler
      gunler > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    ayet)
      secim_basligi='Günlük Ayet'
      bilesen_yukle ayet_goster
      ayet_goster ucbirim > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    hadis)
      secim_basligi='40 Hadis'
      bilesen_yukle bilgi_goster
      hadis_goster ucbirim > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    bilgi)
      secim_basligi='Dini Bilgiler'
      bilesen_yukle bilgi_goster
      bilgi_goster ucbirim > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    esma)
      secim_basligi='Esma-ül Hüsna'
      bilesen_yukle bilgi_goster
      esma_goster ucbirim > "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    yapilandirma)
      bilesen_yukle yapilandirma_yoneticisi
      arayuz() { true; }
      yapilandirma ;;

    yardim)
      secim_basligi='Kullanım'
      bilesen_yukle kullanim
      betik_kullanimi > "${cikti_dosyasi}"
      sed -i '$d' "${cikti_dosyasi}"
      g_secim_goster; temizlik ;;

    hakkinda)
      bilesen_yukle hakkinda
      g_hakkinda ;;

  esac
}
