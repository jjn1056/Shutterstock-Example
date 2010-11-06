#!/usr/bin/env perl

use strict;
use warnings;
use inc::Module::Install;

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
requires 'UUID::Tiny' => '1.03';
requires 'HTML::FillInForm::Lite' => '1.09';
requires 'Test::mysqld' => '0.11'; ## Need for non-interactive install Test::DBIC
requires 'Test::DBIx::Class' => '0.16'; ## Non test dep for now
requires 'App::local::lib::helper' => '0.03'; 

test_requires 'Test::Most' => '0.23';
test_requires 'HTTP::Request::Common';

all_from 'lib/Shutterstock/Example.pm';
install_script glob('script/*.psgi');
require 'script/author_Makefile.PL'
  if $Module::Install::AUTHOR;

my $start_server_helper = 
  File::Spec->catdir('script','start-server-helper');

postamble <<"EOP";
install :: start_server_helper

start_server_helper :
\t\$(PERL) $start_server_helper @ARGV
EOP

WriteAll;

