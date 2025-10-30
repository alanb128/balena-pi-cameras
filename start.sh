#!/bin/sh

# start.sh:

udevadm control --reload

rpicam-hello --list-cameras -n -v
