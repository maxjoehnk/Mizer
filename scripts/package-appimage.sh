#!/usr/bin/env bash
set -e

if [ ! -f appimagetool-x86_64.AppImage ]; then
  wget https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage
  chmod +x appimagetool-x86_64.AppImage
fi

mkdir Mizer.AppDir

cp -aL artifact/* Mizer.AppDir/
mv Mizer.AppDir/mizer Mizer.AppDir/AppRun

./appimagetool-x86_64.AppImage Mizer.AppDir

rm -rf Mizer.AppDir
