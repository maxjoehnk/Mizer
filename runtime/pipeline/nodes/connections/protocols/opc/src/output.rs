use std::convert::TryInto;
use std::io::Write;
use std::net::TcpStream;

use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::protocol::SetColors;

const PIXELS_INPUT: &str = "pixels";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct OpcOutputNode {
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub width: u64,
    pub height: u64,
}

impl Default for OpcOutputNode {
    fn default() -> Self {
        Self {
            host: "".into(),
            port: default_port(),
            width: 100,
            height: 100,
        }
    }
}

#[derive(Default)]
pub enum OpcOutputState {
    #[default]
    Open,
    Connected(TcpStream),
}

impl PipelineNode for OpcOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(OpcOutputNode).into(),
            preview_type: PreviewType::Texture,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(PIXELS_INPUT, PortType::Multi, dimensions: (self.width, self.height))]
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
        if let Some(pixels) = context.read_port::<_, Vec<f64>>(PIXELS_INPUT) {
            let pixels = pixels.try_into()?;
            if let OpcOutputState::Connected(socket) = state {
                let msg = SetColors(1, pixels).into_buffer();

                socket.write_all(&msg)?;
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.host = config.host.clone();
        self.port = config.port;
        self.width = config.width;
        self.height = config.height;
    }
}

fn default_port() -> u16 {
    7890
}
