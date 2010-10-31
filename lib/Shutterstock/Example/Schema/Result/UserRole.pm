package Shutterstock::Example::Schema::Result::UserRole;
use parent 'Shutterstock::Example::Schema::Result';

 __PACKAGE__->join_table({
    left_class   => 'User',
    left_method  => 'user',
    right_class  => 'Role',
    right_method => 'role',
});

1;

=head1 NAME

Shutterstock::Example::Schema::Result::UserRole - User to Role Join table.

=head1 DESCRIPTION

Join table between User and Role entities.

=head1 METHODS

This package defines the following methods.

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
