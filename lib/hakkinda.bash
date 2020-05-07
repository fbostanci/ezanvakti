#!/bin/bash
#
#
#
#

surum_goster() {
  printf '%s\n%s\n\n%s\n%s\n%s\n' \
    "${AD^} $SURUM düzenleme: $DUZELTME"\
    "Copyright (C) 2010-$(date +%Y) Fatih Bostancı"\
    'License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>.'\
    'This is free software: you are free to change and redistribute it.'\
    'There is NO WARRANTY, to the extent permitted by law.'
}

g_hakkinda() {
  yad --text "\t\t<b><big>${AD^} ${SURUM}</big></b>
\"GNU/Linux için ezan vakti bildirici\"

   <a href= 'https://gitlab.com/fbostanci/ezanvakti' >Ezanvakti Sayfası</a>
   <a href= 'https://github.com/fbostanci/ezanvakti' >Ezanvakti Github Sayfası</a>

Copyright (c) 2010-$(date +%Y) Fatih Bostancı
GPL 3 ile lisanslanmıştır.\n" \
  --title "${AD^} - Hakkında" --fixed --image-on-top \
  --button='gtk-close' --sticky --center \
  --image=${AD} --window-icon=${AD}
}

# vim: set ft=sh ts=2 sw=2 et:
