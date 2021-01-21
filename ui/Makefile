SRC_DIR = ../proto/protos
COMPILER = protoc -I=${SRC_DIR} --dart_out=grpc:lib/protos

proto: lib/protos/nodes.pb.dart lib/protos/session.pb.dart lib/protos/fixtures.pb.dart

lib/protos/nodes.pb.dart: ../proto/protos/nodes.proto
	${COMPILER} ../proto/protos/nodes.proto

lib/protos/session.pb.dart: ../proto/protos/session.proto
	${COMPILER} ../proto/protos/session.proto

lib/protos/fixtures.pb.dart: ../proto/protos/fixtures.proto
	${COMPILER} ../proto/protos/fixtures.proto
