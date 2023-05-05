use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

const INPUT_PORT: &str = "input";
const OUTPUT_PORT: &str = "output";
const BRIGHTNESS_PORT: &str = "brightness";
const CONTRAST_PORT: &str = "contrast";
const HUE_PORT: &str = "hue";
const SATURATION_PORT: &str = "saturation";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoColorBalanceNode;

pub struct VideoColorBalanceState {
    node: Element,
}

impl PipelineNode for VideoColorBalanceNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(VideoColorBalanceNode).into(),
            preview_type: PreviewType::Texture,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_PORT, PortType::Gstreamer),
            output_port!(OUTPUT_PORT, PortType::Gstreamer),
            input_port!(BRIGHTNESS_PORT, PortType::Single),
            input_port!(CONTRAST_PORT, PortType::Single),
            input_port!(HUE_PORT, PortType::Single),
            input_port!(SATURATION_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoColorBalance
    }
}

impl ProcessingNode for VideoColorBalanceNode {
    type State = VideoColorBalanceState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(brightness) = context.read_port::<_, f64>(BRIGHTNESS_PORT) {
            state.node.set_property("brightness", brightness);
        }
        if let Some(contrast) = context.read_port::<_, f64>(CONTRAST_PORT) {
            state.node.set_property("contrast", contrast);
        }
        if let Some(hue) = context.read_port::<_, f64>(HUE_PORT) {
            state.node.set_property("hue", hue);
        }
        if let Some(saturation) = context.read_port::<_, f64>(SATURATION_PORT) {
            state.node.set_property("saturation", saturation);
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoColorBalanceState::new()
    }

    fn update(&mut self, _config: &Self) {}
}

impl VideoColorBalanceState {
    fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let node = ElementFactory::make("glcolorbalance").build().unwrap();
        pipeline.add(&node).unwrap();

        VideoColorBalanceState { node }
    }
}

impl GstreamerNode for VideoColorBalanceState {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()> {
        self.node.link(target.sink())?;
        Ok(())
    }

    fn unlink_from(&self, target: &dyn GstreamerNode) {
        self.node.unlink(target.sink());
    }

    fn sink(&self) -> &Element {
        &self.node
    }
}
