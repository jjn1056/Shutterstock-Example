use Web::Simple 'Shutterstock::Example::Web';

package Shutterstock::Example::Web;

use Shutterstock::Example;
use HTML::Tags;
use Plack::Request;
use Plack::Response;

dispatch {
    sub (GET) {
        my $res = Plack::Response->new(200);
        $res->content_type('text/html');
        $res->content(
            HTML::Tags::to_html_string(
                <html>,
                    <title>,"Hello World!",</title>,
                    <body>,
                        <p>, "Hello World, I'm version: $Shutterstock::Example::VERSION", </p>,
                    </body>,
                </html>,
            ),
        ); 
        $res->finalize;
    },
};

1;
