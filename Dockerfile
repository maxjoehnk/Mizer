FROM rust:1.69 as base

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
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
      ffmpeg \
      libavcodec-dev \
      libavdevice-dev \
      libavfilter-dev \
      libavformat-dev \
      libavutil-dev \
      libpostproc-dev \
      libswresample-dev \
      libswscale-dev \
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
      zlib1g-dev \
      libx264-dev \
      libx265-dev \
      libnuma-dev \
      libvpx-dev \
      libmp3lame-dev \
      libopus-dev \
      libraw1394-dev \
      libdc1394-dev \
      libavc1394-dev \
      libiec61883-dev \
      libjack-dev \
      libfaad-dev \
      libgsm1-dev \
      libzmq3-dev \
      libssh-dev \
      libbluray-dev \
      libopenmpt-dev \
      ocl-icd-opencl-dev \
      libogg-dev \
      libspeex-dev \
      libtheora-dev \
      flite1-dev \
      libchromaprint-dev \
      libopenal-dev \
      libcdio-dev \
      libcaca-dev \
      libpocketsphinx-dev \
      libsphinxbase-dev \
      libbs2b-dev \
      liblilv-dev \
      libsratom-dev \
      libsord-dev \
      libserd-dev \
      librubberband-dev \
      libsamplerate0-dev \
      libmysofa-dev \
      libvidstab-dev \
      libgme-dev \
      librabbitmq-dev \
      libdav1d-dev \
      libzvbi-dev \
      libsnappy-dev \
      libaom-dev \
      libcodec2-dev \
      libshine-dev \
      libtwolame-dev \
      libwebp-dev \
      libxvidcore-dev \
      libsoxr-dev \
      libcdio-paranoia-dev \
      libcdio-cdda-dev \
      libsrt-gnutls-dev \
      libmfx-dev \
      libvorbis-dev \
      libwavpack-dev

FROM base as build

WORKDIR /build

COPY [".", "/build/"]

RUN make build-headless && make package-headless && cp -rL /build/artifact /app

FROM base

WORKDIR /app

COPY --from=build /app /app/

ENTRYPOINT ["/app/mizer"]
