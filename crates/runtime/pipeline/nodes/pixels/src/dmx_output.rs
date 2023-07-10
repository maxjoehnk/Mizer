use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_dmx::{DmxConnectionManager, DmxOutput};
use mizer_util::ConvertBytes;

const DMX_CHANNELS: u16 = 512;
const CHANNELS_PER_PIXEL: u64 = 3; // RGB, add configuration later

const OUTPUT_SETTING: &str = "Output";
const WIDTH_SETTING: &str = "Width";
const HEIGHT_SETTING: &str = "Height";
const START_UNIVERSE_SETTING: &str = "Start Universe";

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

impl ConfigurableNode for PixelDmxNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let dmx_manager = injector.get::<DmxConnectionManager>().unwrap();
        let outputs = dmx_manager
            .list_outputs()
            .into_iter()
            .map(|(id, output)| SelectVariant::Item {
                value: id.clone(),
                label: output.name(),
            })
            .collect();

        vec![
            setting!(select OUTPUT_SETTING, &self.output, outputs),
            setting!(WIDTH_SETTING, self.width as u32).min(1u32),
            setting!(HEIGHT_SETTING, self.height as u32).min(1u32),
            setting!(START_UNIVERSE_SETTING, self.start_universe as u32)
                .min(1u32)
                .max(32768u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, OUTPUT_SETTING, self.output);
        update!(int setting, WIDTH_SETTING, self.width);
        update!(int setting, HEIGHT_SETTING, self.height);
        update!(int setting, START_UNIVERSE_SETTING, self.start_universe);

        update_fallback!(setting)
    }
}

impl PipelineNode for PixelDmxNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Pixel to DMX".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Pixel,
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
}

fn default_universe() -> u16 {
    1
}
