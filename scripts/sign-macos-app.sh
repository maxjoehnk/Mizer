#!/usr/bin/env bash
set -e

echo "Preparing keychain..."
echo "$MACOS_CERTIFICATE" | base64 --decode >certificate.p12
security create-keychain -p "$MACOS_KEYCHAIN_PASSWORD" build.keychain
security default-keychain -s build.keychain
security unlock-keychain -p "$MACOS_KEYCHAIN_PASSWORD" build.keychain
wget https://www.apple.com/certificateauthority/DeveloperIDG2CA.cer
security import DeveloperIDG2CA.cer -k build.keychain -T /usr/bin/codesign
security import certificate.p12 -k build.keychain -P "$MACOS_CERTIFICATE_PASSWORD" -T /usr/bin/codesign
security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k "$MACOS_KEYCHAIN_PASSWORD" build.keychain

echo "Signing app..."
/usr/bin/codesign --force -s "$MACOS_CERTIFICATE_NAME" --deep ./artifact/Mizer.app -v
