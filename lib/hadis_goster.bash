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
          printf "${alinan_yanit}\n"
          exit 0
        } || {
          # TODO: Renklendirme işlemleri
          printf "${alinan_yanit}\n"
          exit 0
        } ;;
      bildirim)
        notify-send "$secilen. hadis" "$(sed '1d' <<<"${alinan_yanit}")" \
          -t $HADIS_BILDIRIM_SURESI"000" -h int:transient:1
        exit 0 ;;
    esac
}

# vim: set ft=sh ts=2 sw=2 et:
