#!/usr/bin/perl
#
#                          Ezanveri Güncelle 1.3
#
##
##          Copyright (c) 2010-2012 Fatih Bostancı  <faopera@gmail.com>
##
##                   https://gitorious.org/ezanvakti
##
##
##    Bu uygulama bir özgür yazılımdır: yeniden dağıtabilirsiniz ve/veya
##    Özgür Yazılım Vakfı  (FSF) tarafından yayımlanan  (GPL) Genel kamu
##    lisansı sürüm 3  veya daha  yeni bir sürümünde belirtilen şartlara
##    uymak kaydıyla, üzerinde değişiklik yapabilirsiniz.
##
##    Ayrıntılar için COPYING dosyasını okuyun.
#
#


use WWW::Mechanize;

my $ulke = $ARGV[0];
my $sehir = $ARGV[1];

my $mech = WWW::Mechanize->new();
#$mech->agent_alias( 'Linux Mozilla' );

$mech->get('http://www.diyanet.gov.tr/turkish/namazvakti/vakithes_namazvakti.asp');
$mech->form_name(benimformum);

$mech->field(ulkeler => $ulke);
$mech->submit('document.benimformum.submit');

$mech->form_name(hesapformu);
$mech->field(sehirler => $sehir);

$mech->set_visible( [ radio => 'AYLIK' ] );
$mech->click_button(value => 'Hesapla');

$sonuc = $mech->content(format => 'text');
print $sonuc;