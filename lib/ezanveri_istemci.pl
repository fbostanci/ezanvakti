#!/usr/bin/perl
#
#                          Ezanveri İstemci 1.5
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

use strict;
use warnings;
use encoding "utf-8";
use WWW::Mechanize;

my $ulke = $ARGV[0];
my $sehir = $ARGV[1];
my $ilce = $ARGV[2];

my $baglanti = "http://www.diyanet.gov.tr/turkish/namazvakti/vakithes_namazvakti.asp";
my $cizelge1 = "benimformum";
my $cizelge2 = "hesapformu";
my $sonuc;


my $mech = WWW::Mechanize->new();
$mech->agent_alias( 'Linux Mozilla' );

$mech->get($baglanti);
$mech->form_name($cizelge1);

$mech->field(ulkeler => $ulke);
$mech->submit('document.benimformum.submit');

$mech->form_name($cizelge2);

$mech->field(eyalet => $sehir);
$mech->field(sehirler => $ilce);

$mech->set_visible( [ radio => 'AYLIK' ] );
$mech->click_button(value => 'Hesapla');

$sonuc = $mech->content( format => 'text');
print $sonuc;