package Shutterstock::Example::Web::DB;

use strict;
use warnings;
use DBIx::Class::QueryLog;
use Test::DBIx::Class
  -schema_class => 'Shutterstock::Example::Schema',
  -traits=>'Testmysqld',
  qw(:resultsets);

sub import {
    my ($class, $target) = @_;
    $target ||= 'WebSchema';
    my $caller = caller;
    &export_into($caller, $target);
    &seed;
}

sub export_into {
    my ($caller, $target) = @_;
    INFUSE_CALLER: {
        no strict 'refs';
        *{"${caller}::${target}"} = sub ($) {
            my $querylog = shift->{'plack.middleware.debug.dbic.querylog'};
            return &schema_with_querylog($querylog);
        };
    }
}

sub schema_with_querylog {
    my $querylog = shift;
    my $schema = Schema->clone;
    $schema->storage->debugobj($querylog);
    $schema->storage->debug(1);
    return $schema;
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
