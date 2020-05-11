#!/bin/bash
#
# https://github.com/gojigeje/hijri.sh
# ----------------------------------------------------------------------------------
# @name    : hijri.sh
# @version : 0.2
# @date    : 10/09/16 08:36:54
#
# ABOUT
# ----------------------------------------------------------------------------------
# Simple bash script to display Islamic date (Hijri / Hijriyah).
# Ported from php script I found on internet. I do not own the calculation method.
#
# LICENSE
# ----------------------------------------------------------------------------------
#  The MIT License (MIT)
#  Copyright (c) 2016 Ghozy Arif Fajri <gojigeje@gmail.com>


hicri_tarih_al() {
  local adjust date month year a b c d e jd wd l n z m d y gun ay yil
  local -a hicri_aylar

  # date adjustment, use positive number to add days,
  # negative number to substract, '0' for none.
  adjust=$HICRI_TARIH_DUZELTME

  date=$(date +%-d -d "$adjust day")
  month=$(date +%-m)
  year=$(date +%Y)

  hicri_aylar=( 'Muharrem' 'Safer' 'Rebiülevvel' 'Rebiülahir' 'Cemaziyelevvel'
                'Cemaziyelahir' 'Receb' 'Şaban' 'Ramazan' 'Şevval' 'Zilkade'
                'Zilhicce' )

  a=$(( $(( month - 14 )) / 12 ))
  b=$(( $(( year + 4900 + a )) / 100 ))
  c=$(( $(( 1461 * $(( year + 4800 + a )) )) / 4 ))
  d=$(( $(( 367 * $(( month - 2 - 12 * a )) )) / 12 ))
  e=$(( $(( 3 * b )) / 4 ))

  jd=$(( c + d - e + date - 32075 ))
  wd=$(( jd % 7 ))
  l=$(( jd - 1948440 + 10632 ))
  n=$(( $(( l - 1 )) / 10631 ))
  l=$(( l - 10631 * n + 354 ))

  z=$(( $(( $(( 10985 - l )) / 5316 )) * $(( $(( 50 * l )) / 17719 )) + \
        $(( l / 5670 )) * $(( $(( 43 * l )) / 15238 )) ))
  l=$(( l - $(( $(( 30 - z )) / 15 )) * $(( $(( 17719 * z )) / 50 )) - \
        $(( z / 16 )) * $(( $(( 15238 * z )) / 43 )) + 29 ))

  m=$(( $(( 24 * l )) / 709 ))
  d=$(( l - $(( $(( 709 * m )) / 24 )) ))
  y=$(( 30 * n + z - 30 ))

  gun=$d
  ay=${hicri_aylar[$m-1]}
  yil=$y

  echo "$gun $ay $yil"
}

# vim: set ft=sh ts=2 sw=2 et:
