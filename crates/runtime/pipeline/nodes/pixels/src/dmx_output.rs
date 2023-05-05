use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_dmx::{DmxConnectionManager, DmxOutput};
use mizer_util::ConvertBytes;

const DMX_CHANNELS: u16 = 512;
const CHANNELS_PER_PIXEL: u64 = 3; // RGB, add configuration later

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct PixelDmxNode {
    pub width: u64,
    pub height: u64,
    #[serde(default = "default_universe")]
    pub start_universe: u16,
    pub output: String,
}

impl Default for PixelDmxNode {
    fn default() -> Self {
        Self {
            width: 100,
            height: 100,
            start_universe: default_universe(),
            output: "".into(),
        }
    }
}

const INPUT_PORT: &str = "Input";

impl PipelineNode for PixelDmxNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(PixelDmxNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(
            INPUT_PORT, PortType::Multi, dimensions: (self.width, self.height)
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PixelDmx
    }
}

impl ProcessingNode for PixelDmxNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let channel_count = self.width * self.height * CHANNELS_PER_PIXEL;
        let universe_count = (channel_count / DMX_CHANNELS as u64) as u16;
        log::debug!("universes for pixels: {}", universe_count);
        let dmx_manager = context
            .inject::<DmxConnectionManager>()
            .ok_or_else(|| anyhow::anyhow!("missing dmx module"))?;
        let output = dmx_manager
            .get_output(&self.output)
            .ok_or_else(|| anyhow::anyhow!("unknown dmx output"))?;

        if let Some(pixels) = context.read_port::<_, Vec<f64>>(INPUT_PORT) {
            let data = pixels
                .into_iter()
                .map(ConvertBytes::to_8bit)
                .collect::<Vec<_>>();
            let data = data.chunks(512).enumerate();
            for (universe, bulk) in data {
                let universe = universe as u16 + self.start_universe;
                output.write_bulk(universe, 1, bulk);
            }
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.height = config.height;
        self.width = config.width;
        self.output = config.output.clone();
        self.start_universe = config.start_universe;
    }
}

fn default_universe() -> u16 {
    1
}
