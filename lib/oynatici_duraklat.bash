#
#
#                           Ezanvakti Oynatıcı Duraklatma Bileşeni 1.3
#

function oynatici_islem() {
  OYNATICILAR=( deadbeef clementine amarok rhythmbox aqualung audacious banshee exaile cmus moc qmmp )

  for oynatici in ${OYNATICILAR[@]}
  do
    [ `pgrep ${oynatici}` ] && {
      if [ ${oynatici} = deadbeef ]
      then
          deadbeef --pause > /dev/null 2>&1
      elif [ ${oynatici} = clementine ]
      then
          clementine --pause > /dev/null 2>&1
      elif [ ${oynatici} = amarok ]
      then
          amarok --pause  > /dev/null 2>&1
      elif [ ${oynatici} = rhythmbox ]
      then
          rhythmbox-client --pause  > /dev/null 2>&1
      elif [ ${oynatici} = aqulung ]
      then
          aqualung --pause > /dev/null 2>&1
      elif [ ${oynatici} = audacious ]
      then
          audacious --pause > /dev/null 2>&1
      elif [ ${oynatici} = banshee ]
      then
          banshee --pause > /dev/null 2>&1
      elif [ ${oynatici} = exaile ]
      then
          exaile --play-pause > /dev/null 2>&1
      elif [ ${oynatici} = moc ]
      then
          moc --pause > /dev/null 2>&1
      elif [ ${oynatici} = cmus ]
      then
          cmus-remote --pause > /dev/null 2>&1
      elif [ ${oynatici} = qmmp ]
      then
          qmmp --pause > /dev/null 2>&1
      fi
    }
  done

ezandinlet

  for oynatici in ${OYNATICILAR[@]}
  do
    [ `pgrep ${oynatici}` ] && {
      if [ ${oynatici} = deadbeef ]
      then
          deadbeef --play > /dev/null 2>&1
      elif [ ${oynatici} = clementine ]
      then
          clementine --play > /dev/null 2>&1
      elif [ ${oynatici} = amarok ]
      then
          amarok --play > /dev/null 2>&1
      elif [ ${oynatici} = rhythmbox ]
      then
          rhythmbox-client --play > /dev/null 2>&1
      elif [ ${oynatici} = aqulung ]
      then
          aqualung --play > /dev/null 2>&1
      elif [ ${oynatici} = audacious ]
      then
          audacious --play > /dev/null 2>&1
      elif [ ${oynatici} = banshee ]
      then
          banshee --play > /dev/null 2>&1
      elif [ ${oynatici} = exaile ]
      then
          exaile --play-pause > /dev/null 2>&1
      elif [ ${oynatici} = moc ]
      then
          moc --play > /dev/null 2>&1
      elif [ ${oynatici} = cmus ]
      then
          cmus-remote --play > /dev/null 2>&1
      elif [ ${oynatici} = qmmp ]
      then
          qmmp --play > /dev/null 2>&1
      fi
    }
  done

unset oynatici
}

# vim: set ft=sh ts=2 sw=2 et: