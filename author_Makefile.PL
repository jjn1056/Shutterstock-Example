## --------------------------------------------------------------------------##
## This stuff is used by CPAN authors and developers who need to build this  ##
## code, create tarballs, run extended author tests, etc.  It also has some  ##
## features for helping to manage dependencies, although if you are using a  ##
## modern cpan or cpanminus, they are less valuable.  If you just want to    ##
## install code for use you don't need to worry about this code.  If you are ##
## a developer you will need to bootstrap your Perl setup with a SDK such as ##
## L<Task::BeLike::JJNAPIORK>                                                ##
##                                                                           ##
## Module::Install automatically 'uses' the following plugins if they have   ##
## already been installed.  We list them here for cataloging and to reduce   ##
## obfuscation due to the autoloading magic.                                 ##
## --------------------------------------------------------------------------##

use Module::Install::ReadmeMarkdownFromPod;
use Module::Install::ManifestSkip;
use Module::Install::AutoLicense;
use Module::Install::Repository;
use Module::Install::Homepage;
use Module::Install::AutoManifest;
use Module::Install::Bundle::LocalLib;

requires 'App::local::lib::helper';
readme_markdown_from_pod;
manifest_skip;
auto_license;
auto_set_repository;
auto_set_homepage;
auto_manifest;
auto_install;
bundle_local_lib;

1;
