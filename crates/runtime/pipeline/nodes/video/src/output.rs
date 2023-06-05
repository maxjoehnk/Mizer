use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoOutputNode;

pub struct VideoOutputState {
    sink: Element,
}

impl VideoOutputState {
    fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let sink = ElementFactory::make("glimagesinkelement").build().unwrap();
        pipeline.add(&sink).unwrap();

        VideoOutputState { sink }
    }
}

impl ConfigurableNode for VideoOutputNode {}

impl PipelineNode for VideoOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Video Output".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("Input", PortType::Gstreamer)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoOutput
    }
}

impl ProcessingNode for VideoOutputNode {
    type State = VideoOutputState;

    fn process(&self, _: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        let pipeline = PIPELINE.lock().unwrap();
        pipeline.set_state(gstreamer::State::Playing).unwrap();

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoOutputState::new()
    }
}

impl GstreamerNode for VideoOutputState {
    fn link_to(&self, _: &dyn GstreamerNode) -> anyhow::Result<()> {
        unimplemented!()
    }

    fn unlink_from(&self, _: &dyn GstreamerNode) {
        unimplemented!()
    }

    fn sink(&self) -> &Element {
        &self.sink
    }
}
