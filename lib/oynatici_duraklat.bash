#!/bin/bash
#
#                           Ezanvakti Oynatıcı Duraklatma Bileşeni 1.7
#
#

qdbus_sorgu() {
  local komut

  komut=$(qdbus org.mpris.MediaPlayer2.$1 /org/mpris/MediaPlayer2 \
            org.freedesktop.DBus.Properties.Get org.mpris.MediaPlayer2.Player PlaybackStatus)

  if [[ ${komut} = Playing ]]
  then return 0
  else return 1
  fi
}

dbus_sorgu() {
  local komut

  komut=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.$1\
        /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' \
        string:'PlaybackStatus' | gawk -F'[\"]' '/string/ {print $2;}')

  if [[ ${komut} = Playing ]]
  then return 0
  else return 1
  fi
}

oynatici_duraklat() {
  local -a OYNATICILAR
  local oynatici

  OYNATICILAR=( spotify deadbeef clementine amarok rhythmbox
                aqualung audacious banshee exaile cmus
                moc qmmp juk )

  for oynatici in ${OYNATICILAR[@]}
  do
    [[ -n $(pgrep ${oynatici}) ]] && {
      case "${oynatici}" in
        spotify)
          if dbus_sorgu spotify
          then
              dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
                /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1
              DURDURULAN+=('spotify')
          fi ;;
        deadbeef)
          if dbus_sorgu deadbeef
          then
              deadbeef --pause > /dev/null 2>&1
              DURDURULAN+=('deadbeef')
          fi ;;
        clementine)
          if qdbus_sorgu clementine
          then
              clementine --pause > /dev/null 2>&1
              DURDURULAN+=('clementine')
          fi ;;
        amarok)
          if qdbus_sorgu amarok
          then
              amarok --pause  > /dev/null 2>&1
              DURDURULAN+=('amarok')
          fi ;;
        rhythmbox)
          if dbus_sorgu rhythmbox
          then
              rhythmbox-client --pause  > /dev/null 2>&1
              DURDURULAN+=('rhytmbox')
          fi ;;
        aqulung)
          if dbus_sorgu aqualung
          then
              aqualung --pause > /dev/null 2>&1
              DURDURULAN+=('aqualung')
          fi ;;
        audacious)
          if dbus_sorgu audacious
          then
              audacious --pause > /dev/null 2>&1
              DURDURULAN+=('audacious')
          fi ;;
        banshee)
          if dbus_sorgu banshee
          then
              banshee --pause > /dev/null 2>&1
              DURDURULAN+=('banshee')
          fi ;;
        exaile)
          if dbus_sorgu exaile
          then
              exaile --play-pause > /dev/null 2>&1
              DURDURULAN+=('exaile')
          fi ;;
        moc)
          moc --pause > /dev/null 2>&1
          DURDURULAN+=('moc') ;;
        cmus)
          if [[ $(cmus-remote -C status | head -1) = status\ playing ]]
          then
              cmus-remote --pause > /dev/null 2>&1
              DURDURULAN+=('cmus')
          fi ;;
        qmmp)
          if qdbus_sorgu qmmp
          then
              qmmp --pause > /dev/null 2>&1
              DURDURULAN+=('qmmp')
          fi ;;
        juk)
          if qdbus_sorgu juk
          then
              qdbus org.kde.juk /org/mpris/MediaPlayer2 \
                org.mpris.MediaPlayer2.Player.Pause > /dev/null 2>&1
              DURDURULAN+=('juk')
          fi ;;
      esac
    }
  done
}

oynatici_devam() {
  for oynatici in ${DURDURULAN[@]}
  do
    case "${oynatici}" in
      spotify)
          dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
            /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null 2>&1 ;;
      deadbeef)
          deadbeef --play > /dev/null 2>&1 ;;
      clementine)
          clementine --play > /dev/null 2>&1 ;;
      amarok)
          amarok --play > /dev/null 2>&1 ;;
      rhythmbox)
          rhythmbox-client --play > /dev/null 2>&1 ;;
      aqulung)
          aqualung --play > /dev/null 2>&1 ;;
      audacious)
          audacious --play > /dev/null 2>&1 ;;
      banshee)
          banshee --play > /dev/null 2>&1 ;;
      exaile)
          exaile --play-pause > /dev/null 2>&1 ;;
      moc)
          moc --play > /dev/null 2>&1 ;;
      cmus)
          cmus-remote --play > /dev/null 2>&1 ;;
      qmmp)
          qmmp --play > /dev/null 2>&1 ;;
      juk)
          qdbus org.kde.juk /org/mpris/MediaPlayer2 \
            org.mpris.MediaPlayer2.Player.Play /dev/null 2>&1 ;;
    esac
  done
}

# vim: set ft=sh ts=2 sw=2 et:
