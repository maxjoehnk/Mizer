use mizer_node::{
    ConfigurableNode, NodeCategory, NodeContext, NodeDetails, NodePath, NodeType, PipelineNode,
    PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct ContainerNode {
    pub nodes: Vec<NodePath>,
}

impl ConfigurableNode for ContainerNode {}

impl PipelineNode for ContainerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Container".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::Standard,
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
}
