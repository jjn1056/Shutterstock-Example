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
        $res->content(&homepage);
        $res->finalize;
    },
};

sub doctype {
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" ',
    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">';
}

sub homepage {
    HTML::Tags::to_html_string(
        &doctype,
        <html>,
            <title>,"Hello World!",</title>,
            <body>,
                <p>, "Hi, I'm version: $Shutterstock::Example::VERSION", </p>,
            </body>,
        </html>,
    );
}

1;
