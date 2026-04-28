FROM python:3.14-trixie


# Mimic Pi OS:
RUN apt update && apt install -y --no-install-recommends gnupg gpgv 
RUN curl -fsSL https://archive.raspberrypi.com/debian/raspberrypi.gpg.key | gpg --dearmor -o /usr/share/keyrings/raspberrypi-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/raspberrypi-archive-keyring.gpg] https://archive.raspberrypi.com/debian/ trixie main" > /etc/apt/sources.list.d/raspi.list \
    && echo 'APT::Key::gpgvcommand "/usr/bin/gpgv";' > /etc/apt/apt.conf.d/99gpgv

RUN apt update && apt -y full-upgrade

# Install rpicam apps prereqs

RUN apt install -y libcamera-dev libepoxy-dev libjpeg-dev libtiff5-dev libpng-dev \
    cmake libboost-program-options-dev libdrm-dev libexif-dev meson ninja-build udev

WORKDIR /usr/src

# Clone and build rpicam apps

RUN git clone https://github.com/raspberrypi/rpicam-apps.git && cd /usr/src/rpicam-apps && \
    meson setup build -Denable_libav=disabled -Denable_drm=enabled -Denable_egl=disabled -Denable_qt=disabled -Denable_opencv=disabled -Denable_tflite=disabled -Denable_hailo=disabled && meson compile -C build && meson install -C build && ldconfig

ENV UDEV=on

COPY *.sh ./
COPY *.py ./

CMD ["sleep", "infinity"]
