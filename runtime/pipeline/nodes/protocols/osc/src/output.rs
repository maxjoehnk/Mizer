use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_osc::{OscMessage, OscOutput, OscPacket};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct OscOutputNode {
    #[serde(default = "default_host")]
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub path: String,
}

fn default_host() -> String {
    "255.255.255.255".into()
}

fn default_port() -> u16 {
    6000
}

impl Default for OscOutputNode {
    fn default() -> Self {
        Self {
            host: default_host(),
            port: default_port(),
            path: "".into(),
        }
    }
}

impl PipelineNode for OscOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OscOutputNode".into(),
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        (port == "value").then(|| PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Input,
            ..Default::default()
        })
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "value".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Input,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscOutput
    }
}

impl ProcessingNode for OscOutputNode {
    type State = OscOutput;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port::<_, f64>("value") {
            state.send(OscPacket::Message(OscMessage {
                addr: self.path.clone(),
                args: vec![value.into()],
            }))?;
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        OscOutput::new(&self.host, self.port).unwrap()
    }
}
