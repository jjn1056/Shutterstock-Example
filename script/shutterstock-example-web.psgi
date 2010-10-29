use strict;
use warnings;
use Plack::Builder;
use Shutterstock::Example::Web;

builder {
    enable 'StackTrace';
    enable 'Debug';
    Shutterstock::Example::Web->as_psgi_app;
};

