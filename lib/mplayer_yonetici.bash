#
#
#
#
#

function mplayer_calistir() {
  local dinletilecek_oge="$1"
  
  rm -f /tmp/mplayer-$$.pipe 2>/dev/null
  mkfifo /tmp/mplayer-$$.pipe
  $MPLAYER -slave -input file=/tmp/mplayer-$$.pipe "${dinletilecek_oge}" 2>/dev/null; clear
  rm -f /tmp/mplayer-$$.pipe 2>/dev/null
}

# vim: set ft=sh ts=2 sw=2 et:
