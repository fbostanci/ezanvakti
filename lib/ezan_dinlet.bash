#
#
#
#
#

function ezan_dinlet() {
  local vakit="$1"
  local vakit_ezani="$2"
  
  bilesen_yukle mplayer_yonetici
  
  printf "${RENK7}${RENK2}${vakit}${RENK3} ezanı dinletiliyor...\n"
  mplayer_calistir "${vakit_ezani}"
}

# vim: set ft=sh ts=2 sw=2 et:
