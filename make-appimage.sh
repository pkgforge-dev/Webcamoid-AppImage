#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q webcamoid | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/256x256/apps/webcamoid.png
export DESKTOP=/usr/share/applications/webcamoid.desktop
export DEPLOY_GSTREAMER=1

# Deploy dependencies
quick-sharun \
  /usr/bin/webcamoid \
  /usr/lib/qt/plugins/avkys/*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
