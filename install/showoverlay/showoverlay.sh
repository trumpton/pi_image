#!/bin/bash

echo ""
echo "=================================================="
echo ""
echo "Setting login message of the day"
echo ""

cp 80-overlay /etc/update-motd.d

if [ "$(grep OVERLAY-RO /etc/skel/.bashrc)" = "" ]; then
  cat changeprompt >> /etc/skel/.bashrc
  cat changeprompt >> ~pi/.bashrc
  cat changeprompt >> ~root/.bashrc
fi

