fn main() {
    protoc_rust_grpc::Codegen::new()
        .out_dir("src/protos")
        .input("../proto/protos/fixtures.proto")
        .input("../proto/protos/nodes.proto")
        .input("../proto/protos/session.proto")
        .include("../proto/protos")
        .run()
        .expect("protoc-rust-grpc");
}
