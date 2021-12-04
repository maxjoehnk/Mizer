use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoOutputNode;

pub struct VideoOutputState {
    sink: Element,
}

impl VideoOutputState {
    fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let sink = ElementFactory::make("glimagesinkelement", None).unwrap();
        pipeline.add(&sink).unwrap();

        VideoOutputState { sink }
    }
}

impl PipelineNode for VideoOutputNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "VideoOutputNode".into(),
            preview_type: PreviewType::Texture,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "input".into(),
            PortMetadata {
                port_type: PortType::Gstreamer,
                direction: PortDirection::Input,
                ..Default::default()
            },
        )]
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
