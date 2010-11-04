package Shutterstock::Example::Web;

use Web::Simple __PACKAGE__;
use Shutterstock::Example::Web::DB qw(WebSchema);
use Shutterstock::Example::Web::User;
use Shutterstock::Example;
use HTML::Tags;

dispatch {
    sub (/) {
        $self->show_landing;
    },
    subdispatch sub (/user) {
        my($self, $env) = @_[0, +PSGI_ENV];
        my $form = Shutterstock::Example::Web::User->new(schema=>WebSchema($env));
        [
            sub (GET) {
                $self->show_new_user_form($form);
            },
            sub (POST + %:email=&*) {
                my ($self, $env1, $env2, $params) = @_;
                $form->process(params => $params) ?
                  $self->show_you_create_a_user :
                  $self->show_new_user_form($form);
            }
        ],
    },
};

sub as_html {
    my ($template, %data) = @_;
    my @body = process_templates([$template, \&layout], %data);
    return [
        200,
        ['Content-Type' => 'text/html' ],
        \@body,
    ];
}

    sub process_templates {
        my ($templates, %data) = @_;
        for my $template(@$templates) {
            my @processed = $template->(%data);
            $data{content} = \@processed;
        }
        HTML::Tags::to_html_string(@{$data{content}});
    }

    sub layout {
        my (%data) = @_;
        \'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" ',
        \'"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">',
        <html>,
          <title>, ($data{title} || 'Hello World'), </title>,
            <body>, @{$data{content}},
            </body>,
        </html>;
    }

sub show_landing {
    as_html(\&landing, (
        title => "Welcome to the Demo Home",
        site_version => $Shutterstock::Example::VERSION,
    ));
}

    sub landing {
        my (%data) = @_;
        <p>, "Hi, I'm version: ", $data{site_version}, </p>,
        <p>, "Here's some interesting things about me", </p>,
        <ul>,
            <li>, <a href="/user">, "My Users", </li>,
        </ul>;
    }

sub show_new_user_form {
    my ($self, $form) = @_;
    as_html(\&new_user_form, (
        title => "Create a User",
        form => $form,
    ));
}

    sub new_user_form {
        my (%data) = @_;
        my $form = $data{form}->render;
        return <div>, \$form, </div>;
    }

sub show_you_create_a_user {
    as_html(\&you_created_a_user, title => "Congrats!");
}

    sub you_created_a_user {
        <p>, "You made a user!", </p>;
    }

1;

   
