#
#
#
#
#

function ucbirim_penceresi() {
  denetle; bugun

  function bekleme_goster() {
    local vakit_saati="$1"

    bekleme_suresi ${vakit_saati}
    while (( bekle ))
    do
      # Her 12 saniyede bir süreyi sapmaya karşı düzelt.
      ((bekle%12 == 0)) && bekleme_suresi ${vakit_saati}
      printf "${RENK7}${RENK2}Kalan süre:${RENK5} %02d saat : %02d dakika : %02d saniye${RENK0}\r" \
        $((bekle/3600)) $((bekle%3600/60)) $((bekle%60))
      ((bekle--))
      sleep 1
    done
  }

  function ozel_gun_var_mi() {
    (( GUN_ANIMSAT )) && {
      if grep -q $(date +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler
      then
        printf "${RENK7}${RENK2}Bugün: "\
          "${RENK5}$(grep $(date +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler|cut -d' ' -f2-)"
      elif grep -q $(date -d 'tomorrow' +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler
      then
        printf "${RENK7}${RENK2}Yarın: "\
          "${RENK5}$(grep $(date -d 'tomorrow' +%d.%m.%Y) ${VERI_DIZINI}/veriler/gunler|cut -d' ' -f2-)"
      fi
    }
}


}
