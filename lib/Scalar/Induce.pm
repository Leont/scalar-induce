package Scalar::Induce;

use 5.006;
use strict;
use warnings;

use base qw/Exporter DynaLoader/;
our $VERSION = '0.01';
our @EXPORT = qw/induce void/;

use Scalar::Induce::ConfigData;

bootstrap Scalar::Induce $VERSION if Scalar::Induce::ConfigData->config('C_support') and not our $pure_perl;

if (not defined &induce) {
	Test::More::diag('Using pure perl version');
	eval <<'END';
	sub induce (&$) {
		my ( $c, $v ) = @_;
		my @r;
		for ( $v ) { push @r, $c->() while defined }
		@r;
	}
    sub void {}
	our $uses_xs = 0;
END
}

1;

__END__

=head1 NAME

Scalar::Induce - The great new Scalar::Induce!

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

	#TODO...
	
=head1 FUNCTIONS

=head2 induce

=head2 void

=head1 AUTHORS

Leon Timmermans, C<< <leont at cpan.org> >>, Aristotle Pagaltzis C<< pagaltzis at gmx.de >>

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
Aristotle Pagaltzis came up with this idea L<http://use.perl.org/~Aristotle/journal/37831 here>. Leon Timmermans merely re-implemented it in XS and uploaded it to CPAN.


=head1 COPYRIGHT & LICENSE

Copyright 2009 Leon Timmermans & Aristotle Pagaltzis, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

