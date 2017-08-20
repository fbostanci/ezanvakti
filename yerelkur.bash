#!/bin/bash
#
# ezanvakti uygulamasının kullanıcı dizinine kurulumunu yapar.
# ezanvakti uygulamasının kurulu olma ve bu kurulumla çakışma durumuna
# karşı farklı bir adla kurulum yapar. Kurulu olmadığından eminseniz AD değerini
# ezanvakti yapabilirsiniz.
#
# Bu betiği kaynak kod dizini içerisinde çalıştırın.

AD=ezv-devel
bindir=$HOME/bin

[[ $1 = '--kur' ]] && eylem=install
[[ $1 = --@(kald[iı]r) ]] && eylem=uninstall
[[ -z $1 ]] && {
echo "Kullanım
        --kur
              Yerel kurulum yapar.
        --kaldır
              Yerel kurulumu kaldırır.
" >&2
exit 1
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

[[ -z $(echo $PATH | grep -o ${bindir}) ]] && echo -e "\n\n${bindir} PATH üzerinde değil."
