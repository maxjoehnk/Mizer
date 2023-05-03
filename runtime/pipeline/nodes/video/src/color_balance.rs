use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

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
            input_port!("input", PortType::Gstreamer),
            output_port!("output", PortType::Gstreamer),
            input_port!("brightness", PortType::Single),
            input_port!("contrast", PortType::Single),
            input_port!("hue", PortType::Single),
            input_port!("saturation", PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoColorBalance
    }
}

impl ProcessingNode for VideoColorBalanceNode {
    type State = VideoColorBalanceState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(brightness) = context.read_port::<_, f64>("brightness") {
            state.node.set_property("brightness", &brightness);
        }
        if let Some(contrast) = context.read_port::<_, f64>("contrast") {
            state.node.set_property("contrast", &contrast);
        }
        if let Some(hue) = context.read_port::<_, f64>("hue") {
            state.node.set_property("hue", &hue);
        }
        if let Some(saturation) = context.read_port::<_, f64>("saturation") {
            state.node.set_property("saturation", &saturation);
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
