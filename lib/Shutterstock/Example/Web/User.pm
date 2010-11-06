package Shutterstock::Example::Web::User;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::TraitFor::DBICFields';

has '+exclude' => (default => sub {+['created','user_id']});
has_field 'roles' => (type => 'Multiple', label_column => 'title', required => 1);

__PACKAGE__->meta->make_immutable;

