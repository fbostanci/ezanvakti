#
#
#
#
#

function bilgi_goster() {
    icerik_al=${VERI_DIZINI}/veriler/bilgiler
    secim_yap 157

    case $2 in
      -u|-t|--u[cç]birim|--terminal)
        (( ! ${RENK:-RENK_KULLAN} )) && {
          echo  "\*${alinan_yanit}" | tr -d '\\' | \
            sed -r -e 's:\[([0-9]{1,2}(;[0-9]{1,2})?)?[m]::g' -e 's:033::g'
          exit 0
        } || {
          printf "${alinan_yanit}${RENK0}\n"
          exit 0
        } ;;
      ?*)
        hatali_kullanim $2 ;;
    esac

    notify-send "Bunları biliyor musunuz?" "$(echo  "\*${alinan_yanit}" | tr -d '\\' | sed \
      -r -e 's:\[([0-9]{1,2}(;[0-9]{1,2})?)?[m]::g' -e 's:033::g')" \
      -t $BILGI_BILDIRIM_SURESI"000" -h int:transient:1
    exit 0
}

# vim: set ft=sh ts=2 sw=2 et:
