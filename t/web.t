use Test::Most;  
use Shutterstock::Example::Web;
use Plack::Test;
use HTTP::Request::Common qw(GET POST);

ok my $app = Shutterstock::Example::Web->new->as_psgi_app,
  'Got a plack app';

test_psgi $app, sub {
    my $cb = shift;
    my $res = $cb->(GET "/");
    like $res->content, qr/Welcome to the Demo Home/,
      'Got Expected Content';
};

done_testing; 
