#!/usr/bin/perl
use strict;

my $dir = shift;
$dir =~ m!xml/htdocs/(.*)!;
$dir = $1;

while(<>) {
    if(m!^Discard the translation of (en/[^ ]*) \(only ([0-9.]+)!){
        my ($file, $percent) = ("$dir/$1", $2);
        print "$file $percent\n";
    }
}
