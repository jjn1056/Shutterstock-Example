package Shutterstock::Example::Schema::Result::User;
use parent 'Shutterstock::Example::Schema::Result';

__PACKAGE__->table('user');
__PACKAGE__->add_columns(
    user_id => {
        data_type => 'varchar',
        size => '36',
    },
    email => {
        data_type => 'varchar',
        size => '96',
    },
    created => {
        data_type => 'datetime', 
        set_on_create => 1,
        set_on_update => 1,
    },
);
__PACKAGE__->set_primary_key('user_id');
__PACKAGE__->add_unique_constraint(['email']);
__PACKAGE__->has_many(user_roles_rs => 'Shutterstock::Example::Schema::Result::UserRole', 'user_id');
__PACKAGE__->many_to_many('roles', 'user_roles_rs', 'role');

1;

=head1 NAME

Shutterstock::Example::Schema::Result::User - A user on the site

=head1 SYNOPSIS

    my $user = $schema->resultset('User')->first;
    say $user->email;

=head1 DESCRIPTION

Someone with some sort of rights to the site

=head1 METHODS

This package defines the following methods.

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
