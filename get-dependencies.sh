#!/bin/sh

set -ex

sed -i 's/DownloadUser/#DownloadUser/g' /etc/pacman.conf

if [ "$(uname -m)" = 'x86_64' ]; then
	PKG_TYPE='x86_64.pkg.tar.zst'
else
	PKG_TYPE='aarch64.pkg.tar.xz'
fi

OPUS_URL="https://github.com/pkgforge-dev/llvm-libs-debloated/releases/download/continuous/opus-nano-$PKG_TYPE"

echo "Installing dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
	base-devel \
	curl \
	desktop-file-utils \
	desmume \
	git \
	mesa \
	patchelf \
	pulseaudio \
	pulseaudio-alsa \
	strace \
	wget \
	xorg-server-xvfb \
	zsync

echo "Installing debloated pckages..."
echo "---------------------------------------------------------------"
wget --retry-connrefused --tries=30 "$OPUS_URL" -O ./opus-nano.pkg.tar.zst

pacman -U --noconfirm ./*.pkg.tar.zst
rm -f ./*.pkg.tar.zst

echo "All done!"
echo "---------------------------------------------------------------"
