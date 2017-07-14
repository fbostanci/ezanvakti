#!/bin/bash
#
#
#
#

bilesen_yukle arayuz_temel

function eylem_pid_denetle() {
  local ypid=$$

  if [[ -f /tmp/.ezanvakti_eylem_menu.pid && -n $(ps -p $( < /tmp/.ezanvakti_eylem_menu.pid) -o comm=) ]]
  then
      printf "%s: Yalnızca bir arayüz örneği çalışabilir.\n" "${AD}" >&2
      exit 1
  else
      printf "$ypid" > /tmp/.ezanvakti_eylem_menu.pid
  fi
}

function eylem_menu() {
  eylem_pid_denetle

  case $1 in
    vakitler)
      secim_basligi='Günlük Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler tum_vakitler > /tmp/ezanvakti-6
      g_secim_goster ;;

    v7)
      secim_basligi='Haftalık Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler haftalik > /tmp/ezanvakti-6
      g_secim_goster ;;

    v30)
      secim_basligi='Aylık Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler aylik > /tmp/ezanvakti-6
      g_secim_goster ;;

    kerahat)
      secim_basligi='Kerahat Vakitleri'
      bilesen_yukle kerahat
      kerahat_vakitleri ucbirim > /tmp/ezanvakti-6
      g_secim_goster ;;

    kuran)
      bilesen_yukle mplayer_yonetici
      function arayuz() { true; }
      ozel_pencere ;;

    gunler)
      secim_basligi="$(date +%Y) Dini Günler ve Geceler"
      bilesen_yukle dini_gunler
      gunler > /tmp/ezanvakti-6
      g_secim_goster ;;

    ayet)
      secim_basligi='Günlük Ayet'
      bilesen_yukle ayet_goster
      ayet_goster ucbirim > /tmp/ezanvakti-6
      g_secim_goster ;;

    hadis)
      secim_basligi='40 Hadis'
      bilesen_yukle bilgi_goster
      hadis_goster ucbirim > /tmp/ezanvakti-6
      g_secim_goster ;;

    bilgi)
      secim_basligi='Dini Bilgiler'
      bilesen_yukle bilgi_goster
      bilgi_goster ucbirim > /tmp/ezanvakti-6
      g_secim_goster ;;

    esma)
      secim_basligi='Esma-ül Hüsna'
      bilesen_yukle bilgi_goster
      esma_goster ucbirim > /tmp/ezanvakti-6
      g_secim_goster ;;

    yapilandirma)
      bilesen_yukle yapilandirma_yoneticisi
      function arayuz() { true; }
      yapilandirma ;;

    yardim)
      secim_basligi='Kullanım'
      bilesen_yukle kullanim
      betik_kullanimi > /tmp/ezanvakti-6
      sed -i '$d' /tmp/ezanvakti-6
      g_secim_goster ;;

    hakkinda)
      bilesen_yukle hakkinda
      g_hakkinda ;;

  esac
}

