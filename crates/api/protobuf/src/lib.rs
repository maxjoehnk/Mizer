pub use prost::Message;

pub mod connections {
    tonic::include_proto!("mizer.connections");
}
