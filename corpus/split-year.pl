#!/usr/bin/env perl
# -*- mode: cperl; indent-tabs-mode: nil; tab-width: 3; cperl-indent-level: 3; -*-
use utf8;
use strict;
use warnings;
BEGIN {
   $| = 1;
   binmode(STDIN, ':encoding(UTF-8)');
   binmode(STDOUT, ':encoding(UTF-8)');
}
use open qw( :encoding(UTF-8) :std );

my $year = 0;
my $id = 0;
my $lines = 0;
my $words = 0;
open(my $fh, '>/dev/null');

print "Year\tSents\tLines\tWords\n";
while (<STDIN>) {
   ++$lines;

   if (/^[\pL\pN]/) {
      ++$words;
   }

   if ($lines % 50000 == 0) {
      print STDERR "$year\t$lines\t$words\r";
   }

   if (/^<s / && / stamp="(\d{4})/) {
      if ($year != $1) {
         close($fh);
         if ($year) {
            print "$year\t$id\t$lines\t$words\n";
         }
         $year = $1;
         $id = 0;
         $lines = 0;
         $words = 0;
         open($fh, '|-', "zstd -8 -T0 >${ARGV[0]}-$year.zstd");
      }
      ++$id;
      s/ id="\d+"/ id="$id"/g;
   }

   print $fh $_;
}

close($fh);
print "$year\t$id\t$lines\t$words\n";
