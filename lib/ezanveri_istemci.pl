#!/usr/bin/perl
#
#                          Ezanveri İstemci 2.7
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
use HTML::Entities;

# my $ulke = 2;
# my $sehir = 563;
# my $ilce = 9786;
my $ulke = $ARGV[0];
my $sehir = $ARGV[1];
my $ilce = $ARGV[2];

my $sonuc;
my $rsonuc;
my $ksonuc;
my $rtarih;
my $ktarih;
my $bos = 0;
my $oge = 1;
my @vakitler;
my $baglanti = "http://namazvakitleri.diyanet.gov.tr/tr-TR/$ilce";

my $mech = WWW::Mechanize->new();
$mech->agent_alias( 'Linux Mozilla' );
$mech->get($baglanti);
$sonuc = $mech->content();

if (!defined $ARGV[3]) {
  while ($sonuc =~/<td>(.*?)<\/td>/g) {
    push @vakitler, $1;
  }
  foreach my $v (@vakitler) {
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
  while ($sonuc =~/<span class="bayram-info-value-top">(.*?)<\/span>/g) {
    push @vakitler, $1;
  }
  $rtarih = decode_entities($vakitler[0]);
  $rsonuc = $vakitler[1];
  $ktarih = decode_entities($vakitler[2]);
  $ksonuc = $vakitler[3];

  print "ramazan_bayrami_tarihi=",$rtarih,"\n";
  print "ramazan_namaz_vakti=",$rsonuc,"\n";
  print "kurban_bayrami_tarihi=",$ktarih,"\n";
  print "kurban_namaz_vakti=",$ksonuc;
}
print "\n";
