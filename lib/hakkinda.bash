#!/bin/bash
#
#
#
#

function surum_goster() {
  printf '%s\n%s\n\n%s\n%s\n%s\n%s\n\n%s\n%s\n%s\n%s\n\n%s\n%s\n' \
    "${AD^} $SURUM düzenleme: $DUZELTME"\
    "Copyright (C) 2010-$(date +%Y) Fatih Bostancı"\
    'This program is free software; you can redistribute it and/or modify'\
    'it under the terms of the GNU General Public License as published by'\
    'the Free Software Foundation; either version 3 of the License, or'\
    '(at your option) any later version.'\
    'This program is distributed in the hope that it will be useful,'\
    'but WITHOUT ANY WARRANTY; without even the implied warranty of'\
    'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'\
    'GNU General Public License for more details.'\
    'You should have received a copy of the GNU General Public License'\
    'along with this program. If not, see http://www.gnu.org/licenses/.'
}

function g_hakkinda() {
  yad --text "\t\t<b><big>${AD^} ${SURUM}</big></b>
\"GNU/Linux için ezan vakti bildirici\"

   <a href= 'https://gitlab.com/fbostanci/ezanvakti' >Ezanvakti Sayfası</a>
   <a href= 'https://github.com/fbostanci/ezanvakti' >Ezanvakti Github Sayfası</a>

Copyright (c) 2010-$(date +%Y) Fatih Bostancı
GPL 3 ile lisanslanmıştır.\n" \
  --title "${AD^} ${SURUM} - Hakkında" --fixed --image-on-top \
  --button='gtk-close' --sticky --center \
  --image=${VERI_DIZINI}/simgeler/ezanvakti2.png --window-icon=${VERI_DIZINI}/simgeler/ezanvakti2.png
}
