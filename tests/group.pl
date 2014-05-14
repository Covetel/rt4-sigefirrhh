use Error qw(:try);
use RT::Client::REST;
use RT::Client::REST::Group;
use Data::Dumper;

my $rt = RT::Client::REST->new(
			       server => 'http://localhost:8080/rt',
			       timeout => 30,
			      );

try {
  $rt->login(username => 'root', password => 'password');
} catch Exception::Class::Base with {
  die "problem logging in: ", shift->message;
};


my $group = RT::Client::REST::Group->new(
					 rt  => $rt,
					 id  => '28',
					)->retrieve;

my @members = $group->members();

shift @members;

print Dumper @members;

$group->members(\@members);
#$group->{members} = \@members;

$group->store();
