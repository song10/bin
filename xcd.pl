#!/usr/bin/env perl

use strict;
use warnings;

my $db;
my %hash;

#
# read database
#
sub ReadDatabase {
	delete @hash{keys %hash};

	open MYFILE, $db or die $!;
	my $key;
	while (my $line = <MYFILE>) {
		chomp $line;
		if ($line =~ /^([^:]+):([^:]+)$/) {
			my ($k, $v) = ($1, $2);
			$hash{$k} = $v;
		}
	}
	close MYFILE;
	# print map { "$_:$hash{$_}\n" } keys %hash;
}

#
# lookup table
#
sub LookupPath {
	my $key = shift;
	return $hash{$key} if exists $hash{$key};
	return '';
}

#
# locate database
#
$db = `dirname $0`;
chomp $db;
$db .= '/xcd.db';
# print "$db";

#
# parse arguments
#
my $script = '';
if (0 == @ARGV) {
	$script .= "cd -";
# } elsif (1 == @ARGV) {
} elsif (2 == @ARGV) {
	my $prj = $ARGV[1];
	my $pre = "~/my/app/$ARGV[0]";
	my $pos = "$prj/assets/www";
	my $rz = "$pre/$pos";
	$script .= "cd $rz;title $prj\n";
} elsif ($ARGV[0] =~ /^([^:]+):([^:]+)$/) {
	my ($site, $path) = ($1, $2);
	if ($path =~ m/^~/) {
		# my $home = $ENV{HOME};
		# $path =~ s/~/$home/;
		$path =~ s/~//;
	}
	$script .= "cd ~/site/$site/$path" . "\n";
} else {
	ReadDatabase($db);
	my $rz = LookupPath($ARGV[0]);
	if (not $rz) {
		print "define '$ARGV[0]' : ";
		my $path = <STDIN>;
		open (MYFILE, ">>$db");
		print MYFILE "$ARGV[0]:$path";
		close (MYFILE);

		ReadDatabase($db);
		$rz = LookupPath($ARGV[0]);
		if (not $rz) { exit 1; }
	}
	$script .= "mkdir -p $rz;cd $rz";
}

#
# generate /tmp/x
#
open (MYFILE, ">/tmp/x");
print MYFILE "$script";
close (MYFILE);
exit 0;
