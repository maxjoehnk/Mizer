use image::Pixel;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_protocol_dmx::{DmxConnectionManager, DmxOutput};

use crate::texture_to_pixels::TextureToPixelsConverter;

const DMX_CHANNELS: u16 = 512;
const CHANNELS_PER_PIXEL: u32 = 3; // RGB, add configuration later

const OUTPUT_SETTING: &str = "Output";
const WIDTH_SETTING: &str = "Width";
const HEIGHT_SETTING: &str = "Height";
const START_UNIVERSE_SETTING: &str = "Start Universe";
const PIXELS_PER_UNIVERSE_SETTING: &str = "Pixels per Universe";

#[derive(Debug, Clone, PartialEq, Eq, Deserialize, Serialize)]
pub struct PixelDmxNode {
    pub width: u32,
    pub height: u32,
    #[serde(default = "default_universe")]
    pub start_universe: u16,
    #[serde(default = "default_pixels_per_universe")]
    pub pixels_per_universe: u8,
    pub output: String,
}

impl Default for PixelDmxNode {
    fn default() -> Self {
        Self {
            width: 100,
            height: 100,
            start_universe: default_universe(),
            pixels_per_universe: default_pixels_per_universe(),
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
                value: id.clone().into(),
                label: output.name().into(),
            })
            .collect();

        vec![
            setting!(select OUTPUT_SETTING, &self.output, outputs),
            setting!(WIDTH_SETTING, self.width).min(1u32),
            setting!(HEIGHT_SETTING, self.height).min(1u32),
            setting!(START_UNIVERSE_SETTING, self.start_universe as u32)
                .min(1u32)
                .max(32768u32),
            setting!(PIXELS_PER_UNIVERSE_SETTING, self.pixels_per_universe as u32)
                .min(1u32)
                .max(170u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, OUTPUT_SETTING, self.output);
        update!(uint setting, WIDTH_SETTING, self.width);
        update!(uint setting, HEIGHT_SETTING, self.height);
        update!(uint setting, START_UNIVERSE_SETTING, self.start_universe);
        update!(uint setting, PIXELS_PER_UNIVERSE_SETTING, self.pixels_per_universe);

        update_fallback!(setting)
    }
}

impl PipelineNode for PixelDmxNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "DMX Pixels".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Pixel,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!(
            INPUT_PORT, PortType::Texture, dimensions: (self.width as u64, self.height as u64)
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::PixelDmx
    }
}

impl ProcessingNode for PixelDmxNode {
    type State = Option<TextureToPixelsConverter>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if state.is_none() {
            *state = Some(TextureToPixelsConverter::new(context, INPUT_PORT)?);
        }

        if let Some(state) = state {
            state.process(context)?;
        }

        Ok(())
    }

    fn post_process(
        &self,
        context: &impl NodeContext,
        state: &mut Self::State,
    ) -> anyhow::Result<()> {
        let channel_count = self.width * self.height * CHANNELS_PER_PIXEL;
        let universe_count = (channel_count / DMX_CHANNELS as u32) as u16;
        log::debug!("universes for pixels: {}", universe_count);
        let dmx_manager = context
            .inject::<DmxConnectionManager>()
            .ok_or_else(|| anyhow::anyhow!("missing dmx module"))?;
        let output = dmx_manager
            .get_output(&self.output)
            .ok_or_else(|| anyhow::anyhow!("unknown dmx output"))?;

        if let Some(state) = state.as_mut() {
            if let Some(pixels) = state.post_process(context, self.width, self.height)? {
                let data = pixels.chunks(self.pixels_per_universe as usize).enumerate();
                tracing::trace!("Writing pixels to {} universes", data.len());
                for (universe, pixels) in data {
                    let universe = universe as u16 + self.start_universe;
                    let pixels = pixels
                        .iter()
                        .copied()
                        .flat_map(|pixel| pixel.to_rgb().0)
                        .collect::<Vec<_>>();
                    output.write_bulk(universe, 1, &pixels);
                }
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

fn default_pixels_per_universe() -> u8 {
    (DMX_CHANNELS as u32 / CHANNELS_PER_PIXEL) as u8
}
