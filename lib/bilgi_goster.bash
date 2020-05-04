#!/bin/bash
#
#
#
#

# Hadis, bilgi ve esma için 1 ile verilen sayı($1) arasında
# rastgele bir sayı seç. Seçilen sayı için içerik_al ile gelen
# dosya üzerinde işlem yapıp içeriği alinan_yanit değişkenine ata.
secim_yap() {
  secilen=$(( RANDOM % $1 ))
  (( ! secilen )) && secilen=$1

  alinan_yanit="$(sed -n "/#$secilen<#/,/#>$secilen#/p" ${icerik_al} | sed '1d;$d')"
}

ucbirimde_goster() {
  if (( ! ${RENK:-RENK_KULLAN} ))
  then
      printf "* ${alinan_yanit}\n"
  else
      gawk -v r0=${RENK0} -v r3=${RENK3} -v r7=${RENK7} -v r7=${RENK8} \
        '{if (NR==1) {printf "%s%s%s%s\n",r7,r3,$0,r0;} \
          else if (NR>1) {printf "%s%s%s%s\n",r7,r8,$0,r0;} }' <<< "${alinan_yanit}"
  fi
}

bilgi_goster() {
  icerik_al=${VERI_DIZINI}/veriler/bilgiler
  secim_yap 157

  case $1 in
    ucbirim)
      ucbirimde_goster ;;
    bildirim)
      notify-send "Bunları biliyor musunuz?" "$(printf "*${alinan_yanit}\n")" \
        -t $BILGI_BILDIRIM_SURESI"000" ;;
  esac
}

hadis_goster() {
  icerik_al=${VERI_DIZINI}/veriler/kirk-hadis
  secim_yap 40

  case $1 in
    ucbirim)
      ucbirimde_goster ;;
    bildirim)
      notify-send "$secilen. hadis" "$(sed '1d' <<<"${alinan_yanit}")" \
        -t $HADIS_BILDIRIM_SURESI"000" ;;
  esac
}

esma_goster() {
  icerik_al=${VERI_DIZINI}/veriler/esma
  secim_yap 99
  ucbirimde_goster
}

# vim: set ft=sh ts=2 sw=2 et:
