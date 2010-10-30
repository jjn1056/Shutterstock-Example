package Shutterstock::Example::Schema::Result;
use parent 'DBIx::Class::Core';

__PACKAGE__->load_components(qw/
    Helper::Row::NumifyGet
    Helper::Row::JoinTable
    Helper::Row::OnColumnChange
    Helper::Row::StorageValues
    DynamicDefault
    TimeStamp
    InflateColumn::DateTime
/);

1;

=head1 NAME

Shutterstock::Example::Schema::Result - The base result class

=head1 SYNOPSIS

	package Shutterstock::Example::Schema::Result::User;
    use parent 'Shutterstock::Example::Schema::Result';
	
=head1 DESCRIPTION

All Result classes will inherit from this.  This provides some base functions,
primarily from included components.  Please see the documentation for the
following components: L<DBIx::Class::Helpers>, L<DBIx::Class::DynamicDefault>,
L<DBIx::Class::Timestamp>, L<DBIx::Class::InflateColumn::DateTime>

=head1 ATTRIBUTES

This class defines the following attributes.

=head1 METHODS

This module defines the following methods.

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

