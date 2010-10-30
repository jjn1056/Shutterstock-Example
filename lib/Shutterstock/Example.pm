package Shutterstock::Example;
 
use 5.008008;
our $VERSION = '0.09';
 
=head1 NAME

Shutterstock::Example - An Example application using Modern Perl

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

=head3 install L<App::perlbrew>

Just follow the basic instructions to setup a user level Perl executable from
the L<App::perlbrew> documentation.

=head3 bootstrap SDK and L<local::lib>

The first command bootstraps the SDK for Modern Perl development, the second
enables your L<local::lib> in C<$HOME/extlib> so that you can use it.

    curl -L http://cpanmin.us/ | perl - -l $HOME/extlib Task::BeLike::JJNAPIORK
    $HOME/extlib/bin/localenv bash

See the documentation for L<App::local::lib::helper> on the C<localenv> and the
C<localenv-bashrc> scripts.

=head3 clone git repository

Fork http://github.com/jjn1056/Shutterstock-Example and clone it.  Something
similar to:

    git clone git@github.com:jjn1056/Shutterstock-Example.git

=head3 install dependencies

L<App::cpanminus> was installed when you bootstrapped the SDK, and is the
preferred tool to installing CPAN modules.

    cpanm --installdeps .

=head3 start the server

C<plackup> comes with L<Plack> and is used to start the PSGI application 
inside a PSGI handler.

    plackup -Ilib ./script/shutterstock-example-web.psgi

=head2 Administrator

Given a tarball, install it and all dependencies with L<App::cpanminus>, sync
to all target servers and HUP application servers.  Checklist follows:

=head3 create tarball

    perl Makefile.PL
    make test
    make dist

=head3 create new installation from tarball

    cpanm -l $HOME/local-v0.XXX Shutterstock-Example-0.XXX.tar.gz 

=head3 sync across target servers

    TBD

=head3 HUP applications servers

    TBD

=head1 AUTHOR

John Napiorkowski, C<< <jjnapiork@cpan.org> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
