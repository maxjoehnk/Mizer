#!/usr/bin/env bash
set -e

echo "Packaging as .dmg..."
create-dmg --volname Mizer \
	--volicon "artifact/Mizer.app/Contents/Resources/AppIcon.icns" \
	--window-pos 200 120 \
	--window-size 800 400 \
	--icon-size 100 \
	--icon "Mizer.app" 200 190 \
	--hide-extension "Mizer.app" \
	--app-drop-link 600 185 \
	--codesign "$MACOS_CERTIFICATE_NAME" \
	Mizer.dmg \
	artifact
