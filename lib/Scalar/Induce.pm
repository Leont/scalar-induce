package Scalar::Induce;

use 5.006;
use strict;
use warnings;

##no critic (ProhibitAutomaticExportation)
use Exporter 5.57 'import';
use XSLoader;
our $VERSION = '0.03';
our @EXPORT  = qw/induce void/;

use Scalar::Induce::ConfigData;

if (Scalar::Induce::ConfigData->config('C_support') and not our $pure_perl) {
	eval { XSLoader::load('Scalar::Induce', $VERSION) } or warn "$@\nFalling back on pure-perl version\n";
}
if (not defined &induce) {
	eval <<'END';    ##no critic (ProhibitStringyEval)
	sub induce (&$) {
		my ( $c, $v ) = @_;
		my @r;
		for ( $v ) { push @r, $c->() while defined }
		@r;
	}
	sub void { return; }
END
}

1;

__END__

=head1 NAME

Scalar::Induce - Unfolding scalars

=head1 VERSION

Version 0.03

=head1 SYNOPSIS

	my @reversed = induce { @$_ ? pop @$_ : void undef $_ } [ 1 .. 10 ];

	my @chunks = induce { (length) ? substr $_, 0, 3, '' : void undef $_ } "foobarbaz";

=head1 FUNCTIONS

All functions are exported by default.

=head2 induce

This function takes a block and a scalar as arguments and then repeatedly applies the block to the value, accumulating the return values to eventually return them as a list. It does the opposite of reduce, hence its name. It's called unfold in some other languages.

=head2 void

This is a utility function that always returns an empty list (or undefined in scalar context). This makes a lot of inductions simpler.

=head1 AUTHORS

Leon Timmermans, C<< <leont at cpan.org> >>, Aristotle Pagaltzis C<< <pagaltzis at gmx.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-scalar-induce at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Scalar-Induce>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Scalar::Induce

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Scalar-Induce>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Scalar-Induce>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Scalar-Induce>

=item * Search CPAN

L<http://search.cpan.org/dist/Scalar-Induce>

=back


=head1 ACKNOWLEDGEMENTS

Aristotle Pagaltzis came up with this idea (L<http://use.perl.org/~Aristotle/journal/37831>). Leon Timmermans merely re-implemented it in XS and uploaded it to CPAN.

=head1 COPYRIGHT & LICENSE

Copyright 2009 Leon Timmermans & Aristotle Pagaltzis, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

