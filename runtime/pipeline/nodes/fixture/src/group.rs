use mizer_fixtures::manager::FixtureManager;
use mizer_node::edge::Edge;
use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

const CALL_PORT: &str = "Call";
const ACTIVE_PORT: &str = "Active";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct GroupNode {
    pub id: u32,
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
                CALL_PORT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Input,
                    ..Default::default()
                },
            ),
            (
                ACTIVE_PORT.into(),
                PortMetadata {
                    port_type: PortType::Single,
                    direction: PortDirection::Output,
                    ..Default::default()
                },
            ),
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
                if let Some(value) = context.read_port(CALL_PORT) {
                    if let Some(true) = state.update(value) {
                        programmer.select_group(group.value());
                    }
                }
                let active = programmer.is_group_active(group.value());
                context.write_port(ACTIVE_PORT, if active { 1f64 } else { 0f64 });
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
