#!/usr/bin/env perl
use strict;
use warnings;

my $foo = Inline::Foo->new('Hello, world!');
$foo->display();

### Inline::Foo ###
package Inline::Foo;

sub new {
	my $class = shift;
	return bless { text => shift }, $class;
}

sub display {
	my $self = shift;
	print "\$text = $self->{text}\n";
}