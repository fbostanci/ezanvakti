#
#
#
#
#

function esma() {
    icerik_al=${VERI_DIZINI}/veriler/esma
    secim_yap 99

    (( ! ${RENK:-RENK_KULLAN} )) && {
      printf "${alinan_yanit}\n"
      exit 0
    } || {
      # TODO: Renklendirme işlemleri
      printf "${alinan_yanit}\n"
      exit 0
    }
}

# vim: set ft=sh ts=2 sw=2 et:

