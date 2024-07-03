#!/bin/bash

apt install proxmox-ve postfix open-iscsi chrony -y
apt remove linux-image-amd64 'linux-image-6.1*' -y
update-grub
apt remove os-prober -y

systemctl reboot
