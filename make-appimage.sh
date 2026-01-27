#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q desmume | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export DESKTOP=/usr/share/applications/org.desmume.DeSmuME.desktop
export ICON=/usr/share/icons/hicolor/scalable/apps/org.desmume.DeSmuME.svg
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export DEPLOY_SDL=1
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun /usr/bin/desmume

# Turn AppDir into AppImage
quick-sharun --make-appimage
