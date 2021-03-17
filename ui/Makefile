SRC_DIR = ../api/grpc/protos
COMPILER = protoc -I=$(SRC_DIR) --dart_out=grpc:lib/protos

proto: lib/protos/nodes.pb.dart lib/protos/session.pb.dart lib/protos/fixtures.pb.dart lib/protos/media.pb.dart lib/protos/layouts.pb.dart

lib/protos/nodes.pb.dart: $(SRC_DIR)/nodes.proto
	$(COMPILER) $(SRC_DIR)/nodes.proto

lib/protos/session.pb.dart: $(SRC_DIR)/session.proto
	$(COMPILER) $(SRC_DIR)/session.proto

lib/protos/fixtures.pb.dart: $(SRC_DIR)/fixtures.proto
	$(COMPILER) $(SRC_DIR)/fixtures.proto

lib/protos/media.pb.dart: $(SRC_DIR)/media.proto
	$(COMPILER) $(SRC_DIR)/media.proto

lib/protos/layouts.pb.dart: $(SRC_DIR)/layouts.proto
	$(COMPILER) $(SRC_DIR)/layouts.proto
