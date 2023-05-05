use gstreamer::prelude::*;
use gstreamer::{Element, ElementFactory};
use serde::{Deserialize, Serialize};

use mizer_node::*;

use crate::{GstreamerNode, PIPELINE};

#[derive(Default, Debug, Clone, Copy, Deserialize, Serialize, PartialEq, Eq)]
pub struct VideoTransformNode;

pub struct VideoTransformState {
    node: Element,
}

impl PipelineNode for VideoTransformNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(VideoTransformNode).into(),
            preview_type: PreviewType::Texture,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!("Input", PortType::Gstreamer),
            output_port!("Output", PortType::Gstreamer),
            input_port!("Rotate X", PortType::Single),
            input_port!("Rotate Y", PortType::Single),
            input_port!("Rotate Z", PortType::Single),
            input_port!("Translate X", PortType::Single),
            input_port!("Translate Y", PortType::Single),
            input_port!("Translate Z", PortType::Single),
            input_port!("Scale X", PortType::Single),
            input_port!("Scale Y", PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::VideoTransform
    }
}

impl ProcessingNode for VideoTransformNode {
    type State = VideoTransformState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        state.forward_port(context, "Rotate X", "rotation-x")?;
        state.forward_port(context, "Rotate Y", "rotation-y")?;
        state.forward_port(context, "Rotate Z", "rotation-z")?;
        state.forward_port(context, "Translate X", "translation-x")?;
        state.forward_port(context, "Translate Y", "translation-y")?;
        state.forward_port(context, "Translate Z", "translation-z")?;
        state.forward_port(context, "Scale X", "scale-x")?;
        state.forward_port(context, "Scale Y", "scale-y")?;

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        VideoTransformState::new()
    }

    fn update(&mut self, _config: &Self) {}
}

impl VideoTransformState {
    fn new() -> Self {
        let pipeline = PIPELINE.lock().unwrap();
        let node = ElementFactory::make("gltransformation").build().unwrap();
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
            self.node.set_property(property, value as f32);
        }
        Ok(())
    }
}

impl GstreamerNode for VideoTransformState {
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
