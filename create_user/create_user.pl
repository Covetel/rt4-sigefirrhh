#!/usr/bin/env perl 
use common::sense; 
use Digest::MD5 qw(md5 md5_hex md5_base64);
use Covetel::LDAP;
use Covetel::LDAP::OpenLDAP;
use Data::Dumper;

my $config = shift || 'create_user.ini';

my $ldap = Covetel::LDAP::OpenLDAP->new({config => $config});

die "no pudo conectarse al LDAP" unless $ldap->bind;

my $rama_people = $ldap->{config}->{ldap}->{people_rdn} || 'people';

#Datos del Usuario
my $uid = $ldap->{config}->{person}->{uid};
my $cn = $ldap->{config}->{person}->{cn};
my $sn = $ldap->{config}->{person}->{sn};
my $ced = $ldap->{config}->{person}->{ced};
my $u_pass = $ldap->{config}->{person}->{u_pass};
my $uid_number = $ldap->{config}->{person}->{uid_number};

# Valido si el usuario existe 
my $resp = $ldap->search({
            filter => "(&(objectClass=posixAccount)(uid=$uid))",
            base => $ldap->base_people,
});

# Creo el usuario sino existe
unless ($resp->count){
    my $dn_user = 'uid=' . $uid . ',' . $ldap->base_people;

    my $password = &password($u_pass);

    my $entry = Net::LDAP::Entry->new;

    $entry->dn($dn_user);

    my @objectClass = qw(top inetOrgPerson);

    $entry->add(ObjectClass => [@objectClass]);

    $entry->add(
        uid => $uid,
        cn => $cn,
        sn => $sn,
        pager => $ced,
    );

    $entry->add(
        userPassword => $password,
    );

	my $mesg = $entry->update($ldap->{server});

	if ($mesg->is_error) {
        print "Hubo un error al crear el usuario ".$uid."\n";
        print Dumper($mesg)
	}else{
        print "Entrada Creada ".$uid."\n";
	}
} else {
    print "El usuario ".$uid ." ya existe";
}

# Metodo para codificar el password
sub password {
    my ($password) = @_; 
    my $p = md5_base64($password);
    $p = "{MD5}".$p."==";
    
    return $p;
}

=head1 create_user.pl

Script que crea usuario en el LDAP haciendo uso del archivo script.ini y envia un correo de notificación, para utilizarlo ejecutar:

    $ perl create_user.pl

=head2 Formato de archivo script.ini

    [ldap]
    host = localhost 
    port = 389
    user = cn=admin,dc=example,dc=com
    passwd = 123321...
    base = dc=example,dc=com
    people_rdn = ou=people
    groups_rdn = ou=groups
    #tls = 0

    #Datos de la persona
    [person]
    uid = pperez
    cn = Pedro
    sn = Perez
    ced = 1234567
    u_pass = 123456
=cut
