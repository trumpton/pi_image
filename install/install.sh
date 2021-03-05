(cd /home/pi/install/upgrade ; sudo ./upgrade.sh)
(cd /home/pi/install/overlayfs ; sudo ./overlayfs.sh)
(cd /home/pi/install/removeswap ; sudo ./removeswap.sh)
(cd /home/pi/install/showoverlay ; sudo ./showoverlay.sh)
(cd /home/pi/install/usbhome ; sudo ./usbhome.sh)
(cd /home/pi/install/hostname ; sudo ./hostname.sh)
(cd /home/pi/install/useradd ; sudo ./useradd.sh)
sudo overctl -w
sync
ADMINUSER=$(grep ":Administrator:" /etc/passwd | cut -d: -f1)
HOSTNAME=$(hostname)
echo "Now reboot, and connect again with 'ssh -l $ADMINUSER $HOSTNAME.local'"

echo "Press ENTER to reboot"
read ENTER

sudo reboot
