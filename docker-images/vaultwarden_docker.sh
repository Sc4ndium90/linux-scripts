#!/bin/bash

echo "Installing Vaultwarden Docker Image"

docker pull vaultwarden/server:latest
docker run -d --name vaultwarden -v /vw-data/:/data/ --restart unless-stopped -p 80:80 vaultwarden/server:latest

echo "Installation done"
