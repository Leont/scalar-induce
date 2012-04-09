use 5.006;
use strict;
use warnings;
use ExtUtils::CBuilder;
use Module::Build 0.25;

my $C_support = ExtUtils::CBuilder->new->have_compiler;

printf "Supports compiling C files: %s\n", $C_support ? "yes" : "no";

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
);

$builder->xs_files({}) if not $C_support;

$builder->create_build_script();
