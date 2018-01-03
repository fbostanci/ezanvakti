#!/bin/bash
#
#     Ezanvakti bayram namazı vakitleri bileşeni
#
#

bayram_namazi_vakti() {
  local ulke_kodu sehir_kodu ilce_kodu ramazan_bt kurban_bt ramazan_nv kurban_nv
  renk_denetle

  [[ -z "${ULKE}"  ]] && ULKE=yok_boyle_bir_yer
  [[ -z "${SEHIR}" ]] && SEHIR=yok_boyle_bir_yer
  [[ -z "${ILCE}"  ]] && ILCE=yok_boyle_bir_yer

  if ! grep -qw ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER
  then
      bilesen_yukle guncelleyici
      guncelleme_yap
  elif ! grep -qw ${SEHIR} ${VERI_DIZINI}/ulkeler/${ULKE}
  then
      bilesen_yukle guncelleyici
      guncelleme_yap
  elif ! grep -qw ${ILCE} ${VERI_DIZINI}/ulkeler/${ULKE}_ilceler/${SEHIR}
  then
      bilesen_yukle guncelleyici
      guncelleme_yap
  fi

  ulke_kodu=$(grep -w ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER | cut -d, -f2)
  sehir_kodu=$(grep -w ${SEHIR} ${VERI_DIZINI}/ulkeler/${ULKE} | cut -d, -f2)

  if [[ ${ULKE} = @(TURKIYE|ABD|KANADA) ]]
  then
      ilce_kodu=$(grep -w ${ILCE} ${VERI_DIZINI}/ulkeler/${ULKE}_ilceler/${SEHIR} | cut -d, -f2)
  else
      ilce_kodu="${sehir_kodu}"
  fi

  printf '\n%b%s%b\r' "${RENK7}${RENK3}${ILCE} ${RENK8}" \
    'için bayram namazı vakitleri alınıyor...' "${RENK0}"

  # internet erişimini denetle.
  if ! ping -q -c 1 -W 1 google.com > /dev/null 2>&1
  then
      printf '\n%b\n' \
        "${RENK7}${RENK3}İnternet erişimi algılanamadı.${RENK0}"
      exit 1
  fi

  wget -q "http://namazvakitleri.diyanet.gov.tr/tr-TR/${ilce_kodu}" -O - | \
  sed -n 's:<span class="bayram-info-value-top">\(.*\)</span>:\1:p' > /tmp/ezv-bayram-vakitleri-$$


  # bayram namazı tarihlerini ve vakitlerini al.
  ramazan_bt="$(gawk -F'=' '/ramazan_bayrami_tarihi/{print $2}' < /tmp/ezv-bayram-vakitleri-$$)"
  ramazan_nv=$(gawk -F'=' '/ramazan_namaz_vakti/{print $2}' < /tmp/ezv-bayram-vakitleri-$$)
  kurban_bt="$(gawk -F'=' '/kurban_bayrami_tarihi/{print $2}' < /tmp/ezv-bayram-vakitleri-$$)"
  kurban_nv=$(gawk -F'=' '/kurban_namaz_vakti/{print $2}' < /tmp/ezv-bayram-vakitleri-$$)
  
  rm -f /tmp/ezv-bayram-vakitleri-$$ > /dev/null 2>&1

  [[ -z ${ramazan_bt} || -z ${kurban_bt} || -z ${ramazan_nv} || -z ${kurban_nv} ]] && {

    printf "${RENK7}${RENK4}\n!!! YENIDEN DENEYIN !!!${RENK0}\n"
    exit 1
  }

  rm -f /tmp/ezv-perl-hata-$$ > /dev/null 2>&1
  printf '%b%b%b\n' \
    "${RENK7}${RENK3}${ILCE}${RENK5} için bayram namazı vakitleri ($(date +'%d.%m.%Y %H:%M:%S'))\n\n" \
    "${RENK2}Ramazan bayramı namazı ${RENK3}: ${ramazan_nv} ${RENK2}$ramazan_bt\n" \
    "${RENK2}Kurban bayramı namazı  ${RENK3}: ${kurban_nv} ${RENK2}$kurban_bt${RENK0}\n" 
}

# vim: set ts=2 sw=2 et:
