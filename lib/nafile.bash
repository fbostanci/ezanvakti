#
#
#    Ezanvakti  nafile namaz vakitleri hesaplama bileşeni
#
#

nafile_namaz_vakitleri() {
  ezanveri_denetle; bugun
  renk_denetle

  local kerahat_suresi toplam_gece_suresi gece_ucte_bir gece_ikide_bir \
        gece_ucte_iki israk_vakti kv_ogle dun daksam

  kerahat_suresi="$KERAHAT_SURESI minutes" #dk
  kv_ogle=$(date -d "-$kerahat_suresi $ogle_n" +%H:%M)

  if (( UNIXSAAT < sabah ))
  then
      dun=$(date -d yesterday '+%d.%m.%Y')
      if grep -qo "^$dun" "${EZANVERI}"
      then
          export $(gawk -v tarih=$dun '{if($1 ~ tarih) \
                     {printf "daksam_n=%s", $6}}' "${EZANVERI}")
          daksam=$(date -d "yesterday $daksam_n" +%s)
          toplam_gece_suresi=$(( sabah - daksam ))
      else
          toplam_gece_suresi=$(( ysabah - aksam ))
      fi
  else
      toplam_gece_suresi=$(( ysabah - aksam ))
  fi

  gece_ucte_bir=$(gawk -v sure=$toplam_gece_suresi \
                    "BEGIN { print int( sure / 3)}")
  gece_ucte_iki=$(gawk -v sure=$toplam_gece_suresi \
                    "BEGIN { print int( sure * 2 / 3)}")
  gece_ikide_bir=$(gawk -v sure=$toplam_gece_suresi \
                    "BEGIN { print int( sure / 2)}")
  israk_vakti=$(date -d "$gunes_n $kerahat_suresi" +%H:%M)

  gece_ucte_bir=$(date -d "$aksam_n $gece_ucte_bir seconds" +%H:%M)
  gece_ucte_iki=$(date -d "$aksam_n $gece_ucte_iki seconds" +%H:%M)
  gece_ikide_bir=$(date -d "$aksam_n $gece_ikide_bir seconds" +%H:%M)
  toplam_gece_suresi=$(printf '%02d saat %02d dakika' \
                      $(( toplam_gece_suresi / 3600 )) \
                      $(( toplam_gece_suresi % 3600 / 60 )))

  printf '%b%b%b%b%b%b%b%b%b\n\n' \
    "${RENK7}${RENK3}\n${ILCE}${RENK5} için nafile namaz vakitleri (${TARIH} $(date +%T))\n" \
    "${RENK7}${RENK2}\nİşrak vakti    ${RENK3}: $israk_vakti${RENK0}" \
    "${RENK7}${RENK2}\nKuşluk vakti   ${RENK3}: $israk_vakti - $kv_ogle arası${RENK0}" \
    "${RENK7}${RENK2}\nEvvabin vakti  ${RENK3}: $aksam_n${RENK0}" \
    "${RENK7}${RENK2}\nGece 1/3       ${RENK3}: $gece_ucte_bir${RENK0}" \
    "${RENK7}${RENK2}\nGece yarısı    ${RENK3}: $gece_ikide_bir${RENK0}" \
    "${RENK7}${RENK2}\nGece 2/3       ${RENK3}: $gece_ucte_iki${RENK0}" \
    "${RENK7}${RENK2}\nTeheccüd vakti ${RENK3}: $gece_ucte_iki - $ysabah_n arası${RENK0}" \
    "${RENK7}${RENK2}\nGece süresi    ${RENK3}: $toplam_gece_suresi${RENK0}"
}

# vim: set ft=sh ts=2 sw=2 et:
