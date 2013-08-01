





function esma() {
    icerik_al=${VERI_DIZINI}/veriler/esma
    secim_yap 99

    (( ! ${RENK:-RENK_KULLAN} )) && {
      echo  "${alinan_yanit}" | tr -d '\\' | \
        sed -r -e 's:\[([0-9]{1,2}(;[0-9]{1,2})?)?[m]::g' -e 's:033::g'
      exit 0
    } || {
      printf "${alinan_yanit}${RENK0}\n"
      exit 0
    } 
}    

