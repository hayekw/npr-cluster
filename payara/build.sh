#!/usr/bin/env bash
echo "Please specify the password for the web console of this Payara installation: "
read -s PASSWORD
echo "export PASSWORD="$PASSWORD > ./passfile
source ./passfile
sudo docker build -t docker-payaraserver-full --build-arg PASSWORD=$PASSWORD .
# clear the passfile content
echo "export PASSWORD=" > ./passfile
source ./passfile
