Son Güncelleme:  Sat, 27 Jul 2024 15:10:40 +0300


[![GitHub release](https://img.shields.io/github/release/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![GitHub tag](https://img.shields.io/github/tag/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![license](https://img.shields.io/github/license/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti)
[![GitHub issues](https://img.shields.io/github/issues/fbostanci/ezanvakti.svg?style=plastic)](https://github.com/fbostanci/ezanvakti/issues)
<br>
[![Packaging status](https://repology.org/badge/vertical-allrepos/ezanvakti.svg)](https://repology.org/project/ezanvakti/versions)
<br>

Ezanvakti 7.6 GNU/Linux için ezan vakti bildirici
====
<br>

|***YAD Arayüz 1***| ***YAD Arayüz 2***|***YAD Arayüz 3***|
| :-------: | :-------: | :-------: |
|![yad_gui](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/44585586f8d1317828b4b10f09fcb2b3/yad_gui.png)|![yadgui2](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/557430b983641e1895160260f53c6758/yadgui2.png)|![yadgui3](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/f37a963b93389af3a4849c7c9ee42b7e/yad_gui6.png)|

| ***Qt Arayüz*** |***Uçbirim Arayüz***|
| :-------: | :-------: |
|![ezanvakti-qt-gui](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/66e4feb3627375e1d2c49918808c0504/ezanvakti-qt-gui-1.png)|![tui](https://gitlab.com/fbostanci/ezanvakti/-/wikis/uploads/4930b67127a41e47f80553eebe206552/tui.png)|

<br>

HAKKINDA
==

Ezanvakti, T.C. Diyanet İşleri Başkanlığı sitesinden bulunduğunuz ülke
ve şehir için aylık bazda ezan vakitleri çizelgesini alarak vakti
geldiğinde ezan okuyan ve bildirim veren bir uygulamadır.

Kullandığı dosyaları ve ayarları yapılandırma dosyasından
okuduğundan kullanıcıya geniş özelleştirme desteği sunar.

Genel Özellikleri
=
*  Diyanet sitesindeki tüm ülke ve şehirler için yıllık vakitleri alma.
*  Otomatik ezan vakitleri güncelleme.
*  Ezan vakitlerini ve vakitlere ne kadar süre kaldığını
   toplu/tekil gösterme. (--vakitler)
*  Vakitlerde ezan okunma/okunmama seçimi.
*  Kullanıcının eklediği radyo ve tv yayınlarını oynatabilme. (--ortam --tv/--radyo)
*  İftar vaktine ne kadar süre kaldığını gösterme. (--iftar)
*  İmsak vaktine ne kadar süre kaldığını gösterme. (--imsak)
*  Nafile namaz vakitleri hesaplama. (-vn)
*  Sıradaki vakit, ve vakte ne kadar süre kaldığını gösterme. (-vt)
*  Arayüzden ve uçbirimden kerahat vakitlerini gösterebilme. (-vk)
*  Bulunduğunuz konum için bayram namazı vakitlerini gösterme. (-vm)
*  Qt arayüz desteği [Gitlab](https://gitlab.com/fbostanci/ezanvakti-qt-gui) [Github](https://github.com/fbostanci/ezanvakti-qt-gui)
*  Arayüzde hicri tarih gösterimi
*  Arayüz HTML renk özelleştirmeleri
*  Cuma günü isteğe bağlı sela okunması (süre ayarlı)
*  Sistem açılışında 3 farklı kip<br>
   <pre>
    1: beş vakit (öntanımlı kip)
    2: ramazan (yalnızca iftar ve imsak vakitlerinde ezan okunur.)
    0: kapalı (arkada çalışmaz.)</pre>
*  Her vakit için farklı makamda ezan ve ezan duası.
*  Vakit ezanı okunurken desteklenen müzik oynatıcıyı ezan bitimine kadar duraklatma.<br>
   <pre>Desteklenen oynatıcılar: Spotify, Deadbeef, Clementine, Amarok, Rhythmbox,
                            Aqualung, Audacious, Banshee, Exaile, Cmus,
                            Moc, Qmmp, Juk</pre>
*  3 farklı okuyucu seçimli Kuran dinletme. (--kuran <seçenek>)<br>
   Seçenekler:<br>
   <pre>
   seçim: (-s sure_no)
   rastgele: (-r)
   hatim: (-h)
   günlük: (-g)</pre>
*  61 tane okuyucu seçimli özel kuran dinletimi (--kuran --arayuz)
*  Sureleri; sure adı, ayet sayısı, sure numarası, cüz no ve indiği yer şeklinde listeleme. (--sureler)
*  İstenen surenin istenen ayet aralığını gösterme. (--aralik)
*  Cuma hutbesi görüntüleme. (--hutbe)
*  40 hadisten rastgele bir hadisi uçbirimden ya da bildirim baloncuğunda gösterme. (--hadis)
*  Esma-ül Hüsna'dan rastgele bir adı  uçbirimde gösterme. (--esma)
*  Diyanet sitesinden alınmış soru-yanıtlardan rastgele birini  uçbirimden
   ya da bildirim baloncuğunda gösterme. (--bilgi)
*  İçinde bulunulan yıla ait dini günleri ve geceleri listeleme. (--gunler)
*  Dini günler ve geceler için bir gün önceden bildirim verme.
*  Aylık ya da haftalık vakitleri listeleme. (-v7, -v30)
*  Conky uygulamasında kullanım için özel çıktılar. (--conky)
*  Başlatıcı sağ tık seçke desteği (unity/desktop actions özelliği)
*  Geniş özelleştirme desteği.
*  Basit seviye arayüz(yad) desteği.

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
*    hicolor-icon-theme
*    ffmpeg ya da mplayer
*    wget ya da curl

<br>

**EK ÖZELLİKLERİN KULLANIMI  İÇİN GEREKLİ (kullanmak isteniyorsa) BAĞIMLILIKLAR**

*  bash-completion  (Bash tamamlama desteği)
*  yad >=9.0  (Arayüz desteği)

<br><br>

KURULUM ve KALDIRMA
===
<br>

**Archlinux için kurulum:**

[AUR](https://aur.archlinux.org/packages/ezanvakti/) üzerinde uygulama bulunmaktadır.
AUR yardımcı uygulamanızla güncel sürümü kurabilirsiniz.

ör: Trizen kullanıyorsanız:

`trizen -Sa ezanvakti`

Qt arayüzü kullanmak için:

`trizen -Sa ezanvakti-qt-gui`

Git (geliştirme) sürümünü kullanmak için:

`trizen -Sa ezanvakti-git`

<br>

**Ubuntu için Launchpad PPA üzerinden kurulum:**

Depo Ubuntu 24.04 içindir.

`sudo add-apt-repository ppa:fbostanci/distroguide`

`sudo apt update`

`sudo apt install ezanvakti`

Qt arayüzü kullanmak için:

`sudo apt install ezanvakti-qt-gui`

<br>

**Diğer dağıtımlar için (kaynak koddan) kurulum:**

`sudo make PREFIX=/usr sysconfdir=/etc install`

komutunu verin. Eğer paketleme yapıyorsanız, DESTDIR ile paket kurulum dizinini girin.

<br>

**kaldırma için:**

`sudo make PREFIX=/usr sysconfdir=/etc uninstall`

komutunu girin.

<br>

**Kullanıcı ($HOME) dizinine kurulum:**

Uçbirimde kaynak kod dizini içerisindeyken

`export AD=ezanvakti`

`bash yerelkur.bash --kur`

komutunu verin. AD girmezseniz ezv adıyla kuracaktır.

İsterseniz farklı bir AD girebilirsiniz.
Girdiğiniz AD değerini kaldırma işleminde de belirtmeniz gerekmektedir.

<br>

**kaldırma için:**

`export AD=ezanvakti`

`bash yerelkur.bash --kaldir`

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

Man dosyalarını pdf olarak indirmek için [wiki sayfasına](https://gitlab.com/fbostanci/ezanvakti/-/wikis/home) bakabilirsiniz.

<br><br>

LİSANS
==

Ezanvakti GPL 3 ile lisanslanmıştır. Ayrıntılar için COPYING dosyasına bakın.

Kullanılan ezan ses dosyaları İsmail COŞAR'a aittir.
