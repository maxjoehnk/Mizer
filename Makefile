.PHONY: mizer test benchmarks build-headless build build-release run clean flatpak

mizer: test build-headless build

test:
	cargo nextest run --workspace

benchmarks:
	cargo bench --no-default-features --benches --workspace

oscillator_nodes_benchmarks:
	cargo bench --no-default-features --bench oscillator_nodes

fixtures_benchmarks:
	cargo bench --no-default-features -p mizer-fixtures --bench fixtures

build-headless:
	cargo build --release --no-default-features --features build-ffmpeg -p mizer

build:
	cd crates/ui && make
	cargo build -p mizer

build-release:
	cd crates/ui && make release
	cargo build --no-default-features --features ui --features build-ffmpeg --release -p mizer

run: build
	target/debug/mizer

clean:
	rm -rf artifact
	rm -f mizer.zip
	rm -f mizer.flatpak

artifact: build-release
	cargo run -p mizer-package

package-headless:
	cargo run -p mizer-package --no-default-features

build-docker:
	docker build -t mizer:latest .

mizer.zip: artifact
	cd artifact && zip -r ../mizer.zip *

Mizer.dmg: mizer.zip
	echo "Extracting packaged app..."
	mkdir to_be_bundled
	unzip mizer.zip -d to_be_bundled

	echo "Signing app..."
	echo $MACOS_CERTIFICATE | base64 --decode > certificate.p12
	security create-keychain -p "$MACOS_KEYCHAIN_PASSWORD" build.keychain
	security default-keychain -s build.keychain
	security unlock-keychain -p "$MACOS_KEYCHAIN_PASSWORD" build.keychain
	security import certificate.p12 -k build.keychain -P "$MACOS_CERTIFICATE_PASSWORD" -T /usr/bin/codesign
	security set-key-partition-list -S apple-tool:,apple:,codesign: -s -k "$MACOS_KEYCHAIN_PASSWORD" build.keychain

	/usr/bin/codesign --force -s "$MACOS_CERTIFICATE_NAME" ./to_be_bundled/Mizer.app -v

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
	 	to_be_bundled

	echo "Cleaning up..."
	rm -rf to_be_bundled

build-in-docker:
	./.ci/test-local.sh

flatpak:
	flatpak-builder --install-deps-from=flathub --force-clean .flatpak flatpak/me.maxjoehnk.Mizer.yml

flatpak-install:
	flatpak-builder --install-deps-from=flathub --user --install --force-clean .flatpak flatpak/me.maxjoehnk.Mizer.yml

mizer.flatpak: flatpak-install
	flatpak build-bundle ~/.local/share/flatpak/repo mizer.flatpak me.maxjoehnk.Mizer

bdd-tests: mizer.zip
	cd tests && pipenv run behave
