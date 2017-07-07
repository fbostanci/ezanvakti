#!/usr/bin/perl
#
#                          Ezanveri İstemci 2.0
#
##
##          Copyright (c) 2010-2017 Fatih Bostancı  <faopera@gmail.com>
##
##                   https://gitlab.com/fbostanci/ezanvakti
##
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

my $ulke = $ARGV[0];
my $sehir = $ARGV[1];
my $ilce = $ARGV[2];

my $baglanti = "http://www.diyanet.gov.tr/tr/PrayerTime/WorldPrayerTimes";
my $sonuc;

my $mech = WWW::Mechanize->new(autocheck => 1, cookie_jar => {}, agent_alias => "Linux Mozilla");
$mech->get($baglanti);

# $mech->form_number('2');
# $mech->field(Country => $ulke);
# $mech->field(State => $sehir);
# $mech->field(City => $ilce);
# $mech->set_visible( [ radio => 'AYLIK' ] );
# $mech->submit();

$mech->submit_form(
	form_number => 2,
	fields => {
		Country => $ulke,
		State   => $sehir,
		City    => $ilce,
		period  => 'Aylik'
	},
);

$sonuc = $mech->content();
print $sonuc;
