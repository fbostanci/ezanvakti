#!/bin/bash
#
#
#
#

function betik_kullanimi() {
  local  B R

  B=$(tput bold)
  R=$(tput sgr0)

  (( ! ${RENK:-RENK_KULLAN} )) && {
    B=''
    R=''
  }

  ucbirim_basligi "yardim"
  echo -e "
    ${B}--dinle${R} [-s,-o,-i,-a,-y, -c]
        İstediğiniz zaman, istediğiniz vakite ait ezanı dinletir.

    ${B}-v, --vakitler${R}
        Toplu olarak günlük ezan vakitlerini görüntüler.

        [-s,-o,-i,-a,-y]
            Sadece bir vakit için görüntüleme yapar.

        [7,30]
            7/30 günlük vakitleri görüntüler.

        [--bildirim]
            Vakit çıktılarını uçbirim yerine bildirim baloncuğuna yönlendirir.

    ${B}--kuran${R} [-s <sure_kodu>, -r, -g, -h]
        Çevrimiçi olarak ya da yerel dizinden Kuran dinletir.

    ${B}--sureler${R}
        Sureleri dinlemek için gerekli olan kod numaralarını
        ve sure adlarını görüntüler.

    ${B}--ayet${R}
        Rastgele bir Kuran ayeti seçerek Türkçe anlamını
        bildirim baloncuğunda gösterir.

    ${B}--aralik${R} [<sure_kodu> <ayet_aralığı> ]
        İstenen surenin, istenen ayetleri arasını gösterir.
        ayet aralığı; <ayet_başlangıc_no-ayet_bitis_no>
        şeklinde olmalıdır.

    ${B}--kalan${R}
        Uçbirimde sıradaki vakte ne kadar süre kaldığını
        özyinelemeli olarak gösterir.

    ${B}--config${R}
        Ayarlar dosyasını EDITOR olarak tanımlı uygulamayla
        açar. EDITOR tanımlı değilse nano ile açar.

    ${B}--hadis${R}
        40 hadisten rastgele bir hadis seçerek bildirim
        baloncuğunda gösterir.

    ${B}--bilgi${R}
        Diyanetin sitesinden alınan 'Bunları biliyor musunuz?'
        kısmından bir soru ve sorunun yanıtını bildirim
        baloncuğunda gösterir.

    ${B}--esma${R}
        Esma-ül Hüsna dan Allah ın bir adını gösterir.

    ${B}--guncelle${R}
        Ezanveri dosyasını 30 günlük vakitleri içerecek
        şekilde günceller/oluşturur.

    ${B}--iftar${R}
        İftar vaktine ne kadar süre kaldığını görüntüler.

    ${B}--conky${R} [-s, -i, -k]
        Conky alanında günlük ezan vakitlerini eklemek
        isteyenler için renksiz ve kısa çıktı verir.

    ${B}--gunler${R}
        İçinde bulunulan yıla ait dini günleri ve geceleri gösterir.

    ${B}--arayuz${R}
        Gelişmiş arayüz penceresini başlatır.

    ${B}--arayuz2${R}
        Basit arayüz penceresini başlatır.

    ${B}-V, --surum, --version${R}
        Betiğin sürüm numarasını gösterir ve çıkar.

    ${B}-h, --help, --yardim, --yardım${R}
        Bu yardım sayfasını görüntüler ve çıkar.


  Çıkmak için 'q' tuşuna basınız."  | less -R
}
