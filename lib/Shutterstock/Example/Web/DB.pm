package Shutterstock::Example::Web::DB;

use strict;
use warnings;
use Test::DBIx::Class
  -schema_class => 'Shutterstock::Example::Schema',
  -traits=>'Testmysqld',
  qw(:resultsets);

sub import {
    my $caller = caller;
    &export_into($caller);
    &seed;
}

sub export_into {
    my ($caller) = @_;
    EVIL_MONKEY: {
        no strict 'refs';
        *{"${caller}::Schema"} = \&Schema;
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
