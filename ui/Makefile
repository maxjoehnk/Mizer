FLUTTER_DEBUG_URL:=$(shell cat $(XDG_RUNTIME_DIR)/vmservice.mizer | jq -r ".uri")

SRC_DIR = ../api/protos
OUT_DIR = lib/protos
COMPILER = protoc -I=$(SRC_DIR) --dart_out=grpc:$(OUT_DIR)

SRCS := $(shell find $(SRC_DIR) -name *.proto)
PROTOS := $(SRCS:$(SRC_DIR)/%.proto=$(OUT_DIR)/%.pb.dart)

.PHONY: widgetbook

build: proto ffi

release: proto ffi_release

deps:
	flutter pub get

proto: $(PROTOS)

$(OUT_DIR)/%.pb.dart : $(SRC_DIR)/%.proto
	$(COMPILER) $<

ffi: generate_bindings
	cargo build -p mizer-ui-ffi
	cp ../target/debug/libmizer_ui_ffi.so ../target/debug/lib/

ffi_release: generate_bindings
	cargo build --release -p mizer-ui-ffi

generate_header:
	cbindgen --config ffi/cbindgen.toml --crate mizer-ui-ffi --output ffi.h --lang c

generate_bindings: generate_header deps
	flutter pub run ffigen

attach:
	flutter attach -d linux --debug-url $(FLUTTER_DEBUG_URL) -t lib/integrated.dart

widgetbook:
	flutter run -t widgetbook/main.dart
