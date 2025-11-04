#!/bin/bash

set -e

ROOT="/workspace/openpilot"
SUDO=""

# Use sudo if not root
if [[ ! $(id -u) -eq 0 ]]; then
  if [[ -z $(which sudo) ]]; then
    echo "Please install sudo or run as root"
    exit 1
  fi
  SUDO="sudo"
fi

echo "=== Setting up Cython version constraint for PyAV compatibility ==="
# Force older Cython version compatible with av-10.0.0
export PIP_CONSTRAINT=/tmp/constraints.txt
echo "cython<3.0.0" > /tmp/constraints.txt
pip install "cython<3.0.0" setuptools-scm

echo "=== Installing Ubuntu 20.04 system dependencies ==="
$SUDO apt-get update
$SUDO apt-get install -y --no-install-recommends \
  autoconf \
  build-essential \
  ca-certificates \
  casync \
  clang \
  cmake \
  make \
  cppcheck \
  libtool \
  gcc-arm-none-eabi \
  bzip2 \
  liblzma-dev \
  libarchive-dev \
  libbz2-dev \
  capnproto \
  libcapnp-dev \
  curl \
  libcurl4-openssl-dev \
  git \
  git-lfs \
  ffmpeg \
  libavformat-dev \
  libavcodec-dev \
  libavdevice-dev \
  libavutil-dev \
  libavfilter-dev \
  libavresample-dev \
  libswscale-dev \
  libeigen3-dev \
  libffi-dev \
  libglew-dev \
  libgles2-mesa-dev \
  libglfw3-dev \
  libglib2.0-0 \
  libncurses5-dev \
  libncursesw5-dev \
  libomp-dev \
  libopencv-dev \
  libpng16-16 \
  libportaudio2 \
  libssl-dev \
  libsqlite3-dev \
  libusb-1.0-0-dev \
  libzmq3-dev \
  libsystemd-dev \
  locales \
  opencl-headers \
  ocl-icd-libopencl1 \
  ocl-icd-opencl-dev \
  clinfo \
  qml-module-qtquick2 \
  qtmultimedia5-dev \
  qtlocation5-dev \
  qtpositioning5-dev \
  qttools5-dev-tools \
  libqt5sql5-sqlite \
  libqt5svg5-dev \
  libqt5charts5-dev \
  libqt5x11extras5-dev \
  libreadline-dev \
  libdw1 \
  valgrind \
  pkg-config \
  qt5-default \
  python-dev

$SUDO rm -rf /var/lib/apt/lists/*

# Install python dependencies
echo "=== Installing Python dependencies ==="
cd $ROOT
$ROOT/update_requirements.sh

# Setup environment
source ~/.bashrc
if [ -z "$OPENPILOT_ENV" ]; then
  printf "\nsource %s/tools/openpilot_env.sh" "$ROOT" >> ~/.bashrc
  source ~/.bashrc
  echo "Added openpilot_env to bashrc"
fi

echo
echo "===================================="
echo "   DOCKER SETUP COMPLETED   "
echo "===================================="
echo "Open a new shell or configure your active shell env by running:"
echo "source ~/.bashrc"
