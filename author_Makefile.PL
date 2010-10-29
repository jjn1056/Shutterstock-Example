#!/usr/bin/env perl

use strict;
use warnings;

use Module::Install::ReadmeMarkdownFromPod 0.003;
use Module::Install::ManifestSkip 0.14;
use Module::Install::AutoLicense 0.08;
use Module::Install::Repository 0.06;
use Module::Install::Homepage 0.01;
use Module::Install::AutoManifest 0.003;

readme_markdown_from_pod;
manifest_skip;
auto_license;
auto_set_repository;
auto_set_homepage;
auto_manifest;

auto_install;
WriteAll;

