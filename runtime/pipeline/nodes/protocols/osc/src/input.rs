use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_osc::*;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct OscInputNode {
    #[serde(default = "default_host")]
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub path: String,
}

fn default_host() -> String {
    "0.0.0.0".into()
}

fn default_port() -> u16 {
    6000
}

impl Default for OscInputNode {
    fn default() -> Self {
        Self {
            host: default_host(),
            port: default_port(),
            path: "".into(),
        }
    }
}

impl PipelineNode for OscInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OscInputNode".into(),
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        let number = (port == "number").then(|| PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Output,
            ..Default::default()
        });
        let color = (port == "color").then(|| PortMetadata {
            port_type: PortType::Color,
            direction: PortDirection::Output,
            ..Default::default()
        });
        number.or(color)
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "number".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Output,
                ..Default::default()
            },
        ), (
            "color".into(),
            PortMetadata {
                port_type: PortType::Color,
                direction: PortDirection::Output,
                ..Default::default()
            }
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OscInput
    }
}

impl ProcessingNode for OscInputNode {
    type State = OscInput;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        while let Some(packet) = state.try_recv() {
            self.handle_packet(packet, context);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        OscInput::new(&self.host, self.port).unwrap()
    }
}

impl OscInputNode {
    fn handle_packet(&self, packet: OscPacket, context: &impl NodeContext) {
        match packet {
            OscPacket::Message(msg) => {
                self.handle_msg(msg, context);
            }
            OscPacket::Bundle(bundle) => {
                for packet in bundle.content {
                    self.handle_packet(packet, context);
                }
            }
        }
    }

    fn handle_msg(&self, msg: OscMessage, context: &impl NodeContext) {
        log::trace!("{:?}", msg);
        if msg.addr == self.path {
            match &msg.args[0] {
                OscType::Float(float) => write_number(context, *float as f64),
                OscType::Double(double) => write_number(context, *double),
                OscType::Int(int) => write_number(context, *int as f64),
                OscType::Color(color) => write_color(context, color),
                _ => {}
            }
        }
    }
}

fn write_number(context: &impl NodeContext, value: f64) {
    context.write_port("number", value);
}

fn write_color(context: &impl NodeContext, color: &OscColor) {
    context.write_port("color", Color {
        red: color.red,
        green: color.green,
        blue: color.blue,
        alpha: color.alpha,
    });
}
