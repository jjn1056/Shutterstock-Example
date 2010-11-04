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
    Shutterstock::Example::Web->as_psgi_app;

};

