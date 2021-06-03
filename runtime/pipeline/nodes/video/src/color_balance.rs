use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoColorBalanceNode;

pub struct VideoColorBalanceState {
    node: Element,
}

impl PipelineNode for VideoColorBalanceNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "VideoColorBalanceNode".into(),
            preview_type: PreviewType::Texture,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        if port == "output" || port == "input" {
            Some(PortMetadata {
                port_type: PortType::Gstreamer,
                ..Default::default()
            })
        } else {
            Default::default()
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "input".into(),
                PortMetadata {
                    port_type: PortType::Gstreamer,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                "output".into(),
                PortMetadata {
                    port_type: PortType::Gstreamer,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
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
            state.node.set_property("brightness", &brightness)?;
        }
        if let Some(contrast) = context.read_port::<_, f64>("contrast") {
            state.node.set_property("contrast", &contrast)?;
        }
        if let Some(hue) = context.read_port::<_, f64>("hue") {
            state.node.set_property("hue", &hue)?;
        }
        if let Some(saturation) = context.read_port::<_, f64>("saturation") {
            state.node.set_property("saturation", &saturation)?;
        }
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoColorBalanceState::new()
    }
}

impl VideoColorBalanceState {
    fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let node = ElementFactory::make("glcolorbalance", None).unwrap();
        pipeline.add(&node).unwrap();

        VideoColorBalanceState { node }
    }
}

impl GstreamerNode for VideoColorBalanceState {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()> {
        self.node.link(target.sink())?;
        Ok(())
    }

    fn sink(&self) -> &Element {
        &self.node
    }
}
