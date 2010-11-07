package Shutterstock::Example;
 
use 5.008008;
our $VERSION = '0.15';
 
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
then install dependencies.

=head3 install App::perlbrew

Although you can develop with whatever Perl is currently installed, current
best practices indicate that it would be best to develop applications againt
a Perl installation that is dedicated to this purpose.  Try to think of the
system Perl as a sort of runtime for installed applications while your 
developer Perl is similar to an SDK.

L<App::perlbrew> is a tool for making it easy to create user level Perl
installations.  It helps you to avoid permissions issues related to development
since all you need is permissions to your own $HOME directory.  Additionally
it promotes the ability for developers to work independently and it detaches
development from the global system Perl so that OS level needs won't interfere
with developer needs.

Just follow the basic instructions to setup a user level Perl executable from
the L<App::perlbrew/INSTALLATION> documentation, but here's a summary

From a terminal open to your $HOME directory:

    curl -LO http://xrl.us/perlbrew
    chmod +x perlbrew
    ./perlbrew install

It might take a while to download and compile the version of Perl you select.

=head3 bootstrap SDK and L<local::lib>

Once you are running your locally installed 'SDK' Perl, you need to bootstrap
it with a handful of CPAN modules required for general development.  Since Perl
is decentralized there is no official SDK, but many developers create bundles
under the "Task::BeLike::*" namespace.  Some of these are pretty big and will
take a long time.  My L<Task::BeLike::JJNAPIORK> is a very minimal SDK and 
contains just a handlful of modules.  For the purposes of this demo, I'll ask
you to bootstrap your SDK Perl with L<Task::BeLike::JJNAPIORK>.

    curl -L http://cpanmin.us/ | perl - -l $HOME/mylocal Task::BeLike::JJNAPIORK
    $HOME/mylocal/bin/localenv bash
 
The first command bootstraps the SDK for Modern Perl development, the second 
enables your L<local::lib> in C<$HOME/mylocal> so that you can use it.

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

Execute the following commands from the application home directory (that which
contains the Makefile.PL).

    perl Makefile.PL
    make test
    make dist

=head3 create new installation from tarball

    cpanm -l $HOME/local-v0.XXX Shutterstock-Example-0.XXX.tar.gz

=head3 test installation (start server)

    $HOME/local-v0.XXX/bin/start-shutterstock-example 

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
