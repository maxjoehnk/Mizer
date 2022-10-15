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
	cargo build --release -p mizer

run: build
	target/debug/mizer

clean:
	rm -r artifact || exit 0
	rm mizer.zip || exit 0
	rm mizer.flatpak || exit 0

artifact:
	cargo run -p mizer-package

package-headless:
	cargo run -p mizer-package --no-default-features

build-docker:
	docker build -t mizer:latest .

mizer.zip: artifact
	zip -r mizer.zip artifact/*

flatpak: mizer.zip
	flatpak-builder --force-clean .flatpak me.maxjoehnk.Mizer.yml

flatpak-install: mizer.zip
	flatpak-builder --user --install --force-clean .flatpak me.maxjoehnk.Mizer.yml

mizer.flatpak: flatpak-install
	flatpak build-bundle ~/.local/share/flatpak/repo mizer.flatpak me.maxjoehnk.Mizer
