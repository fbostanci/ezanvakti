#!/bin/bash
#
# ezanvakti uygulamasının kullanıcı dizinine kurulumunu yapar.
# ezanvakti uygulamasının kurulu olma ve bu kurulumla çakışma durumuna
# karşı farklı bir adla kurulum yapar. Kurulu olmadığından eminseniz AD değerini
# ezanvakti yapabilirsiniz.
#
# Bu betiği kaynak kod dizini içerisinde çalıştırın.

[[ $(id -u) == 0 ]] && {
  printf '%s: root haklarıyla çalıştırılamaz.\n' "${0##*/}" >&2
  exit 1
}

AD=ezanvakti
bindir=$HOME/bin

case $1 in
  --kur) eylem=install ;;
  --kald[iı]r) eylem=uninstall ;;
    *)
echo  "\
  Kullanım:
     --kur
        Yerel kurulum yapar.

     --kaldır
        Yerel kurulumu kaldırır.
" >&2
exit 1 ;;
esac

[[ $1 = --kur ]] && {
  BAG=('bash' 'sed' 'gawk' 'grep' 'make' 'notify-send' 'yad' 'mplayer')
  PL_BAG=('WWW::Mechanize')

  for b in ${BAG[@]}
  do
    hash $b 2>/dev/null || KUR_BUNU+=("$b")
  done

  # Perl bileşenlerini denetle.
  for pm in ${PL_BAG[@]}
  do
      perl -M${pm} -e 1 2>/dev/null
      dn=$(echo $?)

      if [[ $dn -ne 0 ]]
      then
          KUR_BUNU+=("$pm")
      fi
  done

  (( ${#KUR_BUNU[@]} )) && {
    e=0
    printf '%s\n' \
      'Aşağıdaki bağımlılıklar bulunamadı.' >&2

    for pm in ${KUR_BUNU[@]}
    do
        printf '%s\n' \
          " -> ${KUR_BUNU[$e]}"
        ((e++))
    done
    exit 1
  }
}

make clean
make PREFIX=$HOME \
     bindir=${bindir} \
     icondir=$HOME/.local/share/icons/hicolor \
     appdeskdir=$HOME/.local/share/applications \
     AD=${AD} ${eylem}

gtk-update-icon-cache -f -t $HOME/.local/share/icons/hicolor
xdg-desktop-menu forceupdate

make clean
[[ $1 = --kur ]] && {
  [[ -z $(grep -o ${bindir} <<<$PATH) ]] && \
    echo -e "\n\n${bindir} PATH üzerinde değil."
}
