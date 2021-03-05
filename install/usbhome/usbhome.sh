#!/bin/sh

echo ""
echo "=================================================="
echo ""
echo "Mounting memory stick as /usbhome"
echo ""

# Get unmounted device name
DEVICE=$(lsblk -n -P -o mountpoint,type,path | grep MOUNTPOINT=\"\" | grep TYPE=\"part\" | cut -d= -f4 | cut -d\" -f2 | head -1)

# Check for device plugged in
if [ "$DEVICE" = "" ]; then
  echo "No Unmounted USB device detected, please ext2 format one and insert it"
  exit
fi

# Create mountpoint
sudo mkdir -p /usbhome

# Get device uuid and type
DEVICEUUID=$(lsblk -n -o partuuid $DEVICE)
DEVICEFORMAT=$(lsblk -n -o fstype $DEVICE)
echo "Found $DEVICEFORMAT Device: $DEVICE with partuuid: $DEVICEUUID"

# Append to /etc/fstab
FSTABLINE=$(grep $DEVICEUUID /etc/fstab)
if [ "$FSTABLINE" = "" ]; then
  echo "No fstab entry found, adding one"
  sudo sh -c "echo \"PARTUUID=$DEVICEUUID  /usbhome $DEVICEFORMAT defaults,noatime 0 1\" >> /etc/fstab"
fi

# Mount the disk
sudo mount /usbhome

echo "/usbhome disk mounted"


