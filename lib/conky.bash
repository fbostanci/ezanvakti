#!/bin/bash
#
#        Ezanvakti Conky bileşeni
#
#

ezv_conky() {
  ezanveri_denetle; bugun

  printf "${CONKY_BICIMI}" 'Sabah' "$sabah_n" 'Güneş' \
    "$gunes_n" 'Öğle' "$ogle_n" 'İkindi' "$ikindi_n" \
    'Akşam' "$aksam_n" 'Yatsı' "$yatsi_n"
}

ezv_conky_imsak() {
  ezanveri_denetle; bugun

  if (( UNIXSAAT < sabah ))
  then
      bekleme_suresi $sabah_n; kalan
      echo -e "İmsak : $sabah_n\nKalan : $kalan_sure" | \
      sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
  else
      # Yarının sabah vakti ezanveri dosyasında var mı denetle önc..
      if ! grep -qo "^$(date -d 'tomorrow' +%d.%m.%Y)" "${EZANVERI}"
      then
          if (( GUNCELLEME_YAP ))
          then
              bilesen_yukle guncelleyici
              guncelleme_yap
          else
              printf '%s: %s dosyanızda yarına ait veri bulunmuyor.\n' \
                "${AD}" "${EZANVERI_ADI}" >&2
              exit 1
          fi
     fi
     export $(gawk '{printf "sabah_n=%s", $2}' \
       <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
     bekleme_suresi_yarin $sabah_n; kalan

     echo -e "İmsak : $sabah_n (Yarın)\nKalan : $kalan_sure" | \
       sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
  fi
}

ezv_conky_iftar() {
  ezanveri_denetle; bugun

  if (( UNIXSAAT < aksam ))
  then
      bekleme_suresi $aksam_n; kalan
      echo -e "İftar : $aksam_n\nKalan : $kalan_sure" | \
      sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
  else
      # Yarının aksam vakti ezanveri dosyasında var mı denetle önc..
      if ! grep -qo "^$(date -d 'tomorrow' +%d.%m.%Y)" "${EZANVERI}"
      then
          if (( GUNCELLEME_YAP ))
          then
              bilesen_yukle guncelleyici
              guncelleme_yap
          else
              printf '%s: %s dosyanızda yarına ait veri bulunmuyor.\n' \
                "${AD}" "${EZANVERI_ADI}" >&2
              exit 1
          fi
     fi
     export $(gawk '{printf "aksam_n=%s", $6}' \
       <(grep $(date -d 'tomorrow' +%d.%m.%Y) "${EZANVERI}"))
     bekleme_suresi_yarin $aksam_n; kalan

     echo -e "İftar : $aksam_n (Yarın)\nKalan : $kalan_sure" | \
       sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:'
  fi
}

imsak_bildirim() {
  notify-send "${AD^} - imsak" \
  "$(ezv_conky_imsak)" -i ${AD} \
  -t $BILGI_BILDIRIM_SURESI"000"
}


iftar_bildirim() {
  notify-send "${AD^} - iftar" \
  "$(ezv_conky_iftar)" -i ${AD} \
  -t $BILGI_BILDIRIM_SURESI"000"
}

# vim: set ft=sh ts=2 sw=2 et:
