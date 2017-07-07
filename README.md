Son Güncelleme:  Fri, 07 Jul 2017 12:51:49 +0300

<br>

Ezanvakti 6.2 GNU/Linux için ezan vakti bildirici
====

<br>

HAKKINDA
==

Ezanvakti  T.C. Diyanet İşleri Başkanlığı sitesinden bulunduğunuz ülke
ve şehir için aylık bazda ezan vakitleri çizelgesini alarak vakti
geldiğinde ezan okuyan ve bildirim veren bir uygulamadır.

Kullandığı dosyaları ve ayarları yapılandırma dosyasından
okuduğundan kullanıcıya geniş özelleştirme desteği sunar.

Genel Özellikleri
=
*  Diyanet sitesindeki tüm ülke ve şehirler için aylık vakitleri alma.
*  Otomatik ezan vakitleri güncelleme.
*  Ezan vakitlerini ve vakitlere ne kadar süre kaldığını toplu/tekil gösterme.
*  İftar vaktine ne kadar süre kaldığını gösterme.
*  Sıradaki vakit, ve vakte ne kadar süre kaldığını gösterme.
*  Kerahat vakitlerini gösterme.
*  Her vakit için farklı makamda ezan ve ezan duası.
*  Vakit ezanı okunurken desteklenen müzik oynatıcıyı ezan bitimine kadar duraklatma
*  3 farklı okuyucu seçimli kuran dinletme.
*  İstenen surenin istenen ayet aralığını gösterme.
*  40 hadisten rastgele bir hadisi uçbirimden ya da bildirim baloncuğunda gösterme.
*  Esma-ül Hüsna'dan rastgele bir adı  uçbirimden ya da bildirim baloncuğunda gösterme.
*  Diyanet sitesinden alınmış soru- yanıtlardan rastgele birini  uçbirimden ya da bildirim baloncuğunda gösterme.
*  İçinde bulunulan yıla ait dini günleri ve geceleri listeleme.
*  Aylık ya da haftalık vakitleri listeleme.
*  Conky uygulamasında kullanım için özel çıktı.
*  Sıradaki ezan vaktini (süre ayarlı) ve dini günleri anımsatma.
*  Geniş özelleştirme desteği.
*  Basit seviye arayüz desteği.

[Ekran görüntüleri için tıklayınız.](https://gitlab.com/fbostanci/ezanvakti/wikis/ekran-goruntuleri)
=

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

<br>

**EK ÖZELLİKLERİN KULLANIMI  İÇİN GEREKLİ (kullanmak isteniyorsa) BAĞIMLILIKLAR**

*  bash-completion  (Bash tamamlama desteği)
*  yad   (Arayüz desteği)

<br><br>

KURULUM ve KALDIRMA
===
**Archlinux için kurulum:**

[AUR](https://aur.archlinux.org/) üzerinde uygulama bulunmaktadır.
AUR yardımcı uygulamanızla güncel sürümü kurabilirsiniz.

ör: Yaourt kullanıyorsanız:
`yaourt -S ezanvakti`

Kaynak kod üzerinden kurulum için
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
