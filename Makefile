.PHONY: mizer test benchmarks build-headless build build-release run clean flatpak

mizer: test build-headless build

test:
	cargo nextest run --workspace

benchmarks:
	cargo bench --no-default-features --benches --workspace

oscillator_nodes_benchmarks:
	cargo bench --no-default-features --bench oscillator_nodes

build-headless:
	cargo build --release --no-default-features --features build-ffmpeg

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
	zip -r mizer.zip artifact/*

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
