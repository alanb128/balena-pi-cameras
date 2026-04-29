#!/bin/sh

# This script installs Picamera2 and runs a quick Python script to confirm the imx500 camera is working.
# Picamera2 is the libcamera-based replacement for Picamera

# The Picamera2 documentation recommends installing through apt rather than pip 
# to ensure compatibility with underlying libcamera libraries.
# (https://datasheets.raspberrypi.com/camera/picamera2-manual.pdf)

apt install -y python3-picamera2 --no-install-recommends

apt install -y python3-opencv python3-munkres

# running the script with the same Python interpreter where the module above is installed:
/usr/bin/python3 imx500_classification_demo_headless.py

