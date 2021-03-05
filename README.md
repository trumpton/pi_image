
           INSTALL INSTRUCTIONS FOR RASPBERRY PI OPERATING
                      SYSTEM WITH OVERLAY CONTROL

These instructions enable a Raspberry Pi to be configured with a ramdisk
overlay, thereby protecting the underlying OS memory card from corruption

They contain scripts which are designed to run on a linux host system to
initialise and pre-install the memory card.

In addition to setting up the machine, they also allow for a usb device to
be mounted which contains the user home directories.

The script has been tested on Ubuntu Studio 20.

INGREDIENTS
===========

1 Raspberry Pi
1 Pi Memory Card
1 USB Memory Stick

METHOD
======

1. Preparing the USB Stick
--------------------------

Ensure that the USB memory stick is formatted for use on a Linux operating 
system, ideally with the ext2 disk format.

For this, use the fdisk and the mkfs.ext2 programs.


2. Downloading the Raspberry Pi OS
----------------------------------

Download the latest Raspberry Pi OS Lite from

    https://www.raspberrypi.org/software/operating-systems/

And unpack the file to reveal the .img data file


3. Setting up your Network
--------------------------

Generate wpa_supplicant.conf, and edit it to configure your wireless network.

    cp wpa_supplicant.conf.org wpa_supplicant.conf
    vi wpa_supplicant.conf


4. Formatting and Installing
----------------------------

Insert the micro-SD memory card for the Pi into a Linux PC, and identify
which device it appears as.  You can wait for it to auto-mount (if it has 
been previously used), or use the lsblk or dmesg program.

Run the setup script, e.g.:

    ./install.sh 2021-01-11-raspios-buster-armhf-lite.img /dev/sda
    
    - Note that the img file and the /dev/sda may be different for you.

On completion, the disk can be removed and installed into the Pi


5. Booting the Pi
-----------------

Install both the memory card and the USB stick into the Pi and boot it.
Wait for a couple of minutes, and attempt to connect to if from your Linux
machine:

    ssh -l pi raspberrypi.local
    password: raspberry

    - Note that the ssh may complain if you have previously configured a
      different pi, in which case you should follow the ssh-keygen advice
      which is presented.


6. Configuring the Pi
---------------------

Configure the Pi by running the install script, which will set up the overlay
control, change the device name and set up a default admin user and normal
user:

    install/install.sh

Follow the prompts.


7. Reboot the Pi
----------------

Reboot the pi with "sync ; sudo reboot" and then log back in with ssh.  This 
time you will need to use the new device name and the administration account.

Remove the pi user:

    deluser -r pi


8. Install Other Software
-------------------------

Install any other software you will need to use on the Pi.


9. Enable Overlay
-----------------

Enable the overlay and reboot:

    sudo overctl -r
    sync ; sudo reboot


