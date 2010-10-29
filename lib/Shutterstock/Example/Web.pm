use Web::Simple 'Shutterstock::Example::Web';

package Shutterstock::Example::Web;

use Shutterstock::Example;
use HTML::Tags;
use Plack::Request;
use Plack::Response;

dispatch {
    sub (/) {
        my $res = Plack::Response->new(200);
        $res->content_type('text/html');
        $res->content($self->landing);
        $res->finalize;
    },
};

sub landing {
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" ',
    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
    HTML::Tags::to_html_string(
        <html>,
            <title>,"Hello World!",</title>,
            <body>,
                <p>, "Hi, I'm version: $Shutterstock::Example::VERSION", </p>,
            </body>,
        </html>,
    );
}

1;
