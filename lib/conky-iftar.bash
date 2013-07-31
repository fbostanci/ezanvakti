#
#
#
#
#

function ezv_conky_iftar() {
  denetle; bugun

  [[ $SAAT -lt $aksam ]] && {
    bekleme_suresi $aksam_n; kalan
    echo -e "İftar : $aksam_n\nKalan : $kalan_sure" |\
      sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
  } || {
    [[ $SAAT -ge $aksam ]] && {
      export $(gawk '{printf "aksam_n=%s:%s", $10,$11}' \
        <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
      bekleme_suresi_yarin $aksam_n; kalan

      echo -e "İftar : $aksam_n (Yarın)\nKalan : $kalan_sure" |\
        sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
    }
  }
}

# vim: set ft=sh ts=2 sw=2 et:
