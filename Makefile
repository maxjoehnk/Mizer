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
	@echo "Extracting packaged app..."
	mkdir to_be_bundled
	unzip mizer.zip -d to_be_bundled
	# TODO: Move settings file into Resources
	rm to_be_bundled/Mizer.app/Contents/MacOS/settings.toml

	./scripts/sign-macos-app.sh
	./scripts/notarize-macos-app.sh
	./scripts/package-dmg.sh

	@echo "Cleaning up..."
	rm -rf to_be_bundled

Mizer_unsigned.dmg: mizer.zip
	rm -rf to_be_bundled
	mkdir to_be_bundled
	unzip mizer.zip -d to_be_bundled
	create-dmg --volname Mizer \
		--volicon "artifact/Mizer.app/Contents/Resources/AppIcon.icns" \
		--window-pos 200 120 \
     	--window-size 800 400 \
  		--icon-size 100 \
  		--icon "Mizer.app" 200 190 \
  		--hide-extension "Mizer.app" \
  		--app-drop-link 600 185 \
  		Mizer_unsigned.dmg \
	 	to_be_bundled
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
