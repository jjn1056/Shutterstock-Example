#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

all_from 'lib/Shutterstock/Example.pm';
requires 'Plack' => '0.9951';
requires 'Plack::Middleware::Debug' => '0.10',
requires 'Web::Simple' => '0.004',
test_requires 'Test::Most' => '0.23';
install_script glob('script/*.psgi');
require 'author_Makefile.PL'
  if $Module::Install::AUTHOR;

WriteAll;
