#
#
#
#
#

function bilgi_goster() {
  icerik_al=${VERI_DIZINI}/veriler/bilgiler
  secim_yap 157

  case $1 in
    ucbirim)
      (( ! ${RENK:-RENK_KULLAN} )) && {
        printf "*${alinan_yanit}\n"
      } || {
        gawk -v r0=${RENK0} -v r3=${RENK3} -v r7=${RENK7} -v r7=${RENK8} \
          '{if (NR==1) {printf "%s%s%s%s\n",r7,r3,$0,r0;} else if (NR>1) {printf "%s%s%s%s\n",r7,r8,$0,r0;} }' <<< "${alinan_yanit}"
      } ;;

    bildirim)
      notify-send "Bunları biliyor musunuz?" "$(printf "*${alinan_yanit}\n")" \
        -t $BILGI_BILDIRIM_SURESI"000" -h int:transient:1 ;;
  esac
}

function hadis_goster() {
  icerik_al=${VERI_DIZINI}/veriler/kirk-hadis
  secim_yap 40

  case $1 in
    ucbirim)
      (( ! ${RENK:-RENK_KULLAN} )) && {
        printf "${alinan_yanit}\n"
      } || {
        gawk -v r0=${RENK0} -v r3=${RENK3} -v r7=${RENK7} -v r7=${RENK8} \
          '{if (NR==1) {printf "%s%s%s%s\n",r7,r3,$0,r0;} else if (NR>1) {printf "%s%s%s%s\n",r7,r8,$0,r0;} }' <<< "${alinan_yanit}"
      } ;;
    bildirim)
      notify-send "$secilen. hadis" "$(sed '1d' <<<"${alinan_yanit}")" \
        -t $HADIS_BILDIRIM_SURESI"000" -h int:transient:1 ;;
  esac
}

function esma_goster() {
  icerik_al=${VERI_DIZINI}/veriler/esma
  secim_yap 99

  (( ! ${RENK:-RENK_KULLAN} )) && {
    printf "${alinan_yanit}\n"
  } || {
    gawk -v r0=${RENK0} -v r3=${RENK3} -v r7=${RENK7} -v r7=${RENK8} \
      '{if (NR==1) {printf "%s%s%s%s\n",r7,r3,$0,r0;} else if (NR>1) {printf "%s%s%s%s\n",r7,r8,$0,r0;} }' <<< "${alinan_yanit}"
  }
}

# vim: set ft=sh ts=2 sw=2 et:
