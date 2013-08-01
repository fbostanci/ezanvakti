

function sureler_ayetler() {
    clear
    gawk -v renk0=${RENK0} -v renk2=${RENK2} -v renk3=${RENK3} -v renk7=${RENK7} \
      '{printf "%s%s%s\t%s%s%s%s\n", renk7,renk3,$1,renk2,$2,renk3,$3,renk0}' \
      ${VERI_DIZINI}/veriler/sureler | less -R
}
