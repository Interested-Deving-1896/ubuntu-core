# Ubuntu 22.04, 23.10, 24.04 do not work
FROM ubuntu:22.04
WORKDIR /seleniumtest

# Name of the application contained in the testsnap.snap. We need it to manually connect kf6-core22.
# `docker build --build-arg SNAP_NAME=kcalc .`
#ARG SNAP_NAME=kcalc

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
ENV container docker
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt update  \
    && apt upgrade -y \
    && apt install -y cmake gcc g++ git ruby dh-python dh-virtualenv debhelper-compat sed \
                      python3-pip python3-all-dev python3-pyatspi python3-cairo python3-gi-cairo python3-virtualenv \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 444DABCF3667D0283F894EDDE6D4736255751E5D \
    && echo "deb [ arch=amd64,arm64 ] https://archive.neon.kde.org/user jammy main" | tee /etc/apt/sources.list.d/kde-neon.list \
    && apt update  \
    && apt install -y accerciser at-spi2-core gobject-introspection \
                      libgirepository1.0-dev plasma-wayland-protocols libcairo2-dev libpipewire-0.3-dev \
                      libgirepository-1.0-1 libcairo2 \
                      pkg-kde-tools-neon kf6-extra-cmake-modules kf6-kcoreaddons-dev kf6-kwindowsystem-dev kwayland6-dev qt6-base-dev qt6-base-private-dev qt6-wayland-dev libkpipewire-dev  \
                      kf6-kcoreaddons kf6-kwindowsystem kwayland6 qt6-base qt6-wayland libqt6core6 libqt6dbus6 libqt6waylandclient6 libkpipewire6

# Installing selenium
RUN cd /tmp \
    && git clone https://invent.kde.org/sdk/selenium-webdriver-at-spi.git \
    && cd selenium-webdriver-at-spi \
    && sed -i 's/ORG_KDE_KWIN_FAKE_INPUT_DESTROY_SINCE_VERSION/ORG_KDE_KWIN_FAKE_INPUT_BUTTON_SINCE_VERSION/g' inputsynth/interaction.cpp \
    && pip3 install -r requirements.txt \
    && echo export PATH="~/.local/bin:$PATH" >> ${HOME}/.bashrc \
    && mkdir build \
    && cd build \
    && cmake -DQT_MAJOR_VERSION=6 -DBUILD_WITH_QT6=ON .. \
    && make \
    && make install

# Copying test files
COPY ./testsnap.snap /seleniumtest/
COPY ./testsuite.py /seleniumtest/
RUN chmod +x testsuite.py

# Attempt to get snapd to run in the final container
RUN apt install -y fuse snapd squashfuse sudo init \
    && apt clean \
    && dpkg-divert --local --rename --add /sbin/udevadm \
    && ln -s /bin/true /sbin/udevadm \
    && systemctl enable snapd
VOLUME ["/sys/fs/cgroup"]
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]

# Ideally we would only want to run this, but snapd cannot run without systemd
#RUN apt install -y snapd
#RUN snap install kf6-core22
#RUN snap install --dangerous testsnap.snap
#RUN snap connect $SNAP_NAME:kf6-core22 kf6-core22:kf6-core22
#CMD ["/bin/bash", "-c", "selenium-webdriver-at-spi-run testsuite.py"]
