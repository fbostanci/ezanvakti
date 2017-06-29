#
#
#
#
#
function kerahat_vakitleri() {

  local kerahat_suresi='45 minutes' #dk
  local kv_gunes=$(date -d "$gunes_n $kerahat_suresi" +%H:%M)
  local kv_ogle=$(date -d "-$kerahat_suresi $ogle_n" +%H:%M)
  local kv_aksam=$(date -d "-$kerahat_suresi $aksam_n" +%H:%M)

  printf '%b%b\n%b\n\n%b\n%b\n\n%b\n%b\n\n'\
    "${RENK7}${RENK3}\n${ILCE}${RENK5} için kerahat vaktileri (${TARIH} $(date +%H:%M:%S))\n\n"\
    "${RENK2}Kerahat Vakti 1${RENK3} : $gunes_n - $kv_gunes${RENK2} arası"\
    "${RENK8}Hiçbir namaz kılınamaz."\
    "${RENK2}Kerahat Vakti 2${RENK3} : $kv_ogle - $ogle_n${RENK2} arası"\
    "${RENK8}Hiçbir namaz kılınmaz."\
    "${RENK2}Kerahat vakti 3${RENK3} : $kv_aksam - $aksam_n${RENK2} arası"\
    "${RENK8}O günün ikindi namazı farzı hariç olmak üzere başka bir namaz kılınmaz.${RENK0}"
}
