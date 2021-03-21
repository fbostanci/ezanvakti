#!/bin/bash
#
#     Ezanvakti cuma hutbesi bileşeni
#
#

hutbe_indir() {
  # adres="$1" dizin="$2"
  if [[ -x $(type -p wget) ]]
  then
      wget --quiet --tries=3 "$1" -O "$2"
  elif [[ -x $(type -p curl) ]]
  then
      curl -L "$1" -o "$2"
  else
      printf '%s: Bu özellik wget ya da curl gerektirmektedir.\n' "${AD}" >&2
      exit 1
  fi
}

hutbe_goster() {
  local HUTBE_DIZINI="${EZANVAKTI_DIZINI}/hutbeler"
  local cuma ay yil hutbe_a hutbe_r hutbe_adresi hutbe

  if [[ $(date +%u) == 5 ]]
  then
      cuma=$(date +%d-%m-%Y)
      ay=$(date +%m)
      yil=$(date +%Y)
  else
      cuma=$(date -d 'last friday' +%d-%m-%Y)
      ay=$(date -d 'last friday' +%m)
      yil=$(date -d 'last friday' +%Y)
  fi

  hutbe_a="https://diyanet.nl/cuma-hutbeleri/"
  hutbe_r="https://diyanet.nl/wp-content/uploads/${yil}/${ay}/${cuma}-Vrijdagpreek-ISN-Turks.pdf"

  hutbe_indir "$hutbe_a" "/tmp/ezv-hutbe-$$"
  hutbe_adresi="$(grep -o "${hutbe_r}" /tmp/ezv-hutbe-$$)"
echo hutbe_adresi=$hutbe_adresi
  #rm -f /tmp/ezv-hutbe-$$ > /dev/null 2>&1

  hutbe="$(echo ${hutbe_adresi} | gawk -F'/' '{print($(NF))}')"
echo hutbe=$hutbe
  [[ ! -f ${HUTBE_DIZINI} ]] && mkdir -p "${HUTBE_DIZINI}"

  if [[ -f ${HUTBE_DIZINI}/$hutbe ]]
  then
      printf \
        "${RENK7}${RENK3}$hutbe${RENK8} dosyası açılacak.${RENK0}\n"
      xdg-open  "${HUTBE_DIZINI}/$hutbe"
  else
      hutbe_indir "${hutbe_adresi}" "${HUTBE_DIZINI}"
      echo  "${HUTBE_DIZINI}/$hutbe"
  fi
}

# vim: set ft=sh ts=2 sw=2 et:
