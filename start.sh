#!/bin/sh

# start.sh:

set -eu

if command -v udevd >/dev/null 2>&1; then
	udevd --daemon || true
elif [ -x /lib/systemd/systemd-udevd ]; then
	/lib/systemd/systemd-udevd --daemon || true
fi

if command -v udevadm >/dev/null 2>&1; then
	udevadm trigger || true
	udevadm settle || true
fi

if command -v udevadm >/dev/null 2>&1 && [ -S /run/udev/control ]; then
	udevadm control --reload || true
else
	echo "Skipping udev reload (no udev control socket in container)."
fi

CAMERA_OUTPUT="$(rpicam-hello --list-cameras -n -v 2>&1 || true)"
echo "$CAMERA_OUTPUT"

if echo "$CAMERA_OUTPUT" | grep -q "No cameras available"; then
	echo ""
	echo "Camera not detected from container. Check:"
	echo "1) Device config has BALENA_HOST_CONFIG_camera_auto_detect=1"
	echo "2) Camera ribbon cable orientation/connection"
	echo "3) Device rebooted after changing host config"
	exit 1
fi
