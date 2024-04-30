#!/bin/sh

# This script will install selenium-webdriver-at-spi-run on the system
# The install will only succeed if the host has access to every package, mainly up-to-date kf6/qt6 packages from https://archive.neon.kde.org.
# Ubuntu 22.04, 22.10, 23.04 and 24.04 do not have access to every package by default, this was tested on KDE Neon.

sudo apt install -y cmake gcc g++ git ruby dh-python dh-virtualenv debhelper-compat \
                    python3-pip python3-all-dev python3-pyatspi python3-cairo python3-gi-cairo python3-virtualenv \
                    accerciser at-spi2-core gobject-introspection \
                    libgirepository1.0-dev plasma-wayland-protocols libcairo2-dev libpipewire-0.3-dev \
                    libgirepository-1.0-1 libcairo2 \
                    pkg-kde-tools-neon kf6-extra-cmake-modules kf6-kcoreaddons-dev kf6-kwindowsystem-dev kwayland6-dev qt6-base-dev qt6-base-private-dev qt6-wayland-dev libkpipewire-dev  \
                    kf6-kcoreaddons kf6-kwindowsystem kwayland6 qt6-base qt6-wayland libqt6core6 libqt6dbus6 libqt6waylandclient6 libkpipewire6

cd /tmp \
    && git clone https://invent.kde.org/sdk/selenium-webdriver-at-spi.git \
    && cd selenium-webdriver-at-spi \
    && virtualenv --system-site-packages venv \  # --system-site-packages required for pyatspi to be detected
    && source venv/bin/activate \
    && pip3 install -r requirements.txt \
    && echo export PATH="~/.local/bin:$PATH" >> ${HOME}/.bashrc \
    && mkdir build \
    && cd build \
    && cmake -DQT_MAJOR_VERSION=6 -DBUILD_WITH_QT6=ON .. \
    && make \
    && sudo make install  # sudo required to copy the files to /usr

