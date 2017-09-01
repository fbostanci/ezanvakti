#!/bin/bash
#
#
#
#

bayram_namazi_vakti() {
  local ulke_kodu sehir_kodu ilce_kodu ramazan kurban ramazan_nv kurban_nv
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

  printf '%b%s%b\r' "${RENK7}${RENK8}" \
    'Bayram namazı vakitleri alınıyor...' "${RENK0}"

  # internet erişimini denetle.
  if ! ping -q -c 1 -W 1 google.com > /dev/null 2>&1
  then
      printf '\n%b\n' \
        "${RENK7}${RENK3}İnternet erişimi algılanamadı.${RENK0}"
      exit 1
  fi


  ${BILESEN_DIZINI}/ezanveri_istemci.pl "${ulke_kodu}" "${sehir_kodu}" "${ilce_kodu}" 'bayram' \
    2> /tmp/ezv-perl-hata-$$ > /tmp/ezv-bayram-vakitleri-$$

  # bayram tarihlerini al.
  export $(gawk -v r="[0-9]{2}.[0-9]{2}.$(date +%Y) RAMAZAN BAYRAMI 1. GÜN" \
                -v k="[0-9]{2}.[0-9]{2}.$(date +%Y) KURBAN BAYRAMI 1. GÜN" \
          '$0 ~ r {print "ramazan="$1}
           $0 ~ k {print "kurban="$1}' <${VERI_DIZINI}/veriler/gunler)

  ramazan_nv=$(gawk -F'=' '/ramazan_namaz_vakti/{print $2}' < /tmp/ezv-bayram-vakitleri-$$)
  kurban_nv=$(gawk -F'=' '/kurban_namaz_vakti/{print $2}' < /tmp/ezv-bayram-vakitleri-$$)
  # TODO: perl hata denetimleri ekle.
  printf '%b%b%b\n' \
    "${RENK7}${RENK3}${ILCE}${RENK5} için bayram namazı vakitleri $(date +'%d.%m.%Y %H:%M:%S')\n\n" \
    "${RENK2}Ramazan bayramı namazı ${RENK5}: ${ramazan} ${RENK3}$ramazan_nv\n" \
    "${RENK2}Kurban bayramı namazı  ${RENK5}: ${kurban} ${RENK3}$kurban_nv${RENK0}\n" 
}
