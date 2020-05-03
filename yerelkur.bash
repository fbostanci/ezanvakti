#!/bin/bash
#
# ezanvakti uygulamasının kullanıcı dizinine($HOME) kurulumunu yapar.
#
# ezanvakti uygulamasının kurulu olma ve bu kurulumla çakışma durumuna
# karşı farklı bir adla kurulum yapar. 
# Kurulu olmadığından eminseniz AD değerini ezanvakti yapabilirsiniz.
#
# Bu betiği kaynak kod dizini içerisinde çalıştırın.
#
# Örnek kurulum komutları:
# export AD=ezanvakti-yerel
# bash yerelkur.bash --kur
#
# Örnek kaldırma komutları:
# ezanvakti-yerel adıyla kurulu ise
# export AD=ezanvakti-yerel
# bash yerelkur.bash --kaldir
#
# AD belirlenmemişse ezv-devel olarak kurar ve
# kaldırırken de ezv-devel'i arar.
#
AD=${AD:-ezv-devel}
bindir=$HOME/.local/bin

[[ $(id -u) == 0 ]] && {
  printf '%s: root haklarıyla çalıştırılamaz.\n' "${0##*/}" >&2
  exit 1
}


case $1 in
  --kur|--install) eylem=install ;;
  --kald[iı]r|--uninstall|--remove) eylem=uninstall ;;
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

[[ ${eylem} = install ]] && {
  BAG=('bash' 'sed' 'gawk' 'grep' 'make' 'notify-send' 'yad' 'mplayer|ffmpeg' 'wget|curl')


  for b in ${BAG[@]}
  do
    if [[ $b =~ '|' ]]
    then
        b1=$(cut -d'|' -f1 <<<$b)
        b2=$(cut -d'|' -f2 <<<$b)

        if ! hash $b1 2>/dev/null
        then
            if ! hash $b2 2>/dev/null
            then
                KUR_BUNU+=("$b1 ya da $b2")
            fi
        fi
    else
        hash $b 2>/dev/null || KUR_BUNU+=("$b")
    fi
  done

  (( ${#KUR_BUNU[@]} )) && {
    e=0
    printf '%s\n' \
      'Aşağıdaki bağımlılıklar bulunamadı.' >&2

    for pm in "${KUR_BUNU[@]}"
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
[[ ${eylem} = install ]] && {
  [[ -z $(grep -o ${bindir} <<<$PATH) ]] && \
    echo -e "\n\n${bindir} PATH üzerinde değil."
}
