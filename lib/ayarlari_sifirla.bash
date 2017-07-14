#!/bin/bash
#
#
#
#

# TODO: eski ayarlar dosyasından seçileni yeniden kullanılabilir yap.
function ayarlari_sifirla() {
  echo "hazır değil"; return 1
  local ayar_sayisi silinecek_dosya

  cd "${EZANVAKTI_DIZINI}"
  mv -- "${EZANVAKTI_AYAR##*/}" ."${EZANVAKTI_AYAR##*/}"_$(date +%s)
# TODO: yeni ayarlar dosyasını oluştur.

  ayar_sayisi=$(ls -A ".${EZANVAKTI_AYAR##*/}"_* |wc -l)
  (( ayar_sayisi > 4 )) && {

      silinecek_dosya="$(ls -Atr ."${EZANVAKTI_AYAR##*/}"_* | head -n1)"

      rm -i "${silinecek_dosya}" && {
        printf "%s tarihli ${EZANVAKTI_AYAR##*/} dosyanız silindi.\n" \
          "$(date -d "@$(cut -d'_' -f2- <<<"${silinecek_dosya}")")"
      }
      cd - &>/dev/null
  }
}
