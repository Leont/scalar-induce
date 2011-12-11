use 5.006;
use strict;
use warnings;
use Module::Build 0.25;

my $builder = Module::Build->new(
	module_name         => 'Scalar::Induce',
	license             => 'perl',
	dist_author         => 'Leon Timmermans <leont@cpan.org>',
	dist_version_from   => 'lib/Scalar/Induce.pm',
	build_requires      => {
		'Module::Build'      => 0.25,
		'ExtUtils::CBuilder' => 0.15,
		'Test::More'         => 0,
		'Test::Differences'  => 0,
	},
	meta_merge => {
		resources       => {
			bugtracker  => 'http://rt.cpan.org/NoAuth/Bugs.html?Dist=Scalar-Induce',
		},
		keywords        => [ qw/induce reduce/ ],
	},
	add_to_cleanup      => [ 'Scalar-Induce-*' ],
	create_makefile_pl  => 'passthrough',
	sign                => 1,
);

$builder->create_build_script();
