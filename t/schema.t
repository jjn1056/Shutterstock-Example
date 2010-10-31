use Test::Most;  
use Test::DBIx::Class
  -schema_class => 'Shutterstock::Example::Schema',
  qw(:resultsets);

fixtures_ok sub {

    ## Create John with roles
    User->
    create({
        email => 'johnn@shutterstock.com',
        user_roles_rs => [
            {role => {title=>'member', description=>'normal member'}},
            {role => {title=>'admin', description=>'super privs'}},
        ],
    });

    ## Create Mike with roles
    User->
    create({
        email => 'mike@shutterstock.com',
        user_roles_rs => [
            {role => {title=>'member', description=>'normal member'}},
        ],
    });

    ## Create just a role in advance
    my $partner = Role->
    create({
        title => 'partner',
        description => 'an external partner',
    });

    ## one user with precreated role
    User->
    create({
        email => 'joe@shutterstock.com',
        user_roles_rs => [
            {role => $partner},
        ],
    });

    ## create someone with all the roles
    User->
    create({email => 'jill@shutterstock.com'})->
    set_roles(Role->all);

}, 'Installed Fixtures';

ok my $john = User->find({email=>'johnn@shutterstock.com'}),
  'found John';

is_result $john;

ok my $johns_roles_rs = $john->user_roles_rs->search_related('role'),
  "got john's roles";

is_resultset $johns_roles_rs;

is_fields 'title', $johns_roles_rs, [qw/admin member/],
  'got expected role titles';

ok my $jill = User->find({email=>'jill@shutterstock.com'}),
  'found Jill';

is_result $jill;

ok my $jills_roles_rs = $jill->user_roles_rs->search_related('role'),
  "got jill's roles";

is_resultset $jills_roles_rs;

is_fields 'title', $jills_roles_rs, [qw/admin partner member/],
  'got expected roles';

eq_resultset $jills_roles_rs, Role,
  'Jill has all the roles';

ok my $admin = Role->find({title=>'admin'}),
  'Found an Administrator Role';

throws_ok sub {
    User->create({email=>'johnn@shutterstock.com'});
}, qr/column email is not unique/, "Can't insert non unique column into user";

throws_ok sub {
    $john->add_to_roles($admin);
}, qr/columns user_id, role_id are not unique/, "Can't insert non unique column user_role";

done_testing; 

