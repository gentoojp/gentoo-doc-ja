#!/usr/bin/perl
# -*- coding: utf-8; -*-

my $in_author = 0;

while(<>){
    if($in_author == 0){
	if(/<author title="翻訳">/){
	    print;
	    $in_author = 1;
	}
    }else{
	print;
	if(m!</author>!){
	    $in_author = 0;
	}
    }
}
print "\n"
