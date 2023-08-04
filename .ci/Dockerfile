FROM rust:1.71 as build

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH=$PATH:/flutter/bin

RUN git config --global --add safe.directory /flutter

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
      libasound2-dev \
      libavahi-client-dev \
      xorg-dev \
      libgtk-3-dev \
      libclang-dev \
      libudev-dev \
      curl \
      lld \
      git \
      zip \
      unzip \
      autoconf \
      automake \
      build-essential \
      cmake \
      libass-dev \
      libfreetype6-dev \
      libgnutls28-dev \
      libsdl2-dev \
      libtool \
      libva-dev \
      libvdpau-dev \
      libvorbis-dev \
      libxcb1-dev \
      libxcb-shm0-dev \
      libxcb-xfixes0-dev \
      pkg-config \
      texinfo \
      wget \
      yasm \
      zlib1g-dev \
      nasm \
      libx264-dev \
      libx265-dev \
      libnuma-dev \
      libvpx-dev \
      libmp3lame-dev \
      libopus-dev \
      yasm && \
    rm -rf /var/lib/apt/lists/*

RUN cargo install cbindgen

ADD https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.11-stable.tar.xz /

RUN tar -xvf flutter_linux_3.7.11-stable.tar.xz && /flutter/bin/flutter precache && /flutter/bin/flutter config --enable-linux-desktop && dart pub global activate ffigen

WORKDIR /

