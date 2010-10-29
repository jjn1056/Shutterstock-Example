package Shutterstock::Example;
 
use 5.008008;
our $VERSION = '0.08';
 
=head1 NAME

Shutterstock::Example - An Example application for Internal Shutterstock IT

=head1 DESCRIPTION

Technology sample for L<Plack>, L<Web::Simple>, L<Module::Install> and
L<local::lib>.

Intended as experimental area for possible new technlogies such as L<Plack> and
techniques for deployment, CPAN dependency management and coder sandboxing.

=head1 INSTALLATION

Following is suggested method for installing sample code depending on context,
either as a developer or as an administrator.

=head2 Developer

Developers are primarily interested in ability to checkout code, make and share
code changes, run tests, try out new dependencies and resolve merge conflicts
with other developers.  Suggested method is for a developer to install a user
level Perl with L<App::Perlbrew>, bootstrap a developer kit (for now the easy
way to do this is via L<Task::BeLike::JJNAPIORK>), clone the git repository and
then install dependencies.  Checklist follows:

=over4

=item install L<App::Perlbrew>

=item bootstrap SDK and L<local::lib>

=item clone git repository

=item install dependencies

=back

=head2 Administrator

Given a tarball, install it and all dependencies with L<App::cpanminus>, sync
to all target servers and HUP application servers.  Checklist follows:

=item create tarball

=item create new installation from tarball

=item sync across target servers

=item HUP applications servers

=head1 AUTHOR

Shutterstock Coders C<< <coders@shutterstock.com> >>

=head1 LICENSE & COPYRIGHT

Copyright 2010, Shutterstock, LLC
proprietary code not for distribution

=cut

1;
