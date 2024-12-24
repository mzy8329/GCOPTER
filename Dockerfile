FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    lsb-release \
    gnupg2 \
    curl \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y apt-utils
RUN dpkg --configure -a

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-noetic.list'
RUN curl -sSL 'http://packages.ros.org/ros.key' | apt-key add -
RUN apt-get update && apt-get install -y \
    ros-noetic-desktop-full \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    python3-rosdep \
    && rm -rf /var/lib/apt/lists/* \
    && rosdep init && rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> /etc/bash.bashrc

RUN apt-get update && apt-get install -y \
    python3-rosinstall \
    python3-rosinstall-generator \
    python3-wstool \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y cpufrequtils && apt install -y libompl-dev
# RUN cpufreq-set -g performance

WORKDIR /root/home

CMD ["bash"]
