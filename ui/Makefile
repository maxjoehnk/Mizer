FLUTTER_DEBUG_URL:=$(shell cat $(XDG_RUNTIME_DIR)/vmservice.mizer | jq -r ".uri")

SRC_DIR = ../api/protos
OUT_DIR = lib/protos
COMPILER = protoc -I=$(SRC_DIR) --dart_out=grpc:$(OUT_DIR)

SRCS := $(shell find $(SRC_DIR) -name *.proto)
PROTOS := $(SRCS:$(SRC_DIR)/%.proto=$(OUT_DIR)/%.pb.dart)

proto: $(PROTOS)

$(OUT_DIR)/%.pb.dart : $(SRC_DIR)/%.proto
	$(COMPILER) $<

attach:
	flutter attach -d linux --debug-url $(FLUTTER_DEBUG_URL) -t lib/integrated.dart
