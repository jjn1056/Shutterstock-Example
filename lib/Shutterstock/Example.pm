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
level Perl with L<App::perlbrew>, bootstrap a developer kit (for now the easy
way to do this is via L<Task::BeLike::JJNAPIORK>), clone the git repository and
then install dependencies.  Checklist follows:

=over4

=item install L<App::perlbrew>

Just follow the basic instructions to setup a user level Perl executable from
the L<App::perlbrew> documentation.

=item bootstrap SDK and L<local::lib>

The first command bootstraps the SDK for Modern Perl development, the second
enables your L<local::lib> in C<$HOME/extlib> so that you can use it.

    * curl -L http://cpanmin.us/ | perl - -l $HOME/extlib Task::BeLike::JJNAPIORK
    * $HOME/extlib/bin/localenv bash

See the documentation for L<App::local::lib::helper> on the C<localenv> and the
C<localenv-bashrc> scripts.

=item clone git repository

Fork http://github.com/jjn1056/Shutterstock-Example and clone it.

=item install dependencies

    cpanm --installdeps .

=item start the server

    plackup -Ilib ./script/shutterstock-example-web.psgi

=back

=head2 Administrator

Given a tarball, install it and all dependencies with L<App::cpanminus>, sync
to all target servers and HUP application servers.  Checklist follows:

=item create tarball

    * perl Makefile.PL
    * make test
    * make dist

=item create new installation from tarball

    * cpanm -l $HOME/local-v0.08 Shutterstock-Example-0.08.tar.gz 

=item sync across target servers

    TBD

=item HUP applications servers

    TBD

=head1 AUTHOR

Shutterstock Coders C<< <coders@shutterstock.com> >>

=head1 LICENSE & COPYRIGHT

Copyright 2010, Shutterstock, LLC
proprietary code not for distribution

=cut

1;
