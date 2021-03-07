use std::convert::TryInto;
use std::io::Write;
use std::net::TcpStream;

use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::protocol::SetColors;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct OpcOutputNode {
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub width: u64,
    pub height: u64,
}

pub enum OpcOutputState {
    Open,
    Connected(TcpStream),
}

impl Default for OpcOutputState {
    fn default() -> Self {
        OpcOutputState::Open
    }
}

impl PipelineNode for OpcOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OpcOutputNode".into(),
        }
    }

    fn introspect_port(&self, _: &PortId) -> Option<PortMetadata> {
        Some(PortMetadata {
            port_type: PortType::Multi,
            dimensions: Some((self.width, self.height)),
            direction: PortDirection::Input,
            ..Default::default()
        })
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![("pixels".into(), PortMetadata {
            port_type: PortType::Multi,
            direction: PortDirection::Input,
            ..Default::default()
        })]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OpcOutput
    }
}

impl ProcessingNode for OpcOutputNode {
    type State = OpcOutputState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if matches!(state, OpcOutputState::Open) {
            let socket = TcpStream::connect((self.host.as_str(), self.port))?;
            *state = OpcOutputState::Connected(socket);
        }
        if let Some(pixels) = context.read_port::<_, Vec<f64>>("pixels") {
            let pixels = pixels.try_into()?;
            if let OpcOutputState::Connected(socket) = state {
                let msg = SetColors(1, pixels).to_buffer();

                socket.write_all(&msg)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

fn default_port() -> u16 {
    7890
}
