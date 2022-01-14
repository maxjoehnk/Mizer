use serde::{Deserialize, Serialize};
use mizer_fixtures::manager::FixtureManager;
use mizer_node::{NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata, PortType, PreviewType, ProcessingNode};
use mizer_node::edge::Edge;

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct GroupNode {
    pub id: u32
}

impl PipelineNode for GroupNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "GroupNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            (
                "Call".into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                }
            )
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Group
    }
}

impl ProcessingNode for GroupNode {
    type State = Edge;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.inject::<FixtureManager>() {
            let mut programmer = fixture_manager.get_programmer();
            if let Some(group) = fixture_manager.groups.get(&self.id) {
                if let Some(value) = context.read_port("Call") {
                    if let Some(true) = state.update(value) {
                        programmer.select_group(group.value());
                    }
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
