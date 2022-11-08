use mizer_node::{
    NodeContext, NodeDetails, NodePath, NodeType, PipelineNode, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct ContainerNode {
    pub nodes: Vec<NodePath>,
}

impl PipelineNode for ContainerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "ContainerNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn node_type(&self) -> NodeType {
        NodeType::Container
    }
}

impl ProcessingNode for ContainerNode {
    type State = ();

    fn process(&self, _: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, _config: &Self) {}
}
