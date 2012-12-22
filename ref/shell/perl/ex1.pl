#!/usr/bin/perl -w

##Simplified example of using Getopt:Long moudule with an Options hash

use Getopt::Long;
use strict;

my %Opt=();


(GetOptions( \%Opt,
	"h|help",
	"s|string=s",
	"l|list=s@",
	"i|int=i",
	"f|float=f",
	"o|octal=o",
)) || die "ERROR: Illegal arguments or parameters: @ARGV\n" unless ($#ARGV < 0);

## Or as OO
#
#my $parser = new Getopt::Long::Parser;
#$parser->configure("no_ignore_case");
#if ($parser->getoptions(\%Opt,
#			"h|help",
#			"s|string=s",
#			"l|list=s@",
#			"i|int=i",
# 		"f|float=f",
# 		"o|octal=o",
#)) {};
#

## Just print out the options for each collected to see what there is:
foreach my $key (keys %Opt) {
	print "$key is $Opt{$key}\n";
}

system("myget -y ninja");
