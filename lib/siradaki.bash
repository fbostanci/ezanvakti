



function siradaki_vakit() { # {{{
  denetle; bugun
  renk_denetle

  local istek="$1"
  local siradaki_vakit siradaki_vakit_kalan

  [[ ${istek} = conky_siradaki ]] && RENK2=''

  if (( UNIXSAAT < sabah ))
  then
    bekleme_suresi $sabah_n; kalan
    siradaki_vakit="Sabah"
    siradaki_vakit_kalan="${RENK2} $kalan_sure"

  elif (( UNIXSAAT < ogle ))
  then
    bekleme_suresi $ogle_n; kalan
    siradaki_vakit="Öğle"
    siradaki_vakit_kalan="${RENK2} $kalan_sure"

  elif (( UNIXSAAT < ikindi ))
  then
    bekleme_suresi $ikindi_n; kalan
    siradaki_vakit="İkindi"
    siradaki_vakit_kalan="${RENK2} $kalan_sure"

  elif (( UNIXSAAT < aksam ))
  then
    bekleme_suresi $aksam_n; kalan
    siradaki_vakit="Akşam"
    siradaki_vakit_kalan="${RENK2} $kalan_sure"

  elif (( UNIXSAAT < yatsi ))
  then
    bekleme_suresi $yatsi_n; kalan
    siradaki_vakit="Yatsı"
    siradaki_vakit_kalan="${RENK2} $kalan_sure"

  elif  (( UNIXSAAT < yeni_gun ))
  then
    bekleme_suresi bekleme_suresi "23:59:59"; kalan
    siradaki_vakit="Yeni gün"
    siradaki_vakit_kalan="${RENK2} $kalan_sure"
  fi

  case $istek in
    siradaki)
      printf "${RENK7}${RENK3}\n${siradaki_vakit} ezanı  ${RENK3}: $siradaki_vakit_kalan${RENK0}\n\n" ;;
    conky_siradaki)
      printf "${siradaki_vakit} : $siradaki_vakit_kalan\n"  |
        sed 's:saat:sa:;s:dakika:dk:;s:saniye:sn:' ;;
  esac
}
