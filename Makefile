mizer: test build-headless build

test:
	cargo test --workspace

benchmarks:
	cargo bench --workspace

build-headless:
	cargo build --release --no-default-features

build:
	cd ui && make
	cargo build --all-features
