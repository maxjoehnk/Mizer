FROM rust:1.70 as build

ENV DEBIAN_FRONTEND=noninteractive

ENV PATH=$PATH:/flutter/bin

RUN git config --global --add safe.directory /flutter

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
      libgstreamer1.0-dev \
      libgstreamer-plugins-base1.0-dev \
      libgstreamer-plugins-bad1.0-dev \
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
      libopus-dev && \
    rm -rf /var/lib/apt/lists/*

RUN cargo install cbindgen

ADD https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.7.11-stable.tar.xz /

RUN tar -xvf flutter_linux_3.7.11-stable.tar.xz && /flutter/bin/flutter precache && /flutter/bin/flutter config --enable-linux-desktop && dart pub global activate ffigen

WORKDIR /

# Roughly based on https://trac.ffmpeg.org/wiki/CompilationGuide/Ubuntu#FFmpeg
RUN git clone https://github.com/ffmpeg/ffmpeg --depth 1 --single-branch --branch release/6.0 && \
    cd ffmpeg && \
    PKG_CONFIG_PATH="/ffmpeg_build/lib/pkgconfig" ./configure \
      --disable-decoder=exr,phm \
      --pkg-config-flags="--static" \
      --extra-cflags="-I/ffmpeg_build/include" \
      --extra-ldflags="-L/ffmpeg_build/lib" \
      --extra-libs="-lpthread -lm" \
      --ld="g++" \
      --prefix=/ffmpeg_build && \
    make -j$(nproc) && \
    make install && \
    rm -rf /ffmpeg

ENV FFMPEG_LIBS_DIR=/ffmpeg_build/lib
ENV FFMPEG_INCLUDE_DIR=/ffmpeg_build/include
ENV FFMPEG_PKG_CONFIG_PATH=/ffmpeg_build/lib/pkgconfig
