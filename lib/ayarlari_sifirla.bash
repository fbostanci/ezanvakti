#
#
#
#
#

function ayarlari_sifirla() {
  local ayar_sayisi silinecek_dosya

  cd "${EZANVAKTI_DIZINI}"
  mv -- "${EZANVAKTI_AYAR##*/}" ."${EZANVAKTI_AYAR##*/}"_$(date +%s)


  ayar_sayisi=$(ls -A ".${EZANVAKTI_AYAR##*/}"_* |wc -l)
  (( ayar_sayisi>5 )) && {
      
      silinecek_dosya="$(ls -Atr ."${EZANVAKTI_AYAR##*/}"_* | head -n1)"
      
      rm -i "${silinecek_dosya}"
      printf "%s tarihli ${EZANVAKTI_AYAR##*/} dosyanız silindi.\n" \
        "$(date -d "@$(cut -d'_' -f2- <<<"${silinecek_dosya}")")"
      cd - &>/dev/null
  }
}
