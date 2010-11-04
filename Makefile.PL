#!/usr/bin/env perl

use strict;
use warnings;

use inc::Module::Install;
all_from 'lib/Shutterstock/Example.pm';
requires 'Plack' => '0.9951';
requires 'Plack::Middleware::Debug' => '0.10';
requires 'Web::Simple' => '0.004';
requires 'parent' => '0.223';
requires 'DBIx::Class' => '0.08124';
requires 'DBIx::Class::Helpers' => '2.005000';
requires 'DBIx::Class::DynamicDefault' => '0.03';
requires 'DBIx::Class::TimeStamp' => '0.14';
requires 'DBIx::Class::QueryLog' => '1.3.0';
requires 'Plack::Middleware::Debug::DBIC::QueryLog' => '0.02';
requires 'DateTime' => '0.65';
requires 'HTML::FormHandler' => '0.32005';
requires 'HTML::FormHandler::Model::DBIC' => '0.14';

test_requires 'Test::DBIx::Class' => '0.16';
test_requires 'Test::Most' => '0.23';

install_script glob('script/*.psgi');
require 'script/author_Makefile.PL'
  if $Module::Install::AUTHOR;

WriteAll;

