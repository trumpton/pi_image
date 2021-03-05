#!/bin/sh


echo ""
echo "=================================================="
echo ""
echo "Upgrading OS"
echo ""

sudo mount /boot -orw,remount
sudo mount /rootfs -orw,remount
sudo apt-get -y update && sudo apt-get -y upgrade

