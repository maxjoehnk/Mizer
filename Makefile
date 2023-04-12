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
	cargo run -p mizer-package

package-headless:
	cargo run -p mizer-package --no-default-features

build-docker:
	docker build -t mizer:latest .
