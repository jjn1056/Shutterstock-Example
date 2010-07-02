#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Shutterstock/Example.pm';

my @core_requires = (
	'Moose' => '1.08',
	'Plack' => '0.9938',
);

requires @core_requires;
build_requires 'Test::More' => '0.94';

auto_install;
WriteAll;
