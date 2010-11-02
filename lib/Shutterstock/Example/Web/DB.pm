package Shutterstock::Example::Web::DB;

use strict;
use warnings;
use Test::DBIx::Class
  -schema_class => 'Shutterstock::Example::Schema',
  -traits=>'Testmysqld',
  qw(:resultsets);

sub import {
    my ($class, $target) = @_;
    $target ||= 'Schema';
    my $caller = caller;
    &export_into($caller, $target);
    &seed;
}

sub export_into {
    my ($caller, $target) = @_;
    INFUSE_CALLER: {
        no strict 'refs';
        *{"${caller}::${target}"} = \&Schema;
    }
}

sub seed {

    Role->create({
        title => 'member',
        description => 'normal member',
    });

    Role->create({
        title => 'admin',
        description => 'super privs',
    });

}

1;
