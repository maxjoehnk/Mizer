use std::convert::TryInto;
use std::io::Write;
use std::net::TcpStream;

use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_pixel_nodes::texture_to_pixels::TextureToPixelsConverter;

use crate::protocol::SetColors;

const PIXELS_INPUT: &str = "Pixels";

const HOST_SETTING: &str = "Host";
const PORT_SETTING: &str = "Port";
const WIDTH_SETTING: &str = "Width";
const HEIGHT_SETTING: &str = "Height";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct OpcOutputNode {
    pub host: String,
    #[serde(default = "default_port")]
    pub port: u16,
    pub width: u32,
    pub height: u32,
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

impl ConfigurableNode for OpcOutputNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(HOST_SETTING, &self.host),
            setting!(PORT_SETTING, self.port as u32)
                .min(1u32)
                .max(65535u32),
            setting!(WIDTH_SETTING, self.width).min(1u32),
            setting!(HEIGHT_SETTING, self.height).min(1u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(text setting, HOST_SETTING, self.host);
        update!(int setting, PORT_SETTING, self.port);
        update!(int setting, WIDTH_SETTING, self.width);
        update!(int setting, HEIGHT_SETTING, self.height);

        update_fallback!(setting)
    }
}

impl PipelineNode for OpcOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "OPC Output".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Connections,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(PIXELS_INPUT, PortType::Texture, dimensions: (self.width as u64, self.height as u64)),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::OpcOutput
    }
}

impl ProcessingNode for OpcOutputNode {
    type State = (OpcOutputState, Option<TextureToPixelsConverter>);

    fn process(
        &self,
        context: &impl NodeContext,
        (state, converter): &mut Self::State,
    ) -> anyhow::Result<()> {
        if matches!(state, OpcOutputState::Open) {
            let socket = TcpStream::connect((self.host.as_str(), self.port))?;
            *state = OpcOutputState::Connected(socket);
        }
        if converter.is_none() {
            *converter = Some(TextureToPixelsConverter::new(context, PIXELS_INPUT)?);
        }
        if let Some(converter) = converter {
            converter.process(context)?;
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

    fn post_process(
        &self,
        context: &impl NodeContext,
        (state, converter): &mut Self::State,
    ) -> anyhow::Result<()> {
        if let Some(converter) = converter.as_mut() {
            if let Some(pixels) = converter.post_process(context, self.width, self.height)? {
                let pixels = pixels.try_into()?;
                if let OpcOutputState::Connected(socket) = state {
                    let msg = SetColors(1, pixels).into_buffer();

                    socket.write_all(&msg)?;
                }
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
