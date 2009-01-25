use 5.006;
use strict;
use warnings;
use Module::Build 0.25;
use Module::Build::ConfigData;

my $C_support = Module::Build::ConfigData->feature("C_support");

printf "Supports compiling C files: %s\n", $C_support ? "yes" : "no";

my $builder = Module::Build->new(
	module_name         => 'Scalar::Induce',
	license             => 'perl',
	dist_author         => 'Leon Timmermans <leont@cpan.org>',
	dist_version_from   => 'lib/Scalar/Induce.pm',
	build_requires      => {
		'Module::Build'      => 0.25,
		'Test::More'         => 0,
	},
	recommends          => {
		'ExtUtils::CBuilder' => 0.15,
	},
	config_data              => {
		C_support            => $C_support,
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

$builder->xs_files({}) if not $C_support;

$builder->create_build_script();
