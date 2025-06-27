#!/bin/sh

set -eu

PACKAGE=desmume
DESKTOP=org.desmume.DeSmuME.desktop
ICON=org.desmume.DeSmuME.svg
TARGET_BIN="$PACKAGE"

export ARCH="$(uname -m)"
export APPIMAGE_EXTRACT_AND_RUN=1
export VERSION="$(pacman -Q "$PACKAGE" | awk 'NR==1 {print $2; exit}')"
echo "$VERSION" > ~/version

UPINFO="gh-releases-zsync|$(echo "$GITHUB_REPOSITORY" | tr '/' '|')|latest|*$ARCH.AppImage.zsync"
LIB4BN="https://raw.githubusercontent.com/VHSgunzo/sharun/refs/heads/main/lib4bin"
URUNTIME="https://github.com/VHSgunzo/uruntime/releases/latest/download/uruntime-appimage-dwarfs-$ARCH"

# Prepare AppDir
mkdir -p ./AppDir/shared/lib
cd ./AppDir
cp /usr/share/applications/"$DESKTOP"             ./
cp /usr/share/icons/hicolor/scalable/apps/"$ICON" ./
cp /usr/share/icons/hicolor/scalable/apps/"$ICON" ./.DirIcon

# ADD LIBRARIES
wget "$LIB4BN" -O ./lib4bin
chmod +x ./lib4bin
xvfb-run -a -- ./lib4bin -p -v -e -s -k \
	/usr/bin/"$TARGET_BIN"* \
	/usr/lib/libGLX* \
	/usr/lib/libGL.so* \
	/usr/lib/libXss.so* \
	/usr/lib/gio/modules/* \
	/usr/lib/alsa-lib/* \
	/usr/lib/pulseaudio/* \
	/usr/lib/pipewire-0.3/* \
	/usr/lib/spa-0.2/*/*
	
# Prepare sharun
echo "Preparing sharun..."
ln ./sharun ./AppRun
./sharun -g

# MAKE APPIMAGE WITH URUNTIME
cd ..
wget "$URUNTIME" -O ./uruntime
chmod +x ./uruntime

#Add udpate info to runtime
echo "Adding update information \"$UPINFO\" to runtime..."
./uruntime --appimage-addupdinfo "$UPINFO"

echo "Generating AppImage..."
./uruntime --appimage-mkdwarfs -f \
	--set-owner 0 --set-group 0 \
	--no-history --no-create-timestamp \
	--compression zstd:level=22 -S26 -B8 \
	--header uruntime \
	-i ./AppDir -o "$PACKAGE"-"$VERSION"-anylinux-"$ARCH".AppImage

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
	--output-to "$PACKAGE-$VERSION-anylinux-$ARCH.dwfs.AppBundle"

echo "Generating zsync file..."
zsyncmake *.AppImage -u *.AppImage
zsyncmake *.AppBundle -u *.AppBundle

echo "All Done!"
