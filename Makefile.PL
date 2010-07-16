#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Shutterstock/Example.pm';

my @core_requires = (
    'Plack' => '0.9938',
    'Plack::Middleware::Debug' => '0.09',
    'Web::Simple' => '0.003',
);

requires @core_requires;
build_requires 'Test::More' => '0.94';

install_script glob('script/*.psgi');
auto_install;
WriteAll;
