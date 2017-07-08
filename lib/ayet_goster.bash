#
#
#
#
#

function ayet_araligi_goster() {
  local sure_kod=$1
  local ayet_kod=$2
  local sure sure_adi sure_sira sure_baslama baslangic son sure_ayet_sayisi \
        int_ayet_kod ayet_baslama ayet_bitis satir

  if [[ -z ${sure_kod} || -z ${ayet_kod} ]]
  then
      printf "Kullanım: <sure_kodu> <ayet_aralığı>\n"
      exit 1
  fi

  if [[ -n $(tr -d 0-9 <<<$sure_kod) ]]
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Sure kodu olarak 1-114 arası sayısal bir değer giriniz.'
      exit 1

  elif (( ${#sure_kod} > 3 ))
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Girilen sure kodunun basamak sayısı <= 3 olmalı.'
      exit 1

  elif (( sure_kod < 1 || sure_kod > 114 ))
  then
      printf '%b\n%b\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Girilen sure kodu 1 <= sure_kodu <= 114 arasında olmalı.'
      exit 1

  else  # Girilen sure koduna göre değişkenin önüne sıfır ekle.
      if (( ${#sure_kod} == 1 ))
      then
          sure=00$sure_kod
      elif (( ${#sure_kod} == 2 ))
      then
          sure=0$sure_kod
      else
          sure=$sure_kod
      fi
  fi

  export $(gawk -v sira=$sure_kod '{if(NR==sira) {printf \
    "sure_adi=%s\nsure_sira=%s\nsure_baslama=%s\nsure_ayet_sayisi=%s\ncuz=%s\nyer=%s",$4,$1,$3,$2,$5,$6}}' \
    <${VERI_DIZINI}/veriler/sure_bilgisi)

  int_ayet_kod=$(tr -d 0-9 <<<$ayet_kod)
  if [[ -z $int_ayet_kod ]]
  then
      if (( ayet_kod > sure_ayet_sayisi ))
      then
          printf "$sure_adi Suresi $sure_ayet_sayisi ayetten oluşmaktadır.\n"
          exit 1
      fi
      if (( ayet_kod == 0 ))
      then
          printf "$sure_adi Suresi için ayet aralığını yanlış girdiniz.\n"
          exit 1
      fi

      ayet_baslama=$((sure_baslama+ayet_kod))
      ayet_bitis=$ayet_baslama
  elif [[ $int_ayet_kod = - ]]
  then
      export $(gawk -F'-' '{printf "ilk_sayi=%d\nikinci_sayi=%d", $1,$2}' <<<$ayet_kod)
      if (( ilk_sayi > ikinci_sayi ))
      then
          printf "$sure_adi Suresi için ayet aralığını yanlış girdiniz.\n"
          exit 1

      fi
      if (( ikinci_sayi > sure_ayet_sayisi ))
      then
          printf "$sure_adi Suresi $sure_ayet_sayisi ayetten oluşmaktadır.\n"
          exit 1

      fi
      if (( ilk_sayi == 0 )) || (( ikinci_sayi == 0 ))
      then
          printf "$sure_adi Suresi için ayet aralığını yanlış girdiniz.\n"
          exit 1
      fi

      ayet_baslama=$((sure_baslama+ilk_sayi))
      ayet_bitis=$((sure_baslama+ikinci_sayi))
  else
      printf "$sure_adi Suresi için ayet aralığını yanlış girdiniz.\n"
      exit 1
  fi

  for satir in $(seq $ayet_baslama $ayet_bitis)
  do
    printf "%b%b%b\n%b\n\n" "${RENK5}(${RENK2}Ayet: ${RENK3}$(sed -n "${satir}p"\
      "${VERI_DIZINI}/veriler/sureler_ayetler")"\
      "${RENK2} Genel sıra: ${RENK3}$satir/6236 ${RENK2}"\
      "${RENK2}Cüz:${RENK3} $cuz ${RENK2}İndiği yer: ${RENK3}$yer${RENK5})"\
      "${RENK8}$(sed -n "${satir}p" "${TEFSIR}")${RENK0}"
  done
}

function ayet_goster() { # {{{
  renk_denetle

  [[ -f "${KULLANICI_TEFSIR_DIZINI}/${TEFSIR_SAHIBI}" ]] && {
    TEFSIR="${KULLANICI_TEFSIR_DIZINI}/${TEFSIR_SAHIBI}"
  } || {
  [[ -f "${VERI_DIZINI}/tefsirler/${TEFSIR_SAHIBI}" ]] &&
    TEFSIR="${VERI_DIZINI}/tefsirler/${TEFSIR_SAHIBI}"
  } || {
    printf "${RENK3}${TEFSIR_SAHIBI} dosyası bulunamadı.${RENK0}\n"
    exit 1
  }

  satir=$((RANDOM%6236))
  (( ! satir )) && satir=6236


  case $1 in
    ucbirim)
    printf '%b%b%b\n' \
      "${RENK3}\nGünlük Ayet ${RENK2}(${RENK8}" \
      "$(sed -n "${satir}p" ${VERI_DIZINI}/veriler/sureler_ayetler) $satir/6236${RENK2})${RENK8}\n\n" \
      "$(sed -n "${satir}p" "${TEFSIR}")${RENK0}" ;;

  bildirim)
    notify-send "Günlük Ayet ($(sed -n "${satir}p" ${VERI_DIZINI}/veriler/sureler_ayetler))" \
      "$(sed -n "${satir}p" "${TEFSIR}")" -t $AYET_BILDIRIM_SURESI"000" -h int:transient:1
    exit 0 ;;

  aralik)
    ayet_araligi_goster $2 $3
    exit 0 ;;

  esac
} # }}}

# vim: set ft=sh ts=2 sw=2 et:
