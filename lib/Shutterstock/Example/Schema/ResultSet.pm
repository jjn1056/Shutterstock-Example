package Shutterstock::Example::Schema::ResultSet;
use parent 'DBIx::Class::ResultSet';

__PACKAGE__->load_components(qw/
    Helper::ResultSet::IgnoreWantarray
    Helper::ResultSet::Me
    Helper::ResultSet::Random
    Helper::ResultSet::SetOperations
/);

sub as_hri {
    (shift)->
    search({}, {
		result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	});
}

1;

=head1 NAME

Freestock::Schema::ResultSet - A base ResultSet Class

=head1 SYNOPSIS

    package Shutterstock::Example::Schema::ResultSet::User;
    use parent 'Shutterstock::Example::Schema::ResultSet';
	
=head1 DESCRIPTION

All ResultSet classes should inherit from this.  This provides some base
methods that you can share across all the resultsets.  Good things to put here
would include utilties useful for all resultsets and inflator classes.

Please see the documentation for  L<DBIx::Class::Helpers> in order to
understand included component functionality.

=head1 METHODS

This package defines the following methods.

=head2 as_hri

Returns a version of the current resultset which uses the alternative resultset
class L<DBIx::Class::ResultClass::HashRefInflator>.  This gives a nice,  clean
and fast dump of the current resultset data into a hash.

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


