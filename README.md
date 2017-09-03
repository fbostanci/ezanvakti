Son Güncelleme:  Fri, 01 Sep 2017 22:03:05 +0300

<p align="center">
<a href="https://github.com/fbostanci/ezanvakti/releases/latest"><img src="https://img.shields.io/github/release/fbostanci/ezanvakti.svg?maxAge=600" alt="Latest release" /></a>
<a href="https://aur.archlinux.org/packages/ezanvakti"><img src="https://img.shields.io/aur/version/ezanvakti.svg?maxAge=600" alt="AUR" /></a>
<a href="https://github.com/fbostanci/ezanvakti/blob/master/COPYING"><img src="https://img.shields.io/badge/license-GPLv3-yellow.svg?maxAge=2592000" alt="License" /></a>
</a>
</p>

<br>

Ezanvakti 6.4 GNU/Linux için ezan vakti bildirici
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
*  Ezan vakitlerini ve vakitlere ne kadar süre kaldığını
   toplu/tekil gösterme. (--vakitler)
*  Vakitlerde ezan okunma/okunmama seçimi.
*  İftar vaktine ne kadar süre kaldığını gösterme. (--iftar)
*  Sıradaki vakit, ve vakte ne kadar süre kaldığını gösterme. (-vt)
*  Arayüzden ve uçbirimden kerahat vakitlerini gösterebilme. (-vk)
*  Bulunduğunuz konum için bayram namazı vakitlerini gösterme. (-vm)
*  Cuma hutbesi indirme ve açma (--hutbe)
*  Arayüzde hicri tarih gösterimi
*  Arayüz HTML renk özelleştirmeleri
*  Cuma günü isteğe bağlı sela okunması (süre ayarlı)
*  Sistem açılışında 3 farklı kip<br>
   <pre>
    1: beş vakit (normal kip)
    2: ramazan (yalnızca iftar ve imsak vakitlerinde ezan  okunur.)
    0: kapalı (arkada çalışmaz.)</pre>
*  Her vakit için farklı makamda ezan ve ezan duası.
*  Vakit ezanı okunurken desteklenen müzik oynatıcıyı ezan bitimine kadar duraklatma.<br>
   <pre>Desteklenen oynatıcılar: Spotify, Deadbeef, Clementine, Amarok, Rhythmbox,
                            Aqualung, Audacious, Banshee, Exaile, Cmus,
                            Moc, Qmmp, Juk</pre>
*  3 farklı okuyucu seçimli Kuran dinletme. (--kuran)<br>
   Ayrıca hatim, rastgele, seçim ya da kullanıcının belirlediği sure dizisini dinletme kipleri
*  Sureleri; sure adı, ayet sayısı, sure numarası, cüz no ve indiği yer şeklinde listeleme. (--sureler)
*  İstenen surenin istenen ayet aralığını gösterme. (--aralik)
*  40 hadisten rastgele bir hadisi uçbirimden ya da bildirim baloncuğunda gösterme. (--hadis)
*  Esma-ül Hüsna'dan rastgele bir adı  uçbirimden ya da bildirim baloncuğunda gösterme. (--esma)
*  Diyanet sitesinden alınmış soru-yanıtlardan rastgele birini  uçbirimden
   ya da bildirim baloncuğunda gösterme. (--bilgi)
*  İçinde bulunulan yıla ait dini günleri ve geceleri listeleme. (--gunler)
*  Dini günler ve geceler için bir gün önceden bildirim verme.
*  Aylık ya da haftalık vakitleri listeleme. (-v7, -v30)
*  Conky uygulamasında kullanım için özel çıktılar. (--conky)
*  Sıradaki ezan vaktini (süre ayarlı) ve dini günleri anımsatma.
*  Sesli vakit anımsatma
*  Başlatıcı sağ tık seçke desteği (unity/desktop actions özelliği)
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

**Diğer dağıtımlar için kurulum:**

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
