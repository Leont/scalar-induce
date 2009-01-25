#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Scalar::Induce' );
}

diag( "Testing Scalar::Induce $Scalar::Induce::VERSION, Perl $], $^X" );
