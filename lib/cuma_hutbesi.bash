#!/bin/bash
#
#     Ezanvakti cuma hutbesi bileşeni
#
#

# TODO: Hutbe içerik sitesi değiştirilecek.
if ! [[ -x $(type -p wget) ]]
then
    printf '%s: Bu özellik wget gerektirmektedir.\n' "${AD}" >&2
    exit 1
fi

export WGET='wget --quiet --tries=3'
export HUTBE_DIZINI="${EZANVAKTI_DIZINI}/hutbeler"

hutbe_var_mi() {
  local hutbe_adresi="$1"
  local hutbe_adi="$(echo ${hutbe_adresi} | gawk -F'/' '{print($(NF))}')"

  if [[ -f ${HUTBE_DIZINI}/$hutbe_adi ]]
  then
      xdg-open  ${HUTBE_DIZINI}/$hutbe_adi
  else
      ${WGET} ${hutbe_adresi} -P ${HUTBE_DIZINI}
      xdg-open  ${HUTBE_DIZINI}/$hutbe_adi
  fi
}
export -f hutbe_var_mi

hutbe_indir() {
  local cuma regex e i
  local -a indir acilacak

case $1 in
  listele)
    yad --title "${AD} hutbe indirici" --window-icon=${AD} --html --browser \
      --uri="http://www.ditib.de/media/Image/hutbe/hutbe_14082020_tr.pdf" \
      --width=620 --height=600 \
      --uri-handler="bash -c 'hutbe_var_mi %s'" ;;
  *)
    if [[ $(date +%u) == 5 ]]
    then
        cuma=$(date +%d)
        ay=$(date +%m)
        yil=$(date +%Y)
    else
        cuma=$(date -d 'last friday' +%d%m%Y)
        ay=$(date -d 'last friday' +%m)
        yil=$(date -d 'last friday' +%Y)
    fi
    regex="http://www.ditib.de/media/Image/hutbe/hutbe_${cuma}${ay}${yil}_tr.pdf"

    ${WGET} http://www.diyanet.nl/cuma-hutbeleri/ -O /tmp/ezv-hutbe-$$

    indir=( "$(grep -Eo "${regex}" /tmp/ezv-hutbe-$$)" )
    rm -f /tmp/ezv-hutbe-$$ > /dev/null 2>&1

    for i in ${indir[@]}
    do
      acilacak+=( "$(echo $i | gawk -F'/' '{print($(NF))}')" )
    done

    e=0; renk_denetle
    for i in ${acilacak[@]}
    do
      printf \
        "${RENK7}${RENK3}$i${RENK8} dosyası açılacak.${RENK0}\n"

      if [[ -f ${HUTBE_DIZINI}/$i ]]
      then
          xdg-open  ${HUTBE_DIZINI}/$i
      else
          ${WGET} ${indir[$e]} -P ${HUTBE_DIZINI}
          xdg-open  ${HUTBE_DIZINI}/$i
      fi
      ((e++))
    done ;;
esac
}

# vim: set ft=sh ts=2 sw=2 et:
