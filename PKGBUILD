# Maintainer: Fatih Bostancı <faopera@gmail.com>

pkgname=ezanvakti
pkgver=6.2
pkgrel=1
pkgdesc="Islamic Prayer Times bash script for Turkish users"
arch=('any')
url="https://gitlab.com/fbostanci/ezanvakti"
license=('GPL3')
makedepends=()
depends=('bash' 'sed' 'gawk' 'grep' 'libnotify' 'mplayer' 'perl-www-mechanize' 'yad')
optdepends=('bash-completion: bash tamamlama destegi')
source=("https://github.com/fbostanci/ezanvakti/archive/v$pkgver.tar.gz")
md5sums=('b6dfc1cc13b086784cab39148659acdd')

package() {
  cd "$pkgname-$pkgver"
  make PREFIX=/usr sysconfdir=/etc DESTDIR="${pkgdir}" install
}

# vim:set ts=2 sw=2 et:
