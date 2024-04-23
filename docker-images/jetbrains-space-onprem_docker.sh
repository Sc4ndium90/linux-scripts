#!/bin/bash

# Color variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "Installing Jetbrains Space On-Premise on Docker.."

echo "Checking if Docker and Docker Compose plugin are installed"
# Check if Docker is installed
if command -v docker &> /dev/null; then
    echo "${GREEN}> Docker is installed.${NC}"
else
    echo "${RED}> Docker is not installed.${NC}"
    exit 1
fi

mkdir -p space-on-premises && cd space-on-premises

export SPACE_RELEASE_NAME="2024.1.0"
curl -O "https://assets.on-premises.service.jetbrains.space/${SPACE_RELEASE_NAME}/docker-compose.yml"

docker compose -p space-on-premises up -d
docker ps

echo "${GREEN}Installation done${NC}"
