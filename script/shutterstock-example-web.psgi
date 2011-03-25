use strict;
use warnings;
use Plack::Builder;
use Shutterstock::Example::Web;

builder {

    ## enable middleware
    enable 'StackTrace';
    enable 'Debug';
    enable 'Debug::DBIC::QueryLog';

    ## return application
    Shutterstock::Example::Web->to_psgi_app;

};

