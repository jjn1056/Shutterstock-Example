use Web::Simple 'Shutterstock::Example::Web';

package Shutterstock::Example::Web;
use Plack::Response;
use HTML::FormHandler::Model::DBIC;
use HTML::Tags;
use Shutterstock::Example;
use Test::DBIx::Class
  -schema_class => 'Shutterstock::Example::Schema',
##  -traits=>'Testmysqld',
  qw(:resultsets);

Role->create({title=>'member', description=>'normal member'});
Role->create({title=>'admin', description=>'super privs'});

sub user_form {
    my ($self, $item) = @_;
    $item ||= User->new_result({});
    HTML::FormHandler::Model::DBIC
    ->with_traits('HTML::FormHandler::TraitFor::DBICFields')
    ->new(
        item => $item,
        exclude => ['created'],
        field_list => [
            'roles' => { type => 'Multiple', label_column => 'title', order => 90},
            'submit' => { type => 'Submit', order => 99 },
        ],
    );
}

dispatch {
    my $res = Plack::Response->new(200);
    $res->content_type('text/html');

    sub (/) {
        $res->content($self->landing);
        $res->finalize;
    },
    subdispatch sub (/user) {
        my $form = $self->user_form;
        [
            sub (GET) {
                my $body = $form->render;
                $res->content($self->wrapper(\$body));
                $res->finalize;
            },
            sub (POST + %:email=&*) {
                my ($self, $env1, $env2, $params) = @_;
                $form->process(params => $params);
                if($form->validated) {
                    $res->content($self->wrapper("You got a new user!"));
                    $res->finalize;

                } else {
                    my $body = $form->render;
                    $res->content($self->wrapper(\$body));
                    $res->finalize;
                }
            }
        ],
    },
};

sub wrapper {
    my ($self, @body) = @_;
    '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" ',
    '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
    HTML::Tags::to_html_string(
        <html>,
            <title>,"Hello World!",</title>,
            <body>, @body,
            </body>,
        </html>,
    );

}

sub landing {
    $self->wrapper(
        <p>, "Hi, I'm version: $Shutterstock::Example::VERSION", </p>,
        <p>, "Here's some interesting things about me", </p>,
        <ul>,
            <li>, <a href="/user">, "My Users", </li>,
        </ul>,
    )
}

sub users {
#    my ($elf,
}
1;

   
