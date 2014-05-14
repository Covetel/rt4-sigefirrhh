#!/usr/bin/env perl
use strict;
use warnings;
use Net::SMTP;
use Data::Dumper;

my $server = "localhost";
my $cuenta = 'maria@mf.gob.ve';
my $destinatario = 'soporte@rt.mf';
my $asunto = "Solicitud de adiestramiento";
my $mensaje = "Contenido de la solicutd";
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

$smtp->datasend("Subject: $asunto\n");
$smtp->datasend("\n");
$smtp->datasend("$mensaje\n");
$smtp->dataend();
$smtp->quit;
