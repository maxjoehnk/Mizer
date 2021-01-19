SRC_DIR = ../proto/protos

proto: lib/protos/nodes.pb.dart lib/protos/session.pb.dart

lib/protos/nodes.pb.dart: ../proto/protos/nodes.proto
	protoc -I=${SRC_DIR} --dart_out=grpc:lib/protos ../proto/protos/nodes.proto

lib/protos/session.pb.dart: ../proto/protos/session.proto
	protoc -I=${SRC_DIR} --dart_out=grpc:lib/protos ../proto/protos/session.proto
