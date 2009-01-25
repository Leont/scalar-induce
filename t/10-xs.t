#!perl -T

use Test::More;
use Scalar::Induce;

plan($Scalar::Induce::uses_xs ? (tests => 10) : (skip_all => "No XS support") );

ok(!defined(void()), "void() is void");
ok(!defined(void(1)), "void(1) is void");
ok(!defined(void(1, 2, 3)), "void(1, 2, 3) is void");

is(() = void(), 0, "void is empty");
is(() = void(1), 0, "void is empty");

my @reversed = induce { @$_ ? pop @$_ : undef $_ } [ 1 .. 10 ];
my @expected = (reverse(1..10), undef);

is_deeply(\@reversed, \@expected, "First");


@reversed = induce { @$_ ? pop @$_ : void undef $_ } [ 1 .. 10 ];
@expected = reverse 1..10;

is_deeply(\@reversed, \@expected, "Second");


my $number = 4711;
my $base = 12;
my @power = induce {
	my $r = $number % $base;
	$number /= $base;
	$r || void undef $_;
} $number;

is_deeply(\@power, [7, 8, 8, 2 ], "Third");


my (@inc1, $key, $value);
push @inc1, [$key, $value] while ($key, $value) = each %INC;
my @inc2 = induce { my @kv = each %$_; @kv ? \@kv : void undef $_ } \%INC;

is_deeply(\@inc1, \@inc2, "Include arrays are the same");


my @chunks = induce { (length) ? substr $_, 0, 3, '' : void undef $_ } "foobarbaz";
is_deeply(\@chunks, [ qw/foo bar baz/ ], "foobarbaz");
