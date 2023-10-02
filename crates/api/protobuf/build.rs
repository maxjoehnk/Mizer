fn main() {
    println!("cargo:rerun-if-changed=../protos");
    tonic_build::configure()
        .build_server(false)
        .build_client(false)
        .build_transport(false)
        .compile(&["../protos/connections.proto"], &["../protos/"])
        .unwrap();
}
