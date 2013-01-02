#!/usr/bin/env perl

use strict;

my $db;
my %hash;

#
# read database
#
sub ReadDatabase {
	delete @hash{keys %hash};

	open FILE, $db or die $!;
	my $key;
	while (my $line = <FILE>) {
		chomp $line;
		if ($line =~ /^([^:]+):([^:]+)$/) {
			my ($k, $v) = ($1, $2);
			$hash{$k} = $v;
		}
	}
	close FILE;
	# print map { "$_:$hash{$_}\n" } keys %hash;
}

#
# lookup table
#
sub LookupPath 	{
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
if (0 == @ARGV) {
	print "cd -"
} elsif ($ARGV[0] =~ /^([^:]+):([^:]+)$/) {
	my ($site, $path) = ($1, $2);
	if ($path =~ m/^~/) {
		# my $home = $ENV{HOME};
		# $path =~ s/~/$home/;
		$path =~ s/~//;
	}

	print "cd ~/site/$site/$site/$path"
} else {
	ReadDatabase($db);
	my $rz = LookupPath($ARGV[0]);
	if (not $rz) {
		print "define '$ARGV[0]' : ";
		my $path = <>;
		open (MYFILE, ">>$db");
		print MYFILE "$ARGV[0]:$path\n";
		close (MYFILE);

		ReadDatabase($db);
		$rz = LookupPath($ARGV[0])
	}

	print "cd $rz"
}
