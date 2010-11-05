package Shutterstock::Example::Schema::Result::Role;
use parent 'Shutterstock::Example::Schema::Result';

__PACKAGE__->table('role');
__PACKAGE__->add_columns(
    role_id => {
        data_type => 'varchar',
        size => '36',
    },
    title => {
        data_type => 'varchar',
        size => '24',
    },
    description => {
        data_type => 'varchar',
        size => '64',
    },
);

__PACKAGE__->set_primary_key('role_id');
__PACKAGE__->add_unique_constraints(['title'], ['description']);
__PACKAGE__->has_many(role_users_rs => 'Shutterstock::Example::Schema::Result::UserRole', 'role_id');

1;

=head1 NAME

Shutterstock::Example::Schema::Result::Role - An ability related to site access for a User

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
