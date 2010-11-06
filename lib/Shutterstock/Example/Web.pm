package Shutterstock::Example::Web;

use Web::Simple __PACKAGE__;
use Shutterstock::Example::Web::DB qw(WebSchema);
use Shutterstock::Example::Web::User;
use Shutterstock::Example;
use HTML::FillInForm::Lite;
use UUID::Tiny ':std';
use HTML::Tags;

## TODO Why multiply $env (psgi) hashrefs?
## TODO Get rid of the evil, evil passing $env to WebSchema

dispatch {
    sub (/) {
        $self->show_landing();
    },
    subdispatch sub (/...) {
        my($self, $env) = @_[0, +PSGI_ENV];
        my $user_rs = WebSchema($env)->resultset('User');
        [
            sub (GET + /user) {
                $self->show_users($user_rs);
            },
            subdispatch sub (/user/*) {
                my ($self, $env1, $env2, $env3, $id) = @_;
                my $item = $user_rs->find_or_new({user_id=>$id});
                my $form = Shutterstock::Example::Web::User->new(item=>$item);
                [
                    sub (GET) {
                        $self->show_user_form($form);
                    },
                    sub (POST + %:email=&:@roles~) {
                        my ($self, $env1, $env2, $env3, $env4, $params) = @_;
                        $form->process(params => $params) ?
                          $self->show_you_create_a_user :
                          $self->show_user_form($form);
                    },
                ],
            },
        ],
    },
};

sub as_html {
    my ($template, %data) = @_;
    my @body = process_templates([$template, \&layout], %data);

    ## TODO this could be better somewhere else
    ## TODO handle multiple forms, may should response filter?

    if(my $form = delete $data{form}) {
        my $h = HTML::FillInForm::Lite->new();
        @body = $h->fill(\@body, $form->fif );
    }

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
        uuid => create_uuid_as_string(),
    ));
}

    sub landing {
        my (%data) = @_;
        <p>, "Hi, I'm version: ", $data{site_version}, </p>,
        <p>, "Here's some interesting things about me", </p>,
        <ul>,
            <li>, <a href="/user">, "My Users", </li>,
            <li>, <a href="/user/$data{uuid}">, "Create New User", </li>,
        </ul>;
    }

sub show_users {
    my ($self, $user_rs) = @_;
    as_html(\&users, (
        title => "All Users",
        user_rs => $user_rs,
    ));
}

    sub users {
        my (%data) = @_;
        map({
            my $id = $_->user_id;
            <p>, <a href="/user/$id">, $_->email, </a>, </p>
        } $data{user_rs}->all),
        <a href="/">, "Home", </a>;
    }

sub show_user_form {
    my ($self, $form) = @_;
    as_html(\&user_form, (
        title => "Create a User",
        form => $form,
        roles => [$form->field('roles')->options],
        email_errors => $form->field('email')->errors,
        roles_errors => $form->field('roles')->errors,
    ));
}

    ## TODO This error display stuff could probably be extracted into
    ## a common component.

    sub user_form {
        my (%data) = @_;
        <form id="user-form" method="post">,
          <fieldset>,
            <div>,
              <label class="form-label" for="email">, "Email: ", </label>,
              <input type="text" name="email" id="email" value="" />,
              map({
              <span class="error_message">, " $_", </span>
              } @{$data{email_errors}}), 
            </div>,
            map({
              my ($value, $label) = @{$_}{qw/value label/};
              <input type="checkbox" name="roles" value="$value"  />, $label, <br/>
            } @{$data{roles}}),
            map({
              <span class="error_message">, " $_", </span>
            } @{$data{roles_errors}}), 
            <div>,
              <input type="submit" name="submit" id="submit" value="Save" />,
            </div>,
          </fieldset>,
        </form>;
    }

sub show_you_create_a_user {
    as_html(\&you_created_a_user, title => "Congrats!");
}

    sub you_created_a_user {
        <p>, "You made a user!", </p>,
        <a href="/">, "Home", </a>;
    }

1;

=head1 NAME

Shutterstock::Example::Web - A sample application

=head1 DESCRIPTION

A L<Web::Simple> based applicaiton.  Currently creates url mappings for the
following:

    GET http://localhost/
    GET http://localhost/user
    GET|POST http://localhost/*

=head1 METHODS

This package defines the following methods.

    TBD

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
