#!/bin/sh

set -eux

ARCH="$(uname -m)"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"

VERSION="$(pacman -Q desmume | awk '{print $2; exit}')"
echo "$VERSION" > ~/version

export ADD_HOOKS="self-updater.bg.hook"
export DESKTOP=/usr/share/applications/org.desmume.DeSmuME.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/org.desmume.DeSmuME.svg
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=desmume-"$VERSION"-anylinux-"$ARCH".AppImage
export DEPLOY_PIPEWIRE=1
export DEPLOY_OPENGL=1

# Deploy dependencies
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun /usr/bin/desmume

# MAKE APPIMAGE WITH URUNTIME
wget --retry-connrefused --tries=30 "$URUNTIME" -O ./uruntime2appimage
chmod +x ./uruntime2appimage
./uruntime2appimage

# Set up the PELF toolchain
UPINFO="$(echo "$UPINFO" | sed 's#.AppImage.zsync#*.AppBundle.zsync#g')"
wget -O ./pelf "https://github.com/xplshn/pelf/releases/latest/download/pelf_$ARCH" 
chmod +x ./pelf
echo "Generating [dwfs]AppBundle...(Go runtime)"
./pelf --add-appdir ./AppDir \
	--appimage-compat \
	--add-updinfo "$UPINFO" \
	--appbundle-id="org.desmume.DeSmuME#github.com/$GITHUB_REPOSITORY:$VERSION@$(date +%d_%m_%Y)" \
	--compression "-C zstd:level=22 -S26 -B8" \
	--output-to "desmume-$VERSION-anylinux-$ARCH.dwfs.AppBundle"
zsyncmake ./*.AppBundle -u ./*.AppBundle

echo "All Done!"
