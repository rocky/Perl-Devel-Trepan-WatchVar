#!/usr/bin/env perl
#  Copyright (C) 2012 Rocky Bernstein <rocky@cpan.org>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;
use Module::Build;
use Config;

use File::Spec;
use File::Basename;
my $lib = File::Spec->catfile(dirname(__FILE__), 'lib');
unshift @INC, $lib;
require Devel::Trepan::WatchVar;

my $release_status = ($Devel::Trepan::WatchVar::VERSION =~ /_/) ? 
    'testing' : 'stable';

my $builder = Module::Build->new( 
    module_name         => 'Devel::Trepan::WatchVar',
    add_to_cleanup      => [ 'Devel-Trepan-*', 'tmp*', '*.got'  ],
    create_makefile_pl  => 'passthrough',
    dist_abstract       => 
    'Devel::Trepan variable watch plugin for via Variable::Magic',
    dist_author         => 'Rocky Bernstein <rocky@cpan.org>',
    dist_version_from   => 'lib/Devel/Trepan/WatchVar.pm',
    license             => 'gpl',
    needs_compiler      => 0,
    release_status      => $release_status,

    meta_merge => {
	resources => {
	    bugtracker  => 'https://github.com/rocky/Perl-Devel-Trepan-WatchVar/issues',
	    repository  => 'http://github.com/rocky/Perl-Devel-Trepan-WatchVar'
	}
    },    

    configure_requires  => { 
	'Module::Build' => '0.32',
    },
    test_requires  => { 
	'Data::Dumper'                      => 0,
        'Test::Simple'                      => '0.81',
        'rlib'                              => '0.02',
    },
    recommends => {
        'Pod::Text::Color'                  => 2.06,
    },
    requires => {
	'perl'                              => '5.008',               
	'Variable::Magic'                   => 0,
	'Devel::Trepan'                     => '0.47',
	'Getopt::Long'                      => 0,
        'rlib'                              => '0.02',
    },
    sign                => ($ENV{PERL_MB_NOSIGN} ? 0 : 1),
    );

$builder->create_build_script();
