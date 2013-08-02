#
#
#
#
#

function sureler_ayetler() {
  clear
  gawk -v r0=${RENK0} -v r2=${RENK2} -v r3=${RENK3} -v r7=${RENK7} \
    'BEGIN{printf "%s%s%s\t%s%s\n", r7,r3,"KOD","SURE NO",r0}
    NR<115 {printf "%s%s%s\t%s%s%s\n", r7,r3,$1,r2,$3,r0}
    END{printf "\n\n%s%s%s%s%s%s%s%s\n", r7,r3,"Çıkmak için",r2," q ",r3,"tuşuna basınız.",r0}' \
    ${VERI_DIZINI}/veriler/sureler_ayetler | less -R
}

# vim: set ft=sh ts=2 sw=2 et:
