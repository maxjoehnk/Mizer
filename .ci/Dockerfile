FROM ubuntu:latest as deps

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt upgrade -y && apt install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev libasound2-dev libavahi-client-dev protobuf-compiler xorg-dev libgtk-3-dev curl libclang-dev cmake

RUN apt install -y git unzip

RUN git clone -b master https://github.com/flutter/flutter.git && /flutter/bin/flutter precache && /flutter/bin/flutter config --enable-linux-desktop

ENV PATH=$PATH:/flutter/bin

FROM deps as local

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

ENV PATH=$PATH:/root/.cargo/bin
