FROM rust:1.85 as build

ARG FLUTTER_VERSION=3.13.2-stable

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH=$PATH:/flutter/bin:/.cargo/bin

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

ADD https://github.com/protocolbuffers/protobuf/releases/download/v23.4/protoc-23.4-linux-x86_64.zip /tmp/protoc.zip
RUN unzip /tmp/protoc.zip -d /usr/local

RUN cargo install cbindgen && cargo install nextest

ADD https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$FLUTTER_VERSION.tar.xz /

RUN tar -xvf flutter_linux_$FLUTTER_VERSION.tar.xz && /flutter/bin/flutter precache && /flutter/bin/flutter config --enable-linux-desktop && dart pub global activate ffigen

WORKDIR /

