#
#
#
#
#

function mplayer_calistir() {
  local dinletilecek_oge="$1"

  if [[ ${dinletilecek_oge} =~ ^http.* ]]
  then
    # internet erişimini denetle.
    if ! ping -q -c 1 -W 1 google.com &>/dev/null
    then
        printf '%s: İnternet erişimi algılanamadı.\n' "${AD}"
        exit 1
    fi
  fi

  rm -f /tmp/mplayer-$$.pipe 2>/dev/null
  mkfifo /tmp/mplayer-$$.pipe

  $MPLAYER -slave -input file=/tmp/mplayer-$$.pipe "${dinletilecek_oge}" 2>/dev/null; clear
  rm -f /tmp/mplayer-$$.pipe 2>/dev/null
}

# vim: set ft=sh ts=2 sw=2 et:
