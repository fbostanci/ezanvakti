#
#
#       Ezanvakti kerahat vakitleri gösterme bileşeni
#
#
function kerahat_vakitleri() {
  denetle; bugun

  local kerahat_suresi='45 minutes' #dk
  local kv_gunes=$(date -d "$gunes_n $kerahat_suresi" +%H:%M)

  local kv_ogle=$(date -d "-$kerahat_suresi $ogle_n" +%H:%M)
  local kv_aksam=$(date -d "-$kerahat_suresi $aksam_n" +%H:%M)

case $1 in
  ucbirim)
    renk_denetle

    printf '%b%b%b%b%b%b%b%b%b%b%b%b'\
      "${RENK7}${RENK3}\n${ILCE}${RENK5} için kerahat vakitleri (${TARIH} $(date +%H:%M:%S))\n\n"\
      "${RENK2}Kerahat Vakti 1${RENK3} : $sabah_n - $gunes_n${RENK2} arası\n"\
      "${RENK8}Sabah namazının sünneti hariç başka nafile namaz kılınmaz.\n\n"\
      "${RENK2}Kerahat Vakti 2${RENK3} : $gunes_n - $kv_gunes${RENK2} arası\n"\
      "${RENK8}Hiçbir namaz kılınmaz.\n\n"\
      "${RENK2}Kerahat Vakti 3${RENK3} : $kv_ogle - $ogle_n${RENK2} arası\n"\
      "${RENK8}Hiçbir namaz kılınmaz.\n\n"\
      "${RENK2}Kerahat Vakti 4${RENK3} : $ikindi_n - $kv_aksam${RENK2} arası\n"\
      "${RENK8}İkindi namazından sonra nafile namazı kılınmaz.\n"\
      "ancak kerahat vakti girinceye kadar kaza namazı kılınır.\n\n"\
      "${RENK2}Kerahat vakti 5${RENK3} : $kv_aksam - $aksam_n${RENK2} arası\n"\
      "${RENK8}O günün ikindi namazı farzı hariç olmak üzere başka bir namaz kılınmaz.${RENK0}\n\n" ;;

  conky)
    printf '%b\n%b\n%b\n%b\n%b\n'\
      "Kerahat vakti 1 : $sabah_n - $gunes_n arası"\
      "Kerahat vakti 2 : $gunes_n - $kv_gunes arası"\
      "Kerahat vakti 3 : $kv_ogle - $ogle_n arası"\
      "Kerahat vakti 4 : $ikindi_n - $kv_aksam arası"\
      "Kerahat vakti 5 : $kv_aksam - $aksam_n arası" ;;
esac
}
