package Shutterstock::Example::Web;

use Web::Simple __PACKAGE__;
use Shutterstock::Example::Web::DB qw(WebSchema);
use Shutterstock::Example::Web::User;
use Shutterstock::Example;
use UUID::Tiny ':std';
use HTML::Tags;

## TODO Why multiply $env (psgi) hashrefs?
## TODO Get rid of the evil, evil passing $env to WebSchema

dispatch {
    sub (/) {
        $self->show_landing();
    },
    sub (GET + /user) {
        my($self, $env) = @_[0, +PSGI_ENV];
        $self->show_users(WebSchema($env)->resultset('User'));
    },
    subdispatch sub (/user/*) {
        my($self, $id, $env) = @_[0, 2, +PSGI_ENV];
        my $item = WebSchema($env)->resultset('User')->find_or_new({user_id=>$id});
        my $form = Shutterstock::Example::Web::User->new(item=>$item);
        [
            sub (GET) {
                $self->show_user_form($form);
            },
            sub (POST + %:email=&:@roles~) {
                my ($self, $env1, $env2, $params) = @_;
                $form->process(params => $params) ?
                  $self->show_you_create_a_user :
                  $self->show_user_form($form);
            },
        ]
    }
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
    my ($self, $user_rs) = @_;
    as_html(\&landing, (
        title => "Welcome to the Demo Home",
        site_version => $Shutterstock::Example::VERSION,
        uuid => create_uuid_as_string(),
    ));
}

    sub landing {
        my (%data) = @_;
        my $uuid = $data{uuid};
        <p>, "Hi, I'm version: ", $data{site_version}, </p>,
        <p>, "Here's some interesting things about me", </p>,
        <ul>,
            <li>, <a href="/user">, "My Users", </li>,
            <li>, <a href="/user/$uuid">, "Create New User", </li>,
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
    ));
}

    sub user_form {
        my (%data) = @_;

        ## TODO fix this mess
        my $email = $data{form}->field('email')->value || '';
        my @roles = $data{form}->field('roles')->options;
        my @email_errors = @{$data{form}->field('email')->errors};
        my $role_id = $data{form}->field('roles')->value;
        my @role_ids = ref $role_id ? @$role_id : $role_id;
        ## TODO End of mess

        <form id="user-form" method="post">,
          <fieldset>,
            <div>,
              <label class="form-label" for="email">, "Email: ", </label>,
              <input type="text" name="email" id="email" value="$email" />,
              map({
              <span class="error_message">, " $_", </span>
              } @email_errors), 
            </div>,
            map({
              my ($value, $label) = @{$_}{qw/value label/};
              my $checked = grep({ $_ eq $value } @role_ids) ? "checked" : "";
              <input type="checkbox" name="roles" value="$value" $checked />, $label, <br/>
            } @roles),
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

A L<Web::Simple> based applicaiton

=head1 METHODS

This package defines the following methods.

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
