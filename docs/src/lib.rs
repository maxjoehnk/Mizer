include!(concat!(env!("OUT_DIR"), "/docs.rs"));

pub fn get_node_description(name: &str) -> Option<&'static str> {
    NODE_DESCRIPTIONS.get(name).copied()
}
