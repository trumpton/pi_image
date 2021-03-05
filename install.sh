#!/bin/bash

# Check Command Line Parameters
if [[ "$2" == "" ]]; then
  echo "install.bash raspimage.img /dev/devicename"
  exit
fi

# Check device identified
if [[ ! "$2" =~ ^/dev/[a-zA-Z0-9]+$ ]]; then
  echo "Invalid device: $2"
  exit
fi

# Get device name
DEVNAME=$(echo "$2" | cut -d/ -f3)

if [ ! -b "$2" ]; then
  echo "Device $2 does not exist"
  exit
fi
 
# Search for drive and confirm if found
DINF=$(lsblk | grep "$DEVNAME")
if [[ "$DINF" != "" ]]; then
  echo "$DINF"
  echo "type YES to confirm you wish to use this device"
  read YES
  if [[ $YES =~ ^[yY][eE][sS]$ ]]; then
    echo "Confirmed use of device $2"
  else
    echo "Aborting."
    exit
  fi
fi

# Unmount
for DEV in /dev/$DEVNAME?*
do
  echo "Unmounting $DEV"
  umount $DEV
done


# Create Image
echo "Writing image to card .... "
sudo dd if="$1" of="/dev/$DEVNAME" bs=1M
sync
echo "Write complete"

ROOTFS=/media/`whoami`/rootfs
BOOT=/media/`whoami`/boot

# Wait for disks to mount
echo "Waiting for device to mount.  If it doesn't happen automatically"
echo "after 30 seconds, remove and reinsert the card."

while [ ! -d $ROOTFS ]; do sleep 1; done
while [ ! -d $BOOT ]; do sleep 1; done


# Check for success
if [ -d "$ROOTFS" -a -d "$BOOT" ]; then
  echo "Image complete, copying files"
else
  echo "Unable to find $ROOTFS and $BOOT, exiting"
  exit
fi

echo "Transferring install scripts to $ROOTFS/home/pi"
tar cf - install | (cd $ROOTFS/home/pi ; tar xvf - )

if [ -f wpa_supplicant.conf ]; then
  echo "Copying wpa_supplicant.conf, and enabling ssh"
  cp wpa_supplicant.conf $BOOT/wpa_supplicant.conf
  touch $BOOT/ssh
else
  echo "No network configuration copied, you will have to"
  echo "login using a keyboard and HDMI monitor"
fi

echo "Modifying startup script files"


sync
sleep 10
sync

umount $ROOTFS
umount $BOOT

echo "Remove the memory card"
echo ""

echo "Ensure you have a USB stick formatted with an ext2 partition"
echo "  sudo fdisk"
echo "  sudo mkfs.ext2 /dev/usbdevicename"
echo "  sudo tune2fs -L usbhome /dev/usbdevicename"
echo "  sync"
echo ""

echo "Plug the USB stick and memory card into the Pi"
echo "and boot it"

echo "Log In: 'ssh -l pi raspberrypi.local' (password=raspberry)"
echo "Initialse: 'install/install.sh"
echo "Reboot"
echo ""
echo "Log In: 'ssh -l newadminname newhostname.local'"
echo "Remove pi user: sudo userdel -r pi"
echo ""
echo "Install other software"
echo ""
echo "Make disk read-only: sudo overctl -r"
echo "Reboot"
echo ""


