use strict;
use warnings;
use Plack::Builder;
use Shutterstock::Example::Web;

builder {
    enable 'StackTrace';
    enable 'Debug', panels => [ qw(DBITrace Environment PerlConfig Memory Timer Parameters Response ) ];
    Shutterstock::Example::Web->as_psgi_app;
};

