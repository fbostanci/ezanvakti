#
#
#
#
#

function hadis_goster() {
    icerik_al=${VERI_DIZINI}/veriler/kirk-hadis
    secim_yap 40

    case $1 in
      ucbirim)
        (( ! ${RENK:-RENK_KULLAN} )) && {
          echo  "${alinan_yanit}" | tr -d '\\' | \
            sed -r -e 's:\[([0-9]{1,2}(;[0-9]{1,2})?)?[m]::g' -e 's:033::g'
          exit 0
        } || {
          printf "${alinan_yanit}${RENK0}\n"
          exit 0
        } ;;
      bildirim)
        notify-send "$secilen. hadis" "$(sed '1d' <<<"${alinan_yanit}")" \
          -t $HADIS_BILDIRIM_SURESI"000" -h int:transient:1
        exit 0 ;;
    esac
}

# vim: set ft=sh ts=2 sw=2 et:
