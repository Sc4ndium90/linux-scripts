#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${GREEN}Installing GLPI Docker Image${NC}"

echo "Configuration of MariaDB Server"
read -p "Database Name [glpi]" MARIADB_DATABASE

if [ -z "$MARIADB_DATABASE" ];
then
   $MARIADB_DATABASE="glpi"
fi

read -p "Root Password [glpi]" MARIADB_ROOT_PASSWORD

if [ -z "$MARIADB_ROOT_PASSWORD" ];
then
   $MARIADB_ROOT_PASSWORD="glpi"
fi

read -p "User Name [glpi]" MARIADB_USER

if [ -z "$MARIADB_USER" ];
then
   $MARIADB_USER="glpi"
fi

read -p "User Password [glpi]" MARIADB_PASSWORD

if [ -z "$MARIADB_PASSWORD" ];
then
   $MARIADB_PASSWORD="glpi"
fi

mkdir glpi-docker && cd glpi-docker
touch mariadb.env

# Output the variables into a file named mariadb.env
echo "MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD" > mariadb.env
echo "MARIADB_DATABASE=$MARIADB_DATABASE" >> mariadb.env
echo "MARIADB_USER=$MARIADB_USER" >> mariadb.env
echo "MARIADB_PASSWORD=$MARIADB_PASSWORD" >> mariadb.env

echo "${GREEN}MariaDB Configuration Done${NC}"

echo "Configuration of Docker Compose File"
read -p "Specify the timezone (Europe/Paris i.e) [Europe/Paris]" TIMEZONE

if [ -z "$TIMEZONE" ];
then
   $TIMEZONE="Europe/Paris"
fi

# Output docker compose file configuration
echo "version: \"3.2\"

services:
  mariadb:
    image: mariadb:10.7
    container_name: mariadb
    hostname: mariadb
    volumes:
      - /var/lib/mysql:/var/lib/mysql
    env_file:
      - ./mariadb.env
    restart: always

  glpi:
    image: diouxx/glpi
    container_name: glpi
    hostname: glpi
    ports:
      - \"80:80\"
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - /var/www/html/glpi/:/var/www/html/glpi
    environment:
      - TIMEZONE=$TIMEZONE
    restart: always" > docker-compose.yml

echo "${GREEN} File docker-compose.yml is written, starting compose..${NC}"

docker compose -p glpi up -d
