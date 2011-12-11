package Scalar::Induce;

use 5.006;
use strict;
use warnings;

##no critic (ProhibitAutomaticExportation)
use Exporter 5.57 'import';
use XSLoader;
our @EXPORT  = qw/induce void/;

XSLoader::load('Scalar::Induce', __PACKAGE__->VERSION);

1;

#ABSTRACT: Unfolding scalars

__END__

=head1 SYNOPSIS

	my @reversed = induce { @$_ ? pop @$_ : void undef $_ } [ 1 .. 10 ];

	my @chunks = induce { (length) ? substr $_, 0, 3, '' : void undef $_ } "foobarbaz";

=head1 FUNCTIONS

All functions are exported by default.

=head2 induce

This function takes a block and a scalar as arguments and then repeatedly applies the block to the value, accumulating the return values to eventually return them as a list. It does the opposite of reduce, hence its name. It's called unfold in some other languages.

=head2 void

This is a utility function that always returns an empty list (or undefined in scalar context). This makes a lot of inductions simpler.

=head1 ACKNOWLEDGEMENTS

Aristotle Pagaltzis came up with this idea (L<http://use.perl.org/~Aristotle/journal/37831>). Leon Timmermans re-implemented it in XS and uploaded it to CPAN.

=cut

