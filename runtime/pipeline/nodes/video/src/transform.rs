use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct VideoTransformNode;

pub struct VideoTransformState {
    node: Element,
}

impl PipelineNode for VideoTransformNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "VideoTransformNode".into(),
        }
    }

    fn introspect_port(&self, port: &PortId, _: &Injector) -> Option<PortMetadata> {
        match port.as_str() {
            "output" => Some(PortMetadata {
                port_type: PortType::Gstreamer,
                direction: PortDirection::Output,
                ..Default::default()
            }),
            "input" => Some(PortMetadata {
                port_type: PortType::Gstreamer,
                direction: PortDirection::Input,
                ..Default::default()
            }),
            "rotate-x" | "rotate-y" | "rotate-z" | "translate-x" | "translate-y"
            | "translate-z" | "scale-x" | "scale-y" => Some(PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Input,
                ..Default::default()
            }),
            _ => None,
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoTransform
    }
}

impl ProcessingNode for VideoTransformNode {
    type State = VideoTransformState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        state.forward_port(context, "rotate-x", "rotation-x")?;
        state.forward_port(context, "rotate-y", "rotation-y")?;
        state.forward_port(context, "rotate-z", "rotation-z")?;
        state.forward_port(context, "translate-x", "translation-x")?;
        state.forward_port(context, "translate-y", "translation-y")?;
        state.forward_port(context, "translate-z", "translation-z")?;
        state.forward_port(context, "scale-x", "scale-x")?;
        state.forward_port(context, "scale-y", "scale-y")?;

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoTransformState::new()
    }
}

impl VideoTransformState {
    fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let node = ElementFactory::make("gltransformation", None).unwrap();
        pipeline.add(&node).unwrap();

        VideoTransformState { node }
    }

    fn forward_port(
        &self,
        context: &impl NodeContext,
        port: &str,
        property: &str,
    ) -> anyhow::Result<()> {
        if let Some(value) = context.read_port::<_, f64>(port) {
            self.node.set_property(property, &(value as f32))?;
        }
        Ok(())
    }
}

impl GstreamerNode for VideoTransformState {
    fn link_to(&self, target: &dyn GstreamerNode) -> anyhow::Result<()> {
        self.node.link(target.sink())?;
        Ok(())
    }

    fn sink(&self) -> &Element {
        &self.node
    }
}
