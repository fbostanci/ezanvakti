# Maintainer: Fatih Bostancı <faopera@gmail.com>

pkgname=ezanvakti
pkgver=20170131
pkgrel=1
pkgdesc="Prayer Times script for Turkish users"
arch=('any')
url="https://gitlab.com/ironic/ezanvakti"
license=('GPL3')
makedepends=('git')
depends=('bash' 'sed' 'gawk' 'grep' 'libnotify' 'mplayer' 'perl-www-mechanize' 'yad')
optdepends=('bash-completion: bash tamamlama destegi')
source=('git+https://gitlab.com/ironic/ezanvakti.git')
md5sums=('SKIP')

pkgver() {
  cd "$pkgname"
  cat VERSION
}

package() {
  cd "$pkgname"
  make PREFIX=/usr sysconfdir=/etc DESTDIR="${pkgdir}" install
}

# vim:set ts=2 sw=2 et:
