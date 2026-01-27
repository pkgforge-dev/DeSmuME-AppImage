<div align="center">

# DeSmuME-AppImage 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/DeSmuME-AppImage/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/DeSmuME-AppImage/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/DeSmuME-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/DeSmuME-AppImage/releases/latest)
[![Latest Stable Release](https://img.shields.io/github/v/release/pkgforge-dev/DeSmuME-AppImage)](https://github.com/pkgforge-dev/DeSmuME-AppImage/releases/latest)

<p align="center">
  <img src="https://raw.githubusercontent.com/TASEmulators/desmume/e96b11fa27b36f6f4dabdbf405fcc7f38db8bd9f/desmume/src/frontend/posix/gtk/org.desmume.DeSmuME.svg" width="128" />
</p>

The developer is an asshole that can't be [reasoned with](https://github.com/TASEmulators/desmume/pull/723#issuecomment-2484439582).

</div>

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun) and its wrapper [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh), which makes it extremely easy to turn any binary into a portable package reliably without using containers or similar tricks. 

**This AppImage bundles everything and it should work on any Linux distro, including old and musl-based ones.**

This AppImage doesn't require FUSE to run at all, thanks to the [uruntime](https://github.com/VHSgunzo/uruntime).

This AppImage is also supplied with a self-updater by default, so any updates to this application won't be missed, you will be prompted for permission to check for updates and if agreed you will then be notified when a new update is available.

Self-updater is disabled by default if AppImage managers like [am](https://github.com/ivan-hc/AM), [soar](https://github.com/pkgforge/soar) or [dbin](https://github.com/xplshn/dbin) exist, which manage AppImage updates.

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)
