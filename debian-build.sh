#!/bin/bash

echo "deb http://deb.debian.org/debian bookworm-backports main" >> /etc/apt/sources.list
apt update
apt install -t bookworm-backports -y \
  build-essential dbus git libclang-dev libdbus-1-dev \
  libdisplay-info-dev libexpat1-dev libflatpak-dev \
  libfontconfig-dev libfreetype-dev libgbm-dev libglvnd-dev \
  libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev \
  libinput-dev libpam0g-dev libpipewire-0.3-dev libpixman-1-dev \
  libpulse-dev libseat-dev libssl-dev libsystemd-dev \
  libwayland-dev libxkbcommon-dev lld mold curl udev
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
export PATH="$HOME/.cargo/bin:$PATH"
cd /work
rustup toolchain install stable
cargo install just
git config --global --add safe.directory /work
just sysext
mkdir -p target
mv *.raw target/ || mv *.img target/ || mv *cosmic-sysext* target/ || echo "No image found"
