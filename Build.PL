use 5.008002;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WWW::Wikipedia::Links',
    license             => 'perl',
    dist_author         => q{Moritz Lenz <moritz@faui2k3.org>},
    dist_version_from   => 'lib/WWW/Wikipedia/Links.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.008002,
        'Mojo' => 1.034,
    },
    add_to_cleanup      => [ 'WWW-Wikipedia-Links-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
