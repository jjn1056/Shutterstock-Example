use MooseX::Declare;
use Freestock::Schema::Result::Registration;
class Freestock::Schema::ResultSet::User
	extends Freestock::Schema::ResultSet {
    method is_unregistered_email(Str $email) {
        $self->find({email=>$email}) ? 0:1;
    }
    method create_user_from_registration(Freestock::Schema::Result::Registration $registration) {
        my $new_user = $self->new_result({
            email => $registration->email,
            status => 'active',
            registration => $registration,
        });
        $new_user->store_column(password=>$registration->password);
        return $new_user->insert;

    }
	__PACKAGE__->meta->make_immutable(inline_constructor => 0);
} 1

__END__ 

=head1 NAME

Freestock::Schema::ResultSet::User - Set Methods on Users 

=head1 DESCRIPTION

Perform set oriented calculations.

=head1 METHODS

This package defines the following methods.

=head1 AUTHOR

See L<Freestock> for more information regarding authors.

=head1 COPYRIGHT & LICENSE

See L<Freestock> for the copyright & license information.

=cut

