use protoc_rust::Customize;

fn main() {
    println!("cargo:rerun-if-changed=protos");
    protoc_rust::Codegen::new()
        .out_dir("src/models")
        .inputs(&[
            "protos/fixtures.proto",
            "protos/layouts.proto",
            "protos/media.proto",
            "protos/nodes.proto",
            "protos/session.proto",
        ])
        .include("protos")
        .customize(Customize {
            serde_derive: Some(true),
            ..Default::default()
        })
        .run()
        .expect("protoc");
}
