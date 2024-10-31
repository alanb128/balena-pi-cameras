# balena-pi-ai-cam
Example of running the Raspberry Pi AI Camera in a container on balena

<img src="pi-ai-balena.jpg">

## Hardware
This was tested on a Pi 4 and a Pi 5 with camera module 3 and the Pi AI camera module.

**NOTE: As of now, the camera module 3 is detected and the rpicam apps work, however the AI Camera Module is not detected - still a work in progress!**

## Software

Create a fleet in balenaCloud and push this repo. Flash a Pi 4 or Pi 5 with balenaOS from the fleet.

- Using the terminal, run ./install.sh which installs the IMX 500 firmware and software (the firmware has access to `/lib/firmware/` via the docker compose label)

- After installing the firmware, reboot the device from the dashboard

- After rebooting, go back to the terminal and run the ./start.sh script which should display any detected cameras.

The camera module 2/3 is detected, the Pi AI Camera is not.

Troubleshooting steps taken so far:

- Increased GPU memory to 128MB
- Added "imx500" dtoverlay
- Tried cam0 and cam1 connectors on Pi 5
- Tried a Pi 4

