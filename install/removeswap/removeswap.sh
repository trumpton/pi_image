#!/bin/sh

echo ""
echo "=================================================="
echo ""
echo "Disabling swapfile"
echo ""

sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d dphys-swapfile remove


