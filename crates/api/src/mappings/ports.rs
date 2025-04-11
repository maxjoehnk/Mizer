use crate::proto::ports::*;

impl From<mizer_node_ports::NodePort> for NodePort {
    fn from(port: mizer_node_ports::NodePort) -> Self {
        Self {
            id: port.id.0,
            name: port.label.to_string(),
        }
    }
}
