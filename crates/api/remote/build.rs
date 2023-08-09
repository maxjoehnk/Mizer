fn main() {
    tonic_build::configure()
        .compile(&["../protos/fixtures.proto"], &["../protos/"])
        .unwrap();
}
