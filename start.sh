#!/bin/sh

# start.sh:

udevadm control --reload

libcamera-hello --list-cameras -n -v
