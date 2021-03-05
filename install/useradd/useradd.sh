#!/bin/sh

echo ""
echo "=================================================="
echo ""
echo "Setting up users"
echo ""

# Check /usbhome is mounted
if [ "$(mount | grep /usbhome)" = "" ]; then
  echo "/usbhome not mounted, unable to continue"
  exit
fi

ADMINGROUPSLIST="adm,dialout,cdrom,sudo,audio,video,plugdev,games,input,netdev,spi,i2c,gpio,users"
USERGROUPSLIST="users"

echo ""
echo "Enter the account username for a new admin user:"
read ADMINNAME
if [ "$ADMINNAME" = "" ]; then
  echo "Admin account username not supplied"
else
  if [ -d /home/$ADMINNAME ]; then
    echo "Warning: /home/$ADMINNAME exists, using it"
  fi
  if [ "$(grep "^$ADMINNAME:" /etc/passwd)" = "" ]; then
    echo "Creating user $ADMINNAME"
    sudo useradd -G $ADMINGROUPSLIST -U -m -b /home -c "Administrator" "$ADMINNAME" 
    echo "Enter a password for $ADMINNAME"
    sudo passwd $ADMINNAME
  fi
  sudo chown -R $ADMINNAME /home/$ADMINNAME
fi

echo "" 
echo "Enter the account username for a new mortal user or press Enter to skip:"
read USERNAME
if [ "$USERNAME" = "" ]; then
  echo "User Name not supplied"
else
  echo "Enter the full (readable) Name of the new motal user:"
  read USERDESC
  if [ -d /usbhome/$USERNAME ]; then
    echo "Warning: /usbhome/$USERNAME exists, using it"
  fi
  if [ "$(grep "^$USERNAME:" /etc/passwd)" = "" ]; then
    echo "Creating user $USERNAME"
    sudo useradd -G $USERGROUPSLIST -U -m -b /usbhome -c "$USERDESC" "$USERNAME"
    echo "Enter a password for $USERNAME"
    sudo passwd $USERNAME
  fi
  sudo chown -R $USERNAME /usbhome/$USERNAME
fi

# Changing Password for Pi User
echo ""
echo "Changing pi user password - this is important to ensure the device is secure"
sudo passwd pi

echo ""
echo "NOTE: It is recommended you remove the pi user"

echo ""
echo "New User Addition Complete"
