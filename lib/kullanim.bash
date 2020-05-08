#!/bin/bash
#
#
#
#

betik_kullanimi() {
  local  B R

  B=$(tput bold)
  R=$(tput sgr0)

  (( ! ${RENK:-RENK_KULLAN} )) && {
    B=''
    R=''
  }

  ucbirim_basligi "yardim"
  echo -e "
    ${B}-v, --vakitler${R}
        Toplu olarak günlük ezan vakitlerini görüntüler.

        [-s,-o,-i,-a,-y]
            Sadece bir vakit için görüntüleme yapar.

        [7,30]
            7/30 günlük vakitleri görüntüler.

        [--siradaki]
            Sıradaki vakit ve vakte kalan süreyi görüntüler.

        [--kerahat]
            Kerahat vakitlerini görüntüler.

        [--bildirim]
            Vakitler,kerahat ve sıradaki çıktılarını uçbirim yerine
            bildirim baloncuğuna yönlendirir.

    ${B}--kuran${R} [-s <sure_no>, -r, -g, -h]
        Çevrimiçi olarak ya da yerel dizinden Kuran dinletir.

    ${B}--dinle${R} [-s,-o,-i,-a,-y,-c]
        Girilen vakte ait ezanı dinletir.

    ${B}--sureler${R}
        Sure bilgilerini listeler.

    ${B}--ayet${R}
        Rastgele bir Kuran ayeti seçerek Türkçe anlamını
        gösterir.

    ${B}--aralik${R} [<sure_no> <ayet_aralığı> ]
        İstenen surenin, istenen ayetleri arasını gösterir.

    ${B}--kalan${R}
        Uçbirimde sıradaki vakte ne kadar süre kaldığını
        özyinelemeli olarak gösterir.

    ${B}--config${R}
        Ayarlar dosyasını EDITOR olarak tanımlı uygulamayla
        açar. EDITOR tanımlı değilse nano ile açar.

    ${B}--hadis${R}
        40 hadisten rastgele bir hadis seçerek gösterir.

    ${B}--bilgi${R}
        Diyanetin sitesinden alınan 'Bunları biliyor musunuz?'
        kısmından bir soru ve sorunun yanıtını gösterir.

    ${B}--esma${R}
        Esma-ül Hüsna dan rastgele bir seçim gösterir.

    ${B}--guncelle${R}
        Ezanveri dosyasını 30 günlük vakitleri içerecek
        şekilde günceller/oluşturur.

    ${B}--iftar${R}
        İftar vaktine ne kadar süre kaldığını görüntüler.

    ${B}--imsak${R}
        İmsak vaktine ne kadar süre kaldığını görüntüler.

    ${B}--conky${R} [-s, -i, -k, -m]
        Conky alanında günlük ezan vakitlerini eklemek
        isteyenler için renksiz ve kısa çıktı verir.

    ${B}--gunler${R}
        İçinde bulunulan yıla ait dini günleri ve geceleri gösterir.

    ${B}--arayuz${R}
        Gelişmiş arayüz penceresini başlatır.

    ${B}--arayuz2${R}
        Arayüzün anlık güncellendiği arayüz2 penceresini başlatır.

    ${B}--arayuz3${R}
        Basit arayüz penceresini başlatır.

   ${B}--listele${R}
        Uygulamanın kullandığı dosya ve diznleri listeler.

    ${B}-V, --surum, --version${R}
        Uygulamanın sürüm numarasını gösterir ve çıkar.

    ${B}-h, --help, --yardim, --yardım${R}
        Bu yardım sayfasını görüntüler ve çıkar.


  Çıkmak için 'q' tuşuna basınız."  | less -R
}

# vim: set ft=sh ts=2 sw=2 et:
