FROM balenalib/raspberrypi5-debian-python:bookworm-build

# Next three lines courtesy of https://github.com/hyzhak/pi-camera-in-docker/blob/main/Dockerfile

# Mimic Pi OS:
RUN apt update && apt install -y --no-install-recommends gnupg

RUN echo "deb http://archive.raspberrypi.org/debian/ bookworm main" > /etc/apt/sources.list.d/raspi.list \
  && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 82B129927FA3303E

RUN apt update && apt -y full-upgrade

# Install rpicam apps prereqs

RUN apt install -y libcamera-dev libepoxy-dev libjpeg-dev libtiff5-dev libpng-dev \
    cmake libboost-program-options-dev libdrm-dev libexif-dev meson ninja-build

WORKDIR /usr/src

# Clone and build rpicam apps

RUN git clone https://github.com/raspberrypi/rpicam-apps.git && cd /usr/src/rpicam-apps && \
    meson setup build -Denable_libav=disabled -Denable_drm=enabled -Denable_egl=disabled -Denable_qt=disabled -Denable_opencv=disabled -Denable_tflite=disabled -Denable_hailo=disabled && meson compile -C build && meson install -C build && ldconfig

ENV UDEV=on

COPY *.sh ./

CMD ["sleep", "infinity"]
