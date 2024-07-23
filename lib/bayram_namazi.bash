#!/bin/bash
#
#     Ezanvakti bayram namazı vakitleri bileşeni
#
#

bayram_namazi_vakti() {
  local ulke_kodu sehir_kodu ilce_kodu bayram_bt bayram_nv bayram_ad
  renk_denetle

  [[ -z "${ULKE}"  ]] && ULKE=yok_boyle_bir_yer
  [[ -z "${SEHIR}" ]] && SEHIR=yok_boyle_bir_yer
  [[ -z "${ILCE}"  ]] && ILCE=yok_boyle_bir_yer

  if ! grep -qw "${ULKE}" ${VERI_DIZINI}/ulkeler/AAA-ULKELER
  then
      bilesen_yukle guncelleyici
      guncelleme_yap
  elif ! grep -qw "${SEHIR}" ${VERI_DIZINI}/ulkeler/${ULKE}
  then
      bilesen_yukle guncelleyici
      guncelleme_yap
  elif ! grep -qw "${ILCE}" ${VERI_DIZINI}/ulkeler/${ULKE}_ilceler/${SEHIR}
  then
      bilesen_yukle guncelleyici
      guncelleme_yap
  fi

  ulke_kodu=$(grep -w ${ULKE} ${VERI_DIZINI}/ulkeler/AAA-ULKELER | cut -d, -f2)
  sehir_kodu=$(grep -w ${SEHIR} ${VERI_DIZINI}/ulkeler/${ULKE} | cut -d, -f2)

  if [[ ${ULKE} = @(TURKIYE|ABD|ALMANYA|KANADA) ]]
  then
      ilce_kodu=$(grep -w ${ILCE} ${VERI_DIZINI}/ulkeler/${ULKE}_ilceler/${SEHIR} | cut -d, -f2)
  else
      ilce_kodu="${sehir_kodu}"
  fi

  printf '\n%b%s%b\r' "${RENK7}${RENK3}${ILCE} ${RENK8}" \
    'için bayram namazı vakitleri alınıyor...' "${RENK0}"

  # internet erişimini denetle. (temel_islevler.bash)
  if ! internet_erisimi_var_mi
  then
      printf '%s: internet erişimi algılanamadı.\n' "${AD}" >&2
      exit 1
  fi


  indirici "https://namazvakitleri.diyanet.gov.tr/tr-TR/${ilce_kodu}" > /tmp/ezv-bayram-vakitleri-$$
  sed -i 's:[^[:print:]]: :g' /tmp/ezv-bayram-vakitleri-$$

  # bayram namazı verilerini al.
  {
    read -r bayram_bt
    read -r bayram_nv
    read -r bayram_ad
  }  < <(sed -n  's:<span class=\"bayram-info-value-top\">\(.*\)</span>:\1:p' </tmp/ezv-bayram-vakitleri-$$
         sed -n 's:<div class="bayram-vakit-container" id="\(.*\)-bayram-container">:\1:p' </tmp/ezv-bayram-vakitleri-$$)


  rm -f /tmp/ezv-bayram-vakitleri-$$ > /dev/null 2>&1

  [[ -z ${bayram_bt} || -z ${bayram_nv} ]] && {

    printf "${RENK7}${RENK4}\n!!! YENIDEN DENEYIN !!!${RENK0}\n"
    return 1
  }

  printf '%b%b\n' \
    "${RENK7}${RENK3}${ILCE}${RENK5} için bayram namazı vakitleri ($(date +'%d.%m.%Y %T'))\n\n" \
    "${RENK2}${bayram_ad^} Bayramı Namazı ${RENK3}: ${bayram_bt} ${RENK2}${bayram_nv}\n"
}

# vim: set ts=2 sw=2 et:
