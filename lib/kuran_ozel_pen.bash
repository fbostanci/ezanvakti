#!/bin/bash
#
#   Ezanvakti Özel Kuran Dinletimi Bileşeni
#
#


ozel_pencere() {
  local pencere okuyucular donus str str2 sure dinletilecek_sure oky oynatici_ileti
  bilesen_yukle arayuz_temel
  bilesen_yukle oynatici_yonetici

okuyucular='!Abdullah Awad al-Juhani!Ali Abdur-Rahman al-Huthaify!AbdulBaset AbdulSamad 1'
okuyucular+='!AbdulBaset AbdulSamad 2!Abdullah Ali Jabir!Abdullah Ali Jabir 2!AbdulKareem Al Hazmi'
okuyucular+='!Ahmad al-Huthaify!AbdulWadood Haneef!Ali Hajjaj Alsouasi!Abdullah Basfar'
okuyucular+='!AbdulMuhsin al-Qasim!AbdulAzeez al-Ahmad!AbdulWadud Haneef!Al-Hussayni Al-Azazy'
okuyucular+='!Abdullah Khayat!Abdul-Munim Abdul-Mubdi!Abu Bakr al-Shatri!Ahmad Nauina'
okuyucular+='!Abdur-Rahman as-Sudais!AbdulBari ath-Thubaity!Aziz Alili!Adel Kalbani'
okuyucular+='!Abdur-Rashid Sufi!Abdullah Matroud!Akram Al-Alaqmi!Bandar Baleela!Fares Abbad'
okuyucular+='!Hani ar-Rifai!Ibrahim Al-Jibrin!Imad Zuhair Hafez!Ibrahim Al Akhdar!Idrees Abkar'
okuyucular+='!Khalid al-Qahtani!Mishari Rashid al-Afasy!Muhammad Siddiq al-Minshawi 1'
okuyucular+='!Muhammad Siddiq al-Minshawi 2!Muhammad Jibreel!Muhammad al-Mehysni!Muhammad al-Luhaidan'
okuyucular+='!Maher al-Muaiqly!Muhammad Abdul-Kareem!Mustafa al-Azawi!Muhammad Hassan!Mostafa Ismaeel'
okuyucular+='!Mohammad Ismaeel Al-Muqaddim!Muhammad Ayyoob!Masjid Quba!Mahmoud Khaleel Al-Husary'
okuyucular+='!Mahmood Ali Al-Bana!Nabil ar-Rifai!Nasser Al Qatami!Saud ash-Shuraym!Saad al-Ghamdi'
okuyucular+='!Sahl Yasin!Salah Bukhatir!Sudais and Shuraym!Salah al-Budair!Salah Al-Hashim'
okuyucular+='!Wadee Hammadi Al Yamani!Yasser ad-Dussary'

[[ -z ${v_okuyucu} ]] && v_okuyucu='Abu Bakr al-Shatri'
[[ -z ${v_sure}    ]] && v_sure='001-Fatiha'

pencere=$(yad --form \
--field=Okuyucu:CB "^${v_okuyucu}${okuyucular}" \
--field=Sure:CB "^${v_sure}${sure_listesi}" \
--button=" Geri!${VERI_DIZINI}/simgeler/geri.png":151 \
--button=" Oynat!${VERI_DIZINI}/simgeler/oynat.png":152 \
--button='yad-quit:153' --image=${AD} \
--window-icon=${AD} --gtkrc="${EZV_CSS}" \
--title "${AD^}" --sticky --center --fixed)

donus=$(echo $?)

ESKI_IFS="$IFS"
IFS="
"
declare -x $(gawk -F'|' '{print "str="$1 "\nstr2="$2}' <<< "$pencere")
IFS="$ESKI_IFS"

case $donus in
  151)
    if (( ${ayz:-0} ))
    then arayuz
    else ozel_pencere
    fi ;;
  152)
    [[ -z $str2 ]] && ozel_pencere
    sure=$(cut -d'-' -f1 <<<"$str2")

    case "${str}" in
      'Abdullah Awad al-Juhani') oky=abdullaah_3awwaad_al-juhaynee ;;
      'Ali Abdur-Rahman al-Huthaify') oky=huthayfi ;;
      'AbdulBaset AbdulSamad 1') oky=abdul_basit_murattal ;;
      'AbdulBaset AbdulSamad 2') oky=abdulbaset_mujawwad ;;
      'Abdullah Ali Jabir') oky=abdullaah_alee_jaabir_studio ;;
      'AbdulKareem Al Hazmi') oky=abdulkareem_al_hazmi ;;
      'Ahmad al-Huthaify') oky=ahmad_alhuthayfi ;;
      'AbdulWadood Haneef') oky=abdul_wadood_haneef_rare ;;
      'Ali Hajjaj Alsouasi') oky=ali_hajjaj_alsouasi ;;
      'Abdullah Basfar') oky=abdullaah_basfar ;;
      'AbdulMuhsin al-Qasim') oky=abdul_muhsin_alqasim ;;
      'AbdulAzeez al-Ahmad') oky=abdulazeez_al-ahmad ;;
      'AbdulWadud Haneef') oky=abdulwadood_haneef ;;
      'Al-Hussayni Al-Azazy') oky=alhusaynee_al3azazee_with_children ;;
      'Abdullah Khayat') oky=khayat ;;
      'Abdul-Munim Abdul-Mubdi') oky=abdulmun3im_abdulmubdi2 ;;
      'Abu Bakr al-Shatri') oky=abu_bakr_ash-shatri_tarawee7 ;;
      'Ahmad Nauina') oky=ahmad_nauina ;;
      'Abdur-Rahman as-Sudais') oky=abdurrahmaan_as-sudays ;;
      'AbdulBari ath-Thubaity') oky=thubaity ;;
      'Abdullah Ali Jabir 2') oky=abdullaah_alee_jaabir ;;
      'Aziz Alili') oky=aziz_alili ;;
      'Adel Kalbani') oky=adel_kalbani ;;
      'Abdur-Rashid Sufi') oky=abdurrashid_sufi ;;
      'Abdullah Matroud') oky=abdullah_matroud ;;
      'Akram Al-Alaqmi') oky=akram_al_alaqmi ;;
      'Bandar Baleela') oky=bandar_baleela ;;
      'Fares Abbad') oky=fares ;;
      'Hani ar-Rifai') oky=rifai ;;
      'Ibrahim Al-Jibrin') oky=jibreen ;;
      'Imad Zuhair Hafez') oky=imad_zuhair_hafez ;;
      'Ibrahim Al Akhdar') oky=ibrahim_al_akhdar ;;
      'Idrees Abkar') oky=idrees_akbar ;;
      'Khalid al-Qahtani') oky=khaalid_al-qahtaanee ;;
      'Mishari Rashid al-Afasy') oky=mishaari_raashid_al_3afaasee ;;
      'Muhammad Siddiq al-Minshawi 1') oky=muhammad_siddeeq_al-minshaawee ;;
      'Muhammad Jibreel') oky=muhammad_jibreel/complete ;;
      'Muhammad al-Mehysni') oky=mehysni ;;
      'Muhammad Siddiq al-Minshawi 2') oky=minshawi_mujawwad ;;
      'Muhammad al-Luhaidan') oky=muhammad_alhaidan ;;
      'Maher al-Muaiqly') oky=maher_256 ;;
      'Muhammad Abdul-Kareem') oky=muhammad_abdulkareem ;;
      'Mustafa al-Azawi') oky=mustafa_al3azzawi ;;
      'Muhammad Hassan') oky=mu7ammad_7assan ;;
      'Mostafa Ismaeel') oky=mostafa_ismaeel ;;
      'Mohammad Ismaeel Al-Muqaddim') oky=mohammad_ismaeel_almuqaddim ;;
      'Muhammad Ayyoob') oky=muhammad_ayyoob_hq ;;
      'Masjid Quba') oky=masjid_quba_1434 ;;
      'Mahmoud Khaleel Al-Husary') oky=mahmood_khaleel_al-husaree_iza3a ;;
      'Mahmood Ali Al-Bana') oky=mahmood_ali_albana ;;
      'Nabil ar-Rifai') oky=nabil_rifa3i ;;
      'Nasser Al Qatami') oky=nasser_bin_ali_alqatami ;;
      'Saud ash-Shuraym') oky=sa3ood_al-shuraym ;;
      'Saad al-Ghamdi') oky=sa3d_al-ghaamidi/complete ;;
      'Sahl Yasin') oky=sahl_yaaseen ;;
      'Salah Bukhatir') oky=salaah_bukhaatir ;;
      'Sudais and Shuraym') oky=sodais_and_shuraim ;;
      'Salah al-Budair') oky=salahbudair ;;
      'Salah Al-Hashim') oky=salah_alhashim ;;
      'Wadee Hammadi Al Yamani') oky=wadee_hammadi_al-yamani ;;
      'Yasser ad-Dussary') oky=yasser_ad-dussary ;;
      *) oky='Yerel Okuyucu' ;;
    esac
    case "${#sure}" in
      1) sure=00$sure ;;
      2) sure=0$sure ;;
    esac
    v_okuyucu="$str"
    v_sure="$str2"

    if [[ ${oky} = Yerel Okuyucu ]]
    then
        if [[ -f "${YEREL_SURE_DIZINI}/${KURAN_OKUYAN}/$sure.mp3" ]]
        then
            dinletilecek_sure="${YEREL_SURE_DIZINI}/${KURAN_OKUYAN}/$sure.mp3"
        else
            ozel_pencere
        fi
    else
        dinletilecek_sure="https://download.quranicaudio.com/quran/${oky}/$sure.mp3"
    fi

    oynatici_ileti="$(gawk -v sira=$sure '{if(NR==sira) print $4;}' \
      < ${VERI_DIZINI}/veriler/sure_bilgisi) suresi dinletiliyor\n\n Okuyan   : ${str}"

    pencere_bilgi "${dinletilecek_sure}" &
    oynatici_calistir "${dinletilecek_sure}"
    ozel_pencere ;;

  153)
    exit 0 ;;
esac
}
