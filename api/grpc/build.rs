fn main() {
    println!("cargo:rerun-if-changed=../protos");
    protoc_rust_grpc::Codegen::new()
        .out_dir("src/protos")
        .input("../protos/connections.proto")
        .input("../protos/fixtures.proto")
        .input("../protos/nodes.proto")
        .input("../protos/session.proto")
        .input("../protos/media.proto")
        .input("../protos/layouts.proto")
        .input("../protos/transport.proto")
        .input("../protos/sequencer.proto")
        .input("../protos/programmer.proto")
        .input("../protos/settings.proto")
        .include("../protos")
        .run()
        .expect("protoc-rust-grpc");
}
