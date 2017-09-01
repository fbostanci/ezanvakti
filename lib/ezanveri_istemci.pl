#!/usr/bin/perl
#
#                          Ezanveri İstemci 2.2
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

#my $ulke = 2;
#my $sehir = 563;
#my $ilce = 9786;
my $ulke = $ARGV[0];
my $sehir = $ARGV[1];
my $ilce = $ARGV[2];
my $baglanti;
my $period;
my $sonuc;
my $rsonuc;
my $ksonuc;
my $bos = 0;
my $oge = 1;

if (defined $ARGV[3]) { # bayram namazı
  $baglanti = "http://www.diyanet.gov.tr/tr/PrayerTime/HolidayPrayerTimes";
  $period = '';
}else{ # ezan vakitleri
  $baglanti = "http://www.diyanet.gov.tr/tr/PrayerTime/WorldPrayerTimes";
  $period = 'Aylik';
}

my $mech = WWW::Mechanize->new();
$mech->agent_alias( 'Linux Mozilla' );
$mech->get($baglanti);

$mech->submit_form(
  form_number => 2,
  fields => {
    Country => $ulke,
    State   => $sehir,
    City    => $ilce,
    period  => $period
  },
);

$sonuc = $mech->content();
my @vakitler;
while ($sonuc =~/<td.*?>(.*?)<\/td>/g) {
  push @vakitler, $1;
}

if (!defined $ARGV[3]) {
  foreach my $v (@vakitler) {
      if ($bos and length $v > 5) {
          print "\n";
      }
      if ($oge%8 == 0) {
        print $v;
      } else {
        print $v, "  ";
      }
      $bos = 1;
      $oge++;
  }
}else{
  $vakitler[0] =~ m/(.*)\:\s+(.*)$/;
  $rsonuc = $2;
  $vakitler[1] =~ m/(.*)\:\s+(.*)$/;
  $ksonuc = $2;
  print "ramazan_namaz_vakti=",$rsonuc,"\n";
  print "kurban_namaz_vakti=",$ksonuc;
}
print "\n";
