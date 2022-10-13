#!/usr/bin/env perl
use strict;
use warnings;

my $i = 0;
while (1) {
   my $n = sprintf('%05d', $i);
   if (! -s "split-$n.gz") {
      last;
   }

   my $c = sprintf('%05d', int($i / 100)*100);
   if (! -e "$c") {
      print "Folder $c/\n";
      `mkdir -p $c/`;
   }
   print `mv -v *-$n* $c/`;

   ++$i;
}
