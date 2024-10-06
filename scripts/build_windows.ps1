# Build FFI and prepare flutter assets
Write-Output "Building FFI..."
cd crates/ui
make proto
make generate_bindings
cargo build --release -p mizer-ui-ffi

Write-Output "Building Application..."
cd ../..
cargo build --no-default-features --features ui --release -p mizer

Write-Output "Packaging Application..."
make mizer.zip
