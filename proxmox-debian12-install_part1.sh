#!/bin/bash

apt install wget

echo "pve" >> /etc/hostname
echo "<IP> pve" >> /etc/hosts

echo "deb [arch=amd64] http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg 
sha512sum /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg 

apt update && apt full-upgrade
sudo dpkg --purge --force-all firmware-ath9k-htc
sudo apt --fix-broken install

apt install proxmox-default-kernel
systemctl reboot
