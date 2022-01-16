use serde::{Deserialize, Serialize};

use crate::OscArgumentType;
use mizer_node::*;
use mizer_protocol_osc::*;
use mizer_util::ConvertPercentages;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct OscInputNode {
    #[serde(default = "default_host")]
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub path: String,
    #[serde(default = "default_argument_type")]
    pub argument_type: OscArgumentType,
}

fn default_host() -> String {
    "0.0.0.0".into()
}

fn default_port() -> u16 {
    6000
}

fn default_argument_type() -> OscArgumentType {
    OscArgumentType::Float
}

impl Default for OscInputNode {
    fn default() -> Self {
        Self {
            host: default_host(),
            port: default_port(),
            argument_type: default_argument_type(),
            path: "".into(),
        }
    }
}

impl PipelineNode for OscInputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OscInputNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            self.argument_type.get_port_id(),
            PortMetadata {
                port_type: self.argument_type.get_port_type(),
                direction: PortDirection::Output,
                ..Default::default()
            },
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
            if self.argument_type.is_numeric() {
                match &msg.args[0] {
                    OscType::Float(float) => self.write_number(context, *float as f64),
                    OscType::Double(double) => self.write_number(context, *double),
                    OscType::Int(int) => self.write_number(context, *int as f64),
                    OscType::Long(value) => self.write_number(context, *value as f64),
                    OscType::Bool(value) => {
                        self.write_number(context, if *value { 1. } else { 0. })
                    }
                    _ => {}
                }
            }
            if self.argument_type.is_color() {
                if let OscType::Color(color) = &msg.args[0] {
                    self.write_color(context, color);
                }
            }
        }
    }

    fn write_number(&self, context: &impl NodeContext, value: f64) {
        context.write_port(self.argument_type.get_port_id(), value);
        context.push_history_value(value);
    }

    fn write_color(&self, context: &impl NodeContext, color: &OscColor) {
        context.write_port(
            self.argument_type.get_port_id(),
            Color {
                red: color.red.to_percentage(),
                green: color.green.to_percentage(),
                blue: color.blue.to_percentage(),
                alpha: color.alpha.to_percentage(),
            },
        );
    }
}
