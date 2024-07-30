#!/bin/bash
#
#
#
#

kuran_okuyan_denetle() {
  local sure_kod="$1"
  # Öncelikle kullanıcının girdiği dizinde dosya
  # var mı denetle. Yoksa çevrimiçi dinletime yönel.
  if [[ -f ${YEREL_SURE_DIZINI}/${KURAN_OKUYAN}/$sure_kod.mp3 ]]
  then
      dinletilecek_sure="${YEREL_SURE_DIZINI}/${KURAN_OKUYAN}/$sure_kod.mp3"
      kaynak='Yerel Dizin'
      okuyan="${KURAN_OKUYAN}"
  else
      # Seçilen KURAN_OKUYAN değerine göre okuyucunun
      # tam adını okuyucu değişkenine ata.
      case "${KURAN_OKUYAN}" in
        AlGhamdi)  okuyan='Saad el Ghamdi'; KURAN_OKUYAN_K='sa3d_al-ghaamidi/complete' ;;
        AsShatree) okuyan='As Shatry'; KURAN_OKUYAN_K='abu_bakr_ash-shatri_tarawee7' ;;
        AlAjmy)    okuyan='Ahmad el Ajmy'; KURAN_OKUYAN_K='ahmed_ibn_3ali_al-3ajamy' ;;
        *)
          printf '%s: Desteklenmeyen KURAN_OKUYAN adı: %s\n' \
            "${AD}" "${KURAN_OKUYAN}" >&2
          exit 1 ;;
      esac
      dinletilecek_sure="https://download.quranicaudio.com/quran/${KURAN_OKUYAN_K}/$sure_kod.mp3"
      kaynak='https://www.quranicaudio.com'
  fi
}

sure_no_denetle() {
  sure_kod="$1"
  if [[ -n ${sure_kod//[[:digit:]]/} ]]
  then
      printf '%s\n%s\n' \
        "${AD}: hatalı sure_kodu: \`$sure_kod' " \
        'Sure kodu olarak 1-114 arası sayısal bir değer giriniz.' >&2
      exit 1
  fi

  # sure_kod 000001 gibiyse hata verme öndeki sıfırları sil, devam et.
  # ayrıca 08, 09 sayı hatasını da çözüyor.
  sure_kod="$(sed 's/^0*//' <<<$sure_kod)"
  if (( sure_kod < 1 || sure_kod > 114 ))
  then
      printf '%s\n%s\n' \
        "${AD}: hatalı sure_kodu: \`${sure_kod:-0}' " \
        'Girilen sure kodu 1 <= sure_kodu <= 114 arasında olmalı.' >&2
      exit 1
  else
      # Girilen sure koduna göre değişkenin önüne sıfır ekle.
      case "${#sure_kod}" in
        1) sure_kod=00$sure_kod ;;
        2) sure_kod=0$sure_kod ;;
      esac
  fi
}

meal_denetle() {
  if [[ -f ${YEREL_MEAL_DIZINI}/${MEAL_SAHIBI} ]]
  then
      MEAL="${YEREL_MEAL_DIZINI}/${MEAL_SAHIBI}"
  elif [[ -f ${VERI_DIZINI}/mealler/${MEAL_SAHIBI} ]]
  then
      MEAL="${VERI_DIZINI}/mealler/${MEAL_SAHIBI}"
  else
      printf "${RENK3}${MEAL_SAHIBI} dosyası bulunamadı.${RENK0}\n" >&2
      exit 1
  fi
}
