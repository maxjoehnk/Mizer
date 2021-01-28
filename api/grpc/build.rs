fn main() {
    protoc_rust_grpc::Codegen::new()
        .out_dir("src/protos")
        .input("./protos/fixtures.proto")
        .input("./protos/nodes.proto")
        .input("./protos/session.proto")
        .input("./protos/media.proto")
        .include("protos")
        .rust_protobuf(true)
        .run()
        .expect("protoc-rust-grpc");
}
