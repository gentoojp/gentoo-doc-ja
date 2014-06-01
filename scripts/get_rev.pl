#!/usr/bin/perl

while(<>){
    if(m{<!-- \$Header: \S+ (\d+\.\d+) }m){
	print "\n<!-- Original revision: $1 -->";
    }
}
