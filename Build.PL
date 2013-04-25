use 5.006;
use strict;
use warnings;
use Module::Build 0.25;

my $builder = Module::Build->new(
	module_name         => 'Scalar::Induce',
	license             => 'perl',
	dist_author         => 'Leon Timmermans <leont@cpan.org>',
	dist_version_from   => 'lib/Scalar/Induce.pm',
	##{ $plugin->get_prereqs ##}
	meta_merge => {
		resources       => {
			bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Scalar-Induce',
		},
		keywords        => [ qw/induce reduce/ ],
	},
	add_to_cleanup      => [ 'Scalar-Induce-*' ],
	allow_pureperl      => 1,
);

$builder->create_build_script();
