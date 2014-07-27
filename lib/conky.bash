#
#
#
#
#

function ezv_conky() {
  denetle; bugun
  printf "${CONKY_BICIMI}" 'Sabah' "$sabah_n" 'Güneş' \
    "$gunes_n" 'Öğle' "$ogle_n" 'İkindi' "$ikindi_n" 'Akşam' \
    "$aksam_n" 'Yatsı' "$yatsi_n"
}

function ezv_conky_iftar() {
  denetle; bugun

  [[ $UNIXSAAT -lt $aksam ]] && {
    bekleme_suresi $aksam_n; kalan
    echo -e "İftar : $aksam_n\nKalan : $kalan_sure" |
      sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
  } || {
    [[ $UNIXSAAT -ge $aksam ]] && {
      # FIXME: Yarının aksam vakti ezanveri dosyasında var mı denetle önc..
      export $(gawk '{printf "aksam_n=%s", $6}' \
        <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
      bekleme_suresi_yarin $aksam_n; kalan

      echo -e "İftar : $aksam_n (Yarın)\nKalan : $kalan_sure" |
        sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
    }
  }
}

# vim: set ft=sh ts=2 sw=2 et:
