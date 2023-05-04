.PHONY: mizer test benchmarks build-headless build build-release run clean flatpak

mizer: test build-headless build

test:
	cargo nextest run --workspace

benchmarks:
	cargo bench --workspace

build-headless:
	cargo build --release --no-default-features

build:
	cd ui && make
	cargo build -p mizer

build-release:
	cd ui && make release
	cargo build ---no-default-features --features ui --release -p mizer

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
	zip -r mizer.zip artifact/*

build-in-docker:
	./.ci/test-local.sh

flatpak:
	flatpak-builder --install-deps-from=flathub --force-clean .flatpak flatpak/me.maxjoehnk.Mizer.yml

flatpak-install:
	flatpak-builder --install-deps-from=flathub --user --install --force-clean .flatpak flatpak/me.maxjoehnk.Mizer.yml

mizer.flatpak: flatpak-install
	flatpak build-bundle ~/.local/share/flatpak/repo mizer.flatpak me.maxjoehnk.Mizer
