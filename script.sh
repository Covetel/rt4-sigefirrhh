#!/bin/bash 

# cambiar la fuente de paquetes
sudo echo "deb http://10.79.1.71:3142/ftp.debian.org/debian/ wheezy main contrib non-free" > /etc/apt/sources.list 

# actualizar 
sudo apt-get update

# instalar paquetes
sudo apt-get -y install less screen git lsof vim postgresql
sudo apg-get -y install request-tracker4  rt4-db-postgresql  rt4-fcgi
