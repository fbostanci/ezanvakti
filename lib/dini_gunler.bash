
function gunler() {
    printf "${RENK7}${RENK3}\n$(date +%Y)${RENK2} yılı için dini günler ve geceler\n\n"
    sed -n "s:\([0-9].*$(date +%Y)\)\(.*\):$(echo -e "${RENK7}${RENK3}\1\t${RENK2}\2${RENK0}\n"):p" \
      <${VERI_DIZINI}/veriler/gunler
}
