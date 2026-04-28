#!/bin/sh

echo "Installing and copying imx500 firmware..."
sleep 3
apt install -y imx500-all
cp /lib/firmware/imx500*.fpk /extra-firmware/
cp /lib/firmware/*.bin /extra-firmware/
echo "Now reboot the device to load the firmware" 
