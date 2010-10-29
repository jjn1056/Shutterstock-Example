#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

requires 'Plack' => '0.9951';
requires 'Plack::Middleware::Debug' => '0.10',
requires 'Web::Simple' => '0.004',
test_requires 'Test::Most' => '0.23';

all_from 'lib/Shutterstock/Example.pm';
install_script glob('script/*.psgi');
auto_install;
WriteAll;
