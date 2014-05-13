#!/bin/bash 

# cambiar la fuente de paquetes
sudo echo "deb http://10.79.1.71:3142/ftp.debian.org/debian/ wheezy main contrib non-free" > /etc/apt/sources.list 

# actualizar 
sudo apt-get update

# instalar paquetes
sudo apt-get install debconf-utils

# respondo las preguntas del instalador de manera automática
sudo debconf-set-selections /vagrant/request-tracker4.seed

# Instalar paquetes
sudo apt-get -y install less screen git lsof vim postgresql
sudo apt-get -y install rt4-db-postgresql rt4-apache2
sudo apt-get -y install request-tracker4

# Configuraciones
rsync -av /vagrant/etc/ /etc/

# Reinicio servicios
/etc/init.d/apache2 stop
/etc/init.d/apache2 start
