#!/bin/bash
#
#               Ezanvakti Ayet Aralığı bileşeni
#
#

ayet_araligi_goster() {
  renk_denetle

  local sure_kod=$1 ayet_kod=$2
  local sure_adi sure_baslama sure_ayet_sayisi int_ayet_kod ayet_baslama ayet_bitis satir

  if [[ -f ${KULLANICI_TEFSIR_DIZINI}/${TEFSIR_SAHIBI} ]]
  then
      TEFSIR="${KULLANICI_TEFSIR_DIZINI}/${TEFSIR_SAHIBI}"
  elif [[ -f ${VERI_DIZINI}/tefsirler/${TEFSIR_SAHIBI} ]]
  then
      TEFSIR="${VERI_DIZINI}/tefsirler/${TEFSIR_SAHIBI}"
  else
      printf '%s: %s tefsir dosyası bulunamadı.\n' "${AD}" "${TEFSIR_SAHIBI}" >&2
      exit 1
  fi

  if [[ -z ${ayet_kod} ]]
  then
      printf "%s: Kullanım: <sure_kodu> <ayet_aralığı>\n" "${AD}" >&2
      exit 1
  fi

  if [[ -n $(tr -d 0-9 <<<"$sure_kod") ]]
  then
      printf '%s\n%s\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Sure kodu olarak 1-114 arası sayısal bir değer giriniz.' >&2
      exit 1

  elif (( ${#sure_kod} > 3 ))
  then
      printf '%s\n%s\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Girilen sure kodunun basamak sayısı <= 3 olmalı.' >&2
      exit 1

  elif (( sure_kod < 1 || sure_kod > 114 ))
  then
      printf '%s\n%s\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Girilen sure kodu 1 <= sure_kodu <= 114 arasında olmalı.' >&2
      exit 1

  else  # Girilen sure koduna göre değişkenin önüne sıfır ekle.
      if (( ${#sure_kod} == 1 ))
      then
          sure_kod=00$sure_kod
      elif (( ${#sure_kod} == 2 ))
      then
          sure_kod=0$sure_kod
      fi
  fi

  export $(gawk -v sira=$sure_kod '{if(NR==sira) {printf \
    "sure_adi=%s\nsure_baslama=%s\nsure_ayet_sayisi=%s\ncuz=%s\nyer=%s",$4,$3,$2,$5,$6}}' \
    < ${VERI_DIZINI}/veriler/sure_bilgisi)

  int_ayet_kod=$(tr -d 0-9 <<<"$ayet_kod")
  if [[ -z $int_ayet_kod ]]
  then
      if (( ayet_kod > sure_ayet_sayisi ))
      then
          printf '%s: %s Suresi %s ayetten oluşmaktadır.\n' "${AD}" "${sure_adi}" "$sure_ayet_sayisi" >&2
          exit 1
      fi
      if (( ayet_kod == 0 ))
      then
          printf '%s: %s Suresi için ayet aralığını yanlış girdiniz.\n' "${AD}" "${sure_adi}" >&2
          exit 1
      fi

      ayet_baslama=$(( sure_baslama + ayet_kod ))
      ayet_bitis=$ayet_baslama
  elif [[ $int_ayet_kod = - ]]
  then
      export $(gawk -F'-' '{printf "ilk_sayi=%d\nikinci_sayi=%d", $1,$2}' <<<$ayet_kod)
      if (( ilk_sayi > ikinci_sayi ))
      then
          printf '%s: %s Suresi için ayet aralığını yanlış girdiniz.\n' "${AD}" "${sure_adi}"  >&2
          exit 1

      fi
      if (( ikinci_sayi > sure_ayet_sayisi ))
      then
          printf '%s: %s Suresi %s ayetten oluşmaktadır.\n' "${AD}" "${sure_adi}" "$sure_ayet_sayisi" >&2
          exit 1

      fi
      if (( ilk_sayi == 0 || ikinci_sayi == 0 ))
      then
          printf '%s: %s Suresi için ayet aralığını yanlış girdiniz.\n' "${AD}" "${sure_adi}" >&2
          exit 1
      fi

      ayet_baslama=$(( sure_baslama + ilk_sayi ))
      ayet_bitis=$(( sure_baslama + ikinci_sayi ))
  else
      printf '%s: %s Suresi için ayet aralığını yanlış girdiniz.\n' "${AD}" "${sure_adi}" >&2
      exit 1
  fi

  for satir in $(seq $ayet_baslama $ayet_bitis)
  do
    printf "%b%b%b\n%b\n\n" "${RENK5}(${RENK2}Ayet: ${RENK3}$(sed -n "${satir}p"\
      "${VERI_DIZINI}/veriler/sureler_ayetler")"\
      "${RENK2} Genel sıra: ${RENK3}${satir}/6236 ${RENK2}"\
      "${RENK2}Cüz:${RENK3} ${cuz} ${RENK2}İndiği yer: ${RENK3}${yer}${RENK5})"\
      "${RENK8}$(sed -n "${satir}p" "${TEFSIR}")${RENK0}"
  done
}
