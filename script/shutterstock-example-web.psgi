use strict;
use warnings;
use Plack::Builder;
use Shutterstock::Example;

my $app = sub {
    return [
        200, 
        [ 'Content-Type' => 'text/plain' ],
        [ "Hello World!  I'm Version: $Shutterstock::Example::VERSION" ],
    ];
};

builder {
    enable "Debug";
    $app;
};

