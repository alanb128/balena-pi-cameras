# balena-pi-ai-cam
Example of running the Raspberry Pi AI Camera in a container on balena

<img src="pi-ai-balena.jpg">

## Hardware
This was tested on a Pi 4 and a Pi 5 with camera module 2, 3, and the Pi AI camera module, using balenaOS version balenaOS 6.5.24+rev4

## Settings

It is recommended to use the camera auto detect by setting `BALENA_HOST_CONFIG_camera_auto_detect` to `1` in the custom configuration section of the Device configuration tab.

Alternatively, add a DT overlay for the camera model in use:
 - V2: "imx219"
 - V3: "imx708"
 - AI: "imx500" (I was only able to auto detect this camera, this DT overlay did not work on balenaOS)

## Software

Create a fleet in balenaCloud and push this repo. Flash a Pi 4 or Pi 5 with balenaOS from the fleet.

If you have a Pi AI camera (IMX500) follow these steps:

- Using the terminal, run ./install.sh which installs the IMX 500 firmware and software (the firmware has access to `/lib/firmware/` via the docker compose label)

- After installing the firmware, reboot the device from the dashboard

For all camera models: 

- After rebooting, go back to the terminal and run the ./start.sh script which should display any detected cameras.

For the AI camera, you should see something like this:

```
Available cameras
-----------------
0 : imx500 [4056x3040 10-bit RGGB] (/base/axi/pcie@1000120000/rp1/i2c@88000/imx500@1a)
    Modes: 'SRGGB10_CSI2P' : 2028x1520 [30.02 fps - (0, 0)/4056x3040 crop]
                             4056x3040 [10.00 fps - (0, 0)/4056x3040 crop]

    Available controls for 4056x3040 SRGGB10_CSI2P mode:
    ----------------------------------------------------
```

## Troubleshooting

If your Pi AI camera is not detected, check that it has at least firmware version 15. You'll need to do that using Raspberry Pi OS. The process to check the camera's firmware and update it is outlined here: https://forums.raspberrypi.com/viewtopic.php?t=378050#p2260801

You may also need to increase GPU memory to 64 or 128 MB.

## Resources Used

- To build the rpicam apps: https://www.raspberrypi.com/documentation/computers/camera_software.html#building-rpicam-apps-without-building-libcamera
- For bind mounting the firmware folder into the container: https://forums.balena.io/t/how-to-mount-lib-firmware-rw/2949
- Example of adding Pi OS elements to a Debian image: https://github.com/hyzhak/pi-camera-in-docker/blob/main/Dockerfile
