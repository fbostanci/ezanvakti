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
bindir="$HOME/.local/bin"

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
    KUR_BUNU=("${KUR_BUNU[@]/notify-send/libnotify}")
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
make PREFIX="$HOME/.local" bindir="${bindir}" AD=${AD} ${eylem}

gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor"
xdg-desktop-menu forceupdate

make clean
[[ ${eylem} = install ]] && {
  [[ :$PATH: == *:${bindir}:* ]] || \
    echo -e "\n\n\033[0;1m${bindir}\033[1;33m PATH üzerinde değil.\033[0m"
}
