use strict;
use warnings;
use Plack::Builder;
use Shutterstock::Example;

my $app = sub {
    return [
        200,
        [ 'Content-Type' => 'text/html; charset=utf8' ],
        [ "<body>Hello World! I'm Version: $Shutterstock::Example::VERSION</body>" ],
    ];
};

builder {
    enable 'Debug', panels => [ qw(DBITrace Environment PerlConfig Memory Timer Parameters Response ) ];
    $app;
};

