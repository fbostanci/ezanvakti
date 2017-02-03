Son Güncelleme:  Fri, 03 Feb 2017 10:01:24 +0300

<br>

Ezanvakti 6.0 GNU/Linux için ezan vakti bildirici
====

<br>

HAKKINDA
==
Ezanvakti  T.C. Diyanet İşleri Başkanlığı sitesinden bulunduğunuz ülke
ve şehir için aylık bazda ezan vakitleri çizelgesini alarak vakti
geldiğinde ezan okuyan ve bildirim veren bir uygulamadır.

Ayrıca ayet gösterimi, ezan ve kuran dinletimi, ezan okunurken oynatıcı
duraklatma gibi birçok gelişmiş özelliğe sahiptir. Kullandığı dosyaları ve
ayarları yapılandırma dosyasından okuduğundan kullanıcıya geniş
özelleştirme desteği sunar.

[Ekran görüntüleri için tıklayınız.](https://gitlab.com/ironic/ezanvakti/wikis/ekran-goruntuleri)

<br><br>

BAĞIMLILIKLAR
==
*    bash
*    sed
*    gawk
*    grep
*    libnotify
*    mplayer
*    perl-www-mechanize
*    perl-html-tree

<br>

**EK ÖZELLİKLERİN KULLANIMI  İÇİN GEREKLİ (kullanmak isteniyorsa) BAĞIMLILIKLAR**

*  bash-completion  (Bash tamamlama desteği)
*  yad   (Arayüz desteği)

<br><br>

KURULUM ve KALDIRMA
===
**Archlinux için kurulum:**

PKGBUILD dosyasının bulunduğu dizinde `makepkg -si` komutunu girin.

<br>

**Ubuntu için Launchpad PPA üzerinden kurulum:**

`sudo add-apt-repository ppa:fbostanci/distroguide`

`sudo apt-get update`

`sudo apt-get install ezanvakti`

<br>

**Diğer dağitimlar için kurulum:**

`sudo make PREFIX=/usr sysconfdir=/etc install`

komutunu verin. Eğer paketleme yapıyorsanız, DESTDIR ile paket kurulum dizinini girin.

<br>

**kaldırma için:**

`sudo make PREFIX=/usr sysconfdir=/etc uninstall`

komutunu girin.

<br><br>

KULLANIM ve YAPILANDIRMA
==
Uygulamanın kullanımı ve yapılandırma ayarları için man dosyasına bakın.

<br>

Kullanım için:
 `man ezanvakti`

Yapılandırma bilgileri için:
`man 5 ezanvakti-ayarlar`

<br><br>

LİSANS
==

Ezanvakti GPL 3 ile lisanslanmıştır. Ayrıntılar için COPYING dosyasına bakın.

Kullanılan ezan ses dosyaları İsmail COŞAR'a aittir.
