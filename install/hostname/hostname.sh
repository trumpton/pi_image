#!/bin/sh

echo ""
echo "=================================================="
echo ""

echo "current hostname is `hostname`"

echo "Enter new hostname: "
read HOSTNAME

echo "Updating /etc/hostname for new hostname"
sudo sh -c " echo \"$HOSTNAME\" > /etc/hostname"
sudo hostname "`cat /etc/hostname`"

echo "Updating /etc/hosts for new hostname"
HOSTSFILE=$(grep -v 127.0.1.1 /etc/hosts)
sudo sh -c "echo \"$HOSTSFILE\" > /etc/hosts" >/dev/null 2>&1
sudo sh -c "echo \"127.0.1.1	$HOSTNAME\" >> /etc/hosts" >/dev/null 2>&1

echo "hostname is now: `hostname`"

