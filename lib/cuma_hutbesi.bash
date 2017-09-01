#!/bin/bash
#
#     Ezanvakti cuma hutbesi bileşeni
#
#

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
  local cuma regex
  local -a indir acilacak

case $1 in
  listele)
    yad --title "Ezv hutbe indirici" --window-icon=${AD} --html --browser\
      --uri="http://www.diyanet.nl/cuma-hutbeleri/" \
      --width=620 --height=600 \
      --uri-handler="bash -c 'hutbe_var_mi %s'" ;;
  *)
    if [[ $(date +%u) == 5 ]]
    then
        cuma=$(date +%d-%m-%Y)
    else
        cuma=$(date -d 'last friday' +%d-%m-%Y)
    fi
    regex="http://www.diyanet.nl/wp-content/uploads/$(date +%Y)/*/.*${cuma}.*TR.docx"

    ${WGET} http://www.diyanet.nl/cuma-hutbeleri/ -O /tmp/ezv-hutbe-$$

    indir=("$(grep -Eo "${regex}" /tmp/ezv-hutbe-$$)")
    acilacak=("$(grep -Eo "${cuma}.*TR.docx" /tmp/ezv-hutbe-$$)")

    # TODO: Hutbe var mı denetle yoksa indir.
    ${WGET} ${indir[@]} -P ${HUTBE_DIZINI}

    for i in ${acilacak[@]}
    do
      xdg-open ${HUTBE_DIZINI}/$i
    done ;;
esac
}
