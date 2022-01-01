use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_osc::*;
use mizer_util::ConvertBytes;

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
            preview_type: PreviewType::History,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        let number = (port == "number").then(|| PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Input,
            ..Default::default()
        });
        let color = (port == "color").then(|| PortMetadata {
            port_type: PortType::Color,
            direction: PortDirection::Input,
            ..Default::default()
        });
        number.or(color)
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "number".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "color".into(),
                PortMetadata {
                    port_type: PortType::Color,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscOutput
    }
}

impl ProcessingNode for OscOutputNode {
    type State = OscOutput;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(value) = context.read_port::<_, f64>("number") {
            context.push_history_value(value);
            state.send(OscPacket::Message(OscMessage {
                addr: self.path.clone(),
                args: vec![value.into()],
            }))?;
        }
        if let Some(color) = context.read_port::<_, Color>("color") {
            let color = OscColor {
                red: color.red.to_8bit(),
                green: color.green.to_8bit(),
                blue: color.blue.to_8bit(),
                alpha: color.alpha.to_8bit(),
            };
            state.send(OscPacket::Message(OscMessage {
                addr: self.path.clone(),
                args: vec![OscType::Color(color)],
            }))?;
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        OscOutput::new(&self.host, self.port).unwrap()
    }
}
