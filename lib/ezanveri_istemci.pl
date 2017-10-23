#!/usr/bin/perl
#
#                          Ezanveri İstemci 2.3
#
##
##       Copyright (c) 2010-2017 Fatih Bostancı <fbostanci@vivaldi.net>
##
##                https://gitlab.com/fbostanci/ezanvakti
##                https://github.com/fbostanci/ezanvakti
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see http://www.gnu.org/licenses/.
#
#
use strict;
use warnings;
use open ':std', ':encoding(UTF-8)';
use WWW::Mechanize;

# my $ulke = 2;
# my $sehir = 563;
# my $ilce = 9786;
my $ulke = $ARGV[0];
my $sehir = $ARGV[1];
my $ilce = $ARGV[2];
my $baglanti;
my $sonuc;
my $rsonuc;
my $ksonuc;
my $bos = 0;
my $oge = 1;
my @vakitler;

if (!defined $ARGV[3]) { # ezan vakitleri
  $baglanti = "http://namazvakitleri.diyanet.gov.tr/tr-TR";
} else { # bayram namazı - ADRES ÇALIŞMIYOR.
  $baglanti = "http://www.diyanet.gov.tr/tr/PrayerTime/HolidayPrayerTimes";
}

my $mech = WWW::Mechanize->new();
$mech->agent_alias( 'Linux Mozilla' );
$mech->get($baglanti);

$mech->submit_form(
  form_number => 1,
  fields => {
    ulkeId  => $ulke,
    ilId    => $sehir,
    ilceId  => $ilce,
  },
);
$sonuc = $mech->content();

while ($sonuc =~/<td class="text-center">(.*?)<\/td>/g) {
  push @vakitler, $1;
}

if (!defined $ARGV[3]) {
  shift @vakitler for ( 1..6 );
  foreach my $v (@vakitler) {
      $v =~s/<.+?>//g;
      if ($bos and length $v > 5) {
          print "\n";
      }
      if ($oge%7 == 0) {
        print $v;
      } else {
        print $v, "  ";
      }
      $bos = 1;
      $oge++;
  }
} else {
  $vakitler[0] =~ m/(.*)\:\s+(.*)$/;
  $rsonuc = $2;
  $vakitler[1] =~ m/(.*)\:\s+(.*)$/;
  $ksonuc = $2;
  print "ramazan_namaz_vakti=",$rsonuc,"\n";
  print "kurban_namaz_vakti=",$ksonuc;
}
print "\n";
