#!/bin/sh

set -eux

EXTRA_PACKAGES="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/get-debloated-pkgs.sh"

echo "Installing dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel       \
	desmume          \
	git              \
	libdecor         \
	libxss           \
	patchelf         \
	pipewire-audio   \
	pulseaudio       \
	pulseaudio-alsa  \
	strace           \
	wget             \
	xorg-server-xvfb \
	zsync

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$EXTRA_PACKAGES" -O ./get-debloated-pkgs.sh
chmod +x ./get-debloated-pkgs.sh
./get-debloated-pkgs.sh --add-opengl gtk3-mini libxml2-mini opus-mini gdk-pixbuf2-mini librsvg-mini
