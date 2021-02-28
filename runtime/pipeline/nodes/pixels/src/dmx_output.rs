use serde::{Deserialize, Serialize};

use mizer_conversion::ConvertToDmx;
use mizer_node::*;
use mizer_protocol_dmx::DmxConnectionManager;

const DMX_CHANNELS: u16 = 512;
const CHANNELS_PER_PIXEL: u64 = 3; // RGB, add configuration later

#[derive(Debug, Clone, PartialEq, Deserialize, Serialize)]
pub struct PixelDmxNode {
    width: u64,
    height: u64,
    #[serde(default = "default_universe")]
    start_universe: u16,
    output: String,
}

const OUTPUT_PORT: &str = "output";

impl PipelineNode for PixelDmxNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "PixelDmxNode".into(),
        }
    }

    fn introspect_port(&self, _: &PortId) -> PortMetadata {
        PortMetadata {
            port_type: PortType::Multi,
            dimensions: Some((self.width, self.height)),
        }
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

        if let Some(pixels) = context.read_port::<_, Vec<f64>>(OUTPUT_PORT) {
            let data = pixels
                .into_iter()
                .map(ConvertToDmx::to_8bit)
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
}

fn default_universe() -> u16 {
    1
}
