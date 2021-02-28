use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortId, PortMetadata, PortType,
    ProcessingNode,
};

use crate::{GstreamerNode, PIPELINE};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
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
        }
    }

    fn introspect_port(&self, _: &PortId) -> PortMetadata {
        PortMetadata {
            port_type: PortType::Gstreamer,
            ..Default::default()
        }
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
    fn link_to(&self, _: &dyn GstreamerNode) {
        unimplemented!()
    }

    fn sink(&self) -> &Element {
        &self.sink
    }
}
