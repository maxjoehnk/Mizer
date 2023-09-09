#!/usr/bin/env bash
set -e

cd crates/ui
make generate_bindings
make proto

cd ../..

make test
make mizer.zip
