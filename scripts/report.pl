#!/usr/bin/perl
use strict;
use Term::ANSIColor;

my $dir = shift;
$dir =~ m!xml/htdocs/(.*)!;
$dir = $1;

my ($file, $graph, $percent);
my %docs;
my $result = 0;
while(<>) {
    if(m!^([^ ]+) ([^ ]+)$!){
        ($file, $percent) = ($1, $2);
        $docs{$file} = $percent;
    }
}

foreach $file (sort { $docs{$b} <=> $docs{$a} } keys %docs){
    $percent = $docs{$file};
    if($percent == 100){
        print color 'green';
    } elsif($percent == 0){
        print color 'reset';
    } else{
        print color 'red';
        $result = 1;
    }
    my $p = int($percent / 10);
    $graph = "|" . ("=" x $p) . ("-" x (10-$p)) . "|";
    write();
}

exit $result;

format STDOUT =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<< @##.##%
$file, $graph,$percent
.
