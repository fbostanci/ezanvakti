#!/bin/bash
#
#
# ülke,şehir,ilçe dosyalarını oluşturur.
#
#

[[ ! -x $(type -p jq)   ]] && { echo "jq gerekli"; exit 1; }
[[ ! -x $(type -p wget) ]] && { echo "wget gerekli"; exit 1; }
[[ ! -d ulkeler         ]] && mkdir ulkeler

wget -q "https://namazvakitleri.diyanet.gov.tr/tr-TR/" -O - | \
  sed -n '/<select class="country-select region-select".*>/,/<\/select>/p'| \
  sed -n 's:<option value="\(.*\)">\(.*\)</option>:\2,\1:p' | \
  sed -e 's:[^[:print:]]::g' -e 's:^[[:blank:]]*::' -e 's:T\&#220\;RKİYE:TURKIYE:' > ulkeler/AAA-ULKELER

toplam=$(wc -l < ulkeler/AAA-ULKELER)
n=1
while read -r ulke
do
    ulke_kodu=$(echo ${ulke} | cut -d, -f2)
    ulke_adi="$(echo ${ulke} | cut -d, -f1)"
    printf '[ %3d/%d ] %s\n' "$n" "$toplam" "$ulke_adi"

    if [[ ${ulke_adi} = @(TURKIYE|ABD|ALMANYA|KANADA) ]]
    then
        jq_exec='.StateList[] | (.SehirAdiEn,.SehirID)'
    elif [[ ${ulke_adi} = @(LITVANYA|LUBNAN|S. ARABISTAN) ]]
    then
        echo "---> ${ulke_adi} hatalı. Geçici çözüm denenecek."
        continue
    else
        jq_exec='.StateRegionList[] | (.IlceAdiEn,.IlceID)'
    fi
    wget -q "https://namazvakitleri.diyanet.gov.tr/tr-TR/home/GetRegList?ChangeType=country&CountryId=${ulke_kodu}&Culture=tr-TR"  -O - |\
      jq "${jq_exec}" | sed -e 's:\"::g' -e 's/[[:space:]]*$//' | paste -d, - -  > "ulkeler/${ulke_adi}"
      [[ $(wc -l < "ulkeler/${ulke_adi}") == 0 ]] && echo "---> ${ulke_adi} hatalı inmiş."
    sleep 0.6
    ((n++))
done < ulkeler/AAA-ULKELER

n=1
for hata in LITVANYA LUBNAN 'S. ARABISTAN'
do
  case "$hata" in
    LITVANYA) ulke_kodu='759'; ulke_adi="$hata" ;;
    LUBNAN) ulke_kodu='760'; ulke_adi="$hata" ;;
    'S. ARABISTAN') ulke_kodu='819'; ulke_adi="$hata" ;;
  esac
  printf '[ %3d/%d ] Geçici çözüm -> %s\n' "$n" "3" "$ulke_adi"
  wget -q "https://namazvakitleri.diyanet.gov.tr/tr-TR/home/GetRegList?ChangeType=state&StateId=${ulke_kodu}&Culture=tr-TR"  -O - |\
    jq '.StateRegionList[] | (.IlceAdi,.IlceID)'| sed -e 's:\"::g' -e 's/[[:space:]]*$//' | paste -d, - - > "ulkeler/${ulke_adi}"
  sleep 0.6
  ((n++))
done

for ulke in TURKIYE ABD ALMANYA KANADA
do
    mkdir -p "ulkeler/${ulke}_ilceler"
    toplam=$(wc -l < ulkeler/${ulke})
    n=1
    echo "$ulke -> ilçeler alınıyor..."
    while read -r sehir
    do
      sehir_kodu=$(echo ${sehir} | cut -d, -f2)
      sehir_adi="$(echo ${sehir} | cut -d, -f1)"

      printf '[ %3d/%d ] %s -> %s\n' "$n" "$toplam" "$ulke" "${sehir_adi}"
      wget -q "https://namazvakitleri.diyanet.gov.tr/tr-TR/home/GetRegList?ChangeType=state&StateId=${sehir_kodu}&Culture=tr-TR"  -O - |\
        jq '.StateRegionList[] | (.IlceAdiEn,.IlceID)' | sed -e 's:\"::g' -e 's/[[:space:]]*$//' | paste -d, - - > "ulkeler/${ulke}_ilceler/${sehir_adi}"
        [[ $(wc -l < "ulkeler/${ulke}_ilceler/${sehir_adi}") == 0 ]] && echo "---> ${ulke}_ilceler/${sehir_adi} hatalı inmiş."
      sleep 0.6
      ((n++))
    done < "ulkeler/$ulke"
done
