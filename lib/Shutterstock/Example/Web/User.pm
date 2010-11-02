package Shutterstock::Example::Web::User;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
with 'HTML::FormHandler::TraitFor::DBICFields';

has '+item_class' => (default => 'User');
has '+exclude' => (default => sub {+['created']});
has_field 'roles' => (type => 'Multiple', label_column => 'title', order => 90);
has_field 'submit' => (type => 'Submit', order => 99);

__PACKAGE__->meta->make_immutable;

