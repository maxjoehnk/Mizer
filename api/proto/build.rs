use protoc_rust::Customize;

fn main() {
    protoc_rust::Codegen::new()
        .out_dir("src")
        .inputs(&["protos/nodes.proto", "protos/session.proto", "protos/fixtures.proto"])
        .include("protos")
        .customize(Customize {
            serde_derive: Some(true),
            ..Default::default()
        })
        .run()
        .expect("protoc");
}
