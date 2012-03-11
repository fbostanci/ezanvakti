#
#
#
#                           Ezanvakti Ortak Fonksiyonlar  Bileşeni
#


EZANVERI="${EZANVERI_DIZINI}/${EZANVERI_ADI}"
MPLAYER="mplayer -really-quiet -volume $SES"

# Karar verme önceliği env olarak tanımlıysa RENK değişkenine verildi.
# RENK null ise ayarlar dosyasından okunan RENK_KULLAN değerini kullanacak.
#
# Renk kullan sıfırsa renkleri sıfırla.

# HACK: fonksiyon olarak düzenle.
(( ! ${RENK:-RENK_KULLAN} )) && {
  RENK0=''
  RENK1=''
  RENK2=''
  RENK3=''
  RENK4=''
  RENK5=''
  RENK6=''
  RENK7=''
  RENK8=''
}

# Ezanveri dosyası gerektiren işlemlerde ilk önce bu fonksiyon çağrılacak.
#
# ezanveri dosyasının kullanıldığı işlemler için olumsuz durumları denetle.
function denetle() {
  local ksatir
  # ezanlar ve iftarimsak fonksiyonları özyinelemeli çalıştığı için
  # gün değişiminde tarihi güncellemek için tarih, denetle fonksiyonu içine alındı.
  TARIH=`date +%d.%m.%Y`
  SAAT=`date +%H%M`

  [ ! -f "${EZANVERI}" ] && { # ezanveri dosyası yoksa
    (( GUNCELLEME_YAP )) && { # otomatik güncelleme etkinse
      guncelleme_yap # ilgili fonksiyonu çağır ve ezanveri dosyasını oluştur.
    } || { # otomatik güncelleme kapalıysa..
      printf '%b%b\n%b\n' \
        "${RENK7}${RENK2}${EZANVERI}" \
        "${RENK3} dosyası bulunamadı." \
        "Çıkılıyor...${RENK0}"
      exit 1
    }
  }

  # Bugüne ait tarih ezanveri dosyasında yoksa
  [[ -z $(grep -o ${TARIH} "${EZANVERI}") ]] && {
    (( GUNCELLEME_YAP )) && {
      guncelleme_yap
    } || {
      printf '%b%b\n%b\n' \
        "${RENK7}${RENK2}${EZANVERI_ADI}" \
        "${RENK3} dosyası güncel değil." \
        "Çıkılıyor...${RENK0}"
      exit 1
    }
  }

  # ezanveri dosyasından tarih bloğunu ayıklayıp son tarih satır no dan bugünkünü çıkardık.
  ksatir=$(gawk -v tarih=${TARIH} '/^[0-9][0-9]\.[0-9]*\.[0-9]*/ {if($1 ~ tarih) bsatir = NR}; \
    /^[0-9][0-9]\.[0-9]*\.[0-9]*/ {} END {tsatir = NR}; END {print(tsatir-bsatir)}' "${EZANVERI}")
  let ksatir++

  (( ksatir <= 7 )) && { # sonuç 7 ya da 7'den küçükse
    (( GUNCELLEME_YAP )) && {
      guncelleme_yap
    }

    # Betiğin mevcut oturum boyunca sadece ilk çalışmada bildirim vermesi
    # için çerez dosya denetimi ekledik. Gün değişimi durumu için (mevcut oturum devam ediyorsa)
    # ayrıca dosyaya tarih uzantısı da ekledik.
    [ ! -f /tmp/eznvrgncldntle_$(date +%d%m%y) ] && {
      notify-send "Ezanvakti $SURUM" "${EZANVERI_ADI} dosyanız\n\t$ksatir gün\nsonra güncelliğini yitirecek." \
        -i ${VERI_DIZINI}/simgeler/ezanvakti.png -t $GUNCELLEME_BILDIRIM_SURESI"000"
      :> /tmp/eznvrgncldntle_$(date +%d%m%y)
    }
  }
}

################################################
# HACK: bugun ile bugun_noktali' yi birleştir. #
################################################

# Bugünün ezan vakitlerini ayıkla ve değerleri vakit değişkenlerine ata.
function bugun() {
  export $(gawk 'BEGIN{tarih = strftime("%d.%m.%Y")} {if($1 ~ tarih) \
    {printf "sabah=%s%s\ngunes=%s%s\nogle=%s%s\nikindi=%s%s\naksam=%s%s\
    \nyatsi=%s%s\nsabah_n=0%s:%s\ngunes_n=0%s:%s\nogle_n=%s:%s\nikindi_n=%s:%s\naksam_n=%s:%s\nyatsi_n=%s:%s"\
    , $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13}}' "${EZANVERI}")
}

# Eğer hedef süre bugün içerindeyse bu fonksiyon kullanılacak.
function bekleme_suresi() {
  bekle=$(($(date -d "$1" +%s) - $(date +%s) + EZAN_OKUNMA_SURESI_FARKI))
}

#  Eğer hedef süre yarına aitse bu fonksiyon kullanılacak.
function bekleme_suresi_yarin() {
  bekle=$((86400 - $(date +%s) + $(date -d "$1" +%s) + EZAN_OKUNMA_SURESI_FARKI))
}

# Vakit ezanları ve kullanıcı isteğine bağlı ezan dinletimi için.
function ezandinlet() {
  printf '%b%b\n' \
    "${RENK7}${RENK2}" \
    "Okuyan : ${RENK3}${EZAN_OKUYAN}${RENK0}"

  # Arayüzlerde mplayer çalışırken iptal düğmesine basıldığında
  # sadece bizim yönettiğimiz kopyayı sonlandır. Pid denetimi yerine
  # boru (pipe) üzerinden yönetim sağlandı.
  rm -f /tmp/mplayer.pipe{,2} 2>/dev/null
  mkfifo /tmp/mplayer.pipe
  $MPLAYER -slave -input file=/tmp/mplayer.pipe "${vakit_ezani}" 2> /dev/null

  # Ezan duası isteniyorsa
  (( EZAN_DUASI_OKU )) && {
    mkfifo /tmp/mplayer.pipe2
    $MPLAYER -slave -input file=/tmp/mplayer.pipe2 "${EZAN_DUASI}" 2> /dev/null
  }
  rm -f /tmp/mplayer.pipe{,2} 2>/dev/null
}

# vim: set ft=sh ts=2 sw=2 et:
