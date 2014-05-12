#!/usr/bin/perl
#
#                          Ezanveri İstemci 2.0
#
##
##          Copyright (c) 2010-2013 Fatih Bostancı  <faopera@gmail.com>
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
use utf8;
use WWW::Mechanize;

my $ulke = $ARGV[0];
my $sehir = $ARGV[1];
my $ilce = $ARGV[2];

my $baglanti = "http://www.diyanet.gov.tr/tr/PrayerTime/WorldPrayerTimes";
my $sonuc;


my $mech = WWW::Mechanize->new(autocheck => 1, cookie_jar => {}, agent_alias => "Linux Mozilla");
$mech->get($baglanti);

$mech->form_number('2');
$mech->field(Country => $ulke);
$mech->field(City => $sehir);
$mech->field(District => $ilce);
$mech->set_visible( [ radio => 'AYLIK' ] );
$mech->submit();


# $mech->submit_form(
	# form_number => 2,
	# fields => {
		# Country => $ulke,
		# City => $sehir,
		# District => $ilce,
	# },
# );

$sonuc = $mech->content( format => 'text');
print $sonuc;