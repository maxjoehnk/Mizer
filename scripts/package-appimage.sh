#!/usr/bin/env bash
set -e

# Download appimagetool if necessary
if [ ! -f appimagetool-x86_64.AppImage ]; then
	wget https://github.com/AppImage/appimagetool/releases/download/1.9.1/appimagetool-x86_64.AppImage
	chmod +x appimagetool-x86_64.AppImage
fi

mkdir Mizer.AppDir

# Unpack build application
unzip mizer.zip -d Mizer.AppDir
mv Mizer.AppDir/mizer Mizer.AppDir/AppRun
chmod +x Mizer.AppDir/AppRun

# Copy AppStream metadata
mkdir -p Mizer.AppDir/usr/share/metainfo
cp assets/me.maxjoehnk.Mizer.appdata.xml Mizer.AppDir/usr/share/metainfo/

# Move desktop file to applications folder with symlink in root
mkdir -p Mizer.AppDir/usr/share/applications
mv Mizer.AppDir/me.maxjoehnk.Mizer.desktop Mizer.AppDir/usr/share/applications/
ln -s usr/share/applications/me.maxjoehnk.Mizer.desktop Mizer.AppDir/me.maxjoehnk.Mizer.desktop

# Setup logos
mkdir -p Mizer.AppDir/usr/share/icons/hicolor/scalable/apps
mkdir -p Mizer.AppDir/usr/share/icons/hicolor/256x256/apps
cp assets/logo.svg Mizer.AppDir/usr/share/icons/hicolor/scalable/apps/me.maxjoehnk.Mizer.svg
ln -s usr/share/icons/hicolor/scalable/apps/me.maxjoehnk.Mizer.svg Mizer.AppDir/me.maxjoehnk.Mizer.svg
cp assets/logo@256.png Mizer.AppDir/usr/share/icons/hicolor/256x256/apps/me.maxjoehnk.Mizer.png
cp assets/logo@256.png Mizer.AppDir/.DirIcon

./appimagetool-x86_64.AppImage Mizer.AppDir

rm -rf Mizer.AppDir
