# Maintainer: Fatih Bostancı <faopera@gmail.com>

pkgbase="ezanvakti-devel"
pkgname=('ezanvakti-devel' 'ezanvakti-ses')
pkgver=20120406
pkgrel=1
pkgdesc="GNU/Linux icin Ezan Vakti Bildirici"
arch=('any')
url="https://gitorious.org/ezanvakti"
makedepends=('git')

_gitroot='git://gitorious.org/ezanvakti/ezanvakti-devel.git'
_gitname='ezanvakti-devel'

_gitroot2='git://gitorious.org/ezanvakti/ezanvakti-ses.git'
_gitname2='ezanvakti-ses'


package_ezanvakti-devel() {
  pkgdesc="GNU/Linux icin Ezan Vakti Bildirici"
  license=('GPL3')
  depends=('bash' 'sed' 'gawk' 'grep' 'libnotify' 'mplayer' 'ezanvakti-ses>=20111229')
  optdepends=('perl-html-tree: Ezanveri güncelleme işlemi için'
              'perl-www-mechanize: Ezanveri güncelleme işlemi için'
              'bash-completion: Bash tamamlama desteği için')
  conflicts=('ezanvakti')

  msg "Gitorious GIT sunucusuna bağlanılıyor..."

  if [ -d "${srcdir}/${_gitname}" ]
  then
       cd ${_gitname} && git pull origin
  else
       git clone "${_gitroot}" && cd ${_gitname}
  fi

 #${EDITOR:-${vim:-vi}} Makefile
  msg "make başlatılıyor..."
  make PREFIX=/usr sysconfdir=/etc DESTDIR="${pkgdir}" install
}


package_ezanvakti-ses() {
  pkgdesc="Ezanvakti uygulaması icin ezan ses dosyalari"
  pkgver="$pkgver"
  pkgrel="$pkgrel"
  url="http://www.ismailcosar.com.tr/"
  license=('unknown')
  depends=()
  optdepends=()
  conflicts=()

  msg "Gitorious GIT sunucusuna bağlanılıyor..."

  if [ -d "${srcdir}/${_gitname2}" ]
  then
       cd ${_gitname2} && git pull origin
  else
       git clone "${_gitroot2}" && cd ${_gitname2}
  fi

  #${EDITOR:-${vim:-vi}} Makefile
  msg "make başlatılıyor..."
  make PREFIX=/usr  DESTDIR="${pkgdir}" install
}

# vim:set ts=2 sw=2 et:
