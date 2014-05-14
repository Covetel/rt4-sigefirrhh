#!/usr/bin/env perl
use strict;
use warnings;
use Net::SMTP;
use Data::Dumper;

my $server = "localhost";
my $cuenta = 'maria@mf.gob.ve';
my $destinatario = 'soporte@rt.mf';
my $asunto = "Mi version de Sigefirrhh es la 2.1";
my $mensaje = "mi version de sigefirrhh des la 2.1";
my $smtp;

$smtp = new Net::SMTP($server, 
    Hello => 'localhost', 
    Port  => 1025, 
    Debug => 1,
);

$smtp->mail($cuenta);
$smtp->to($destinatario);
$smtp->data;
$smtp->datasend("To: $destinatario\n");
$smtp->datasend("From: $cuenta");
$smtp->datasend("\n");

$smtp->datasend("Subject: [Soporte Digemafe #6]\n");
$smtp->datasend("\n");
$smtp->datasend("$mensaje\n");
$smtp->dataend();
$smtp->quit;
