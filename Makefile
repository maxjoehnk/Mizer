mizer: test build-headless build

test:
	cargo test --workspace

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

package:
	ls -l target/release
	cargo run -p mizer-package
