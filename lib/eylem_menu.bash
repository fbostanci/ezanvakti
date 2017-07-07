#
#
#
#
#

bilesen_yukle arayuz_temel

function eylem_pid_denetle() {
  local ypid=$$

  if [[ -f /tmp/.ezanvakti_eylem_menu.pid && -n $(ps -p $( < /tmp/.ezanvakti_eylem_menu.pid) -o comm=) ]]
  then
      printf "Yalnızca bir arayüz örneği çalışabilir.\n" >&2
      exit 1
  else
      printf "$ypid" > /tmp/.ezanvakti_eylem_menu.pid
  fi
}

function eylem_menu() {
  eylem_pid_denetle

  case $1 in
    vakitler)
      secim_basligi='Vakitler'
      bilesen_yukle vakitleri_goster
      vakitler tum_vakitler > /tmp/ezanvakti-6
      g_secim_goster ;;

    kerahat)
      secim_basligi='Kerahat Vakitleri'
      bilesen_yukle kerahat
      kerahat_vakitleri ucbirim > /tmp/ezanvakti-6
      g_secim_goster ;;

    kuran)
      bilesen_yukle mplayer_yonetici
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
      yapilandirma ;;

    yardim)
      secim_basligi='Kullanım'
      bilesen_yukle kullanim
      betik_kullanimi > /tmp/ezanvakti-6
      sed -i '$d' /tmp/ezanvakti-6
      g_secim_goster ;;

    hakkinda)
      g_hakkinda ;;

  esac
}

