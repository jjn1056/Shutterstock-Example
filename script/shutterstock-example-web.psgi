use strict;
use warnings;
use Plack::Builder;
use Shutterstock::Example::Web;

builder {
    enable 'StackTrace';
    enable 'Debug', panels => [qw(DBITrace Environment PerlConfig Memory Timer Parameters Response) ];
    enable 'Debug::DBIC::QueryLog', querylog_args => {passthrough => 1}; 
    Shutterstock::Example::Web->as_psgi_app;
};

