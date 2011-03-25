#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

requires 'Plack' => '0.9974';
requires 'Plack::Middleware::Debug' => '0.11';
requires 'Web::Simple' => '0.008';
requires 'parent' => '0.225';
requires 'DBIx::Class' => '0.08127';
requires 'DBIx::Class::Helpers' => '2.007000';
requires 'DBIx::Class::DynamicDefault' => '0.03';
requires 'DBIx::Class::TimeStamp' => '0.14';
requires 'DBIx::Class::QueryLog' => '1.3.0';
requires 'Plack::Middleware::Debug::DBIC::QueryLog' => '0.06';
requires 'DateTime' => '0.66';
requires 'HTML::FormHandler' => '0.33002';
requires 'HTML::FormHandler::Model::DBIC' => '0.14';
requires 'UUID::Tiny' => '1.03';
requires 'Test::mysqld' => '0.12'; ## Need for non-interactive install Test::DBIC
requires 'Test::DBIx::Class' => '0.19'; ## Non test dep for now
requires 'Hash::MultiValue';

test_requires 'Test::Most' => '0.23';
test_requires 'HTTP::Request::Common';

all_from 'lib/Shutterstock/Example.pm';
install_script glob('script/*.psgi');
require 'maint/Makefile.PL.include'
  if $Module::Install::AUTHOR;

my $plackup_helper = 
  File::Spec->catdir('script','plackup-helper');

postamble <<"EOP";
install :: plackup_helper

plackup_helper :
\t\$(PERL) $plackup_helper @ARGV
EOP

WriteAll;

