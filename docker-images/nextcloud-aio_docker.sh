#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "${GREEN}Installing Nextcloud All-In-One Docker image${NC}"

echo "Please type the location where the files from Nextcloud will be stored"
read dirname

# Check if the entered location is a directory
if [ -d "$dirname" ]; then
    echo "${GREEN}> Folder '$dirname' exists.${NC}"
    # You can continue with further processing here
else
    echo "${RED}> Folder '$dirname' does not exist or is not a directory.${NC}"
    exit 1
fi

sudo docker run -it \
--name nextcloud-aio-mastercontainer \
--restart always \
-p 80:80 \
-p 8080:8080 \
-p 8443:8443 \
--volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
-e NEXTCLOUD_DATADIR="$dirname" \
--volume /var/run/docker.sock:/var/run/docker.sock:ro \
nextcloud/all-in-one:latest
