use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;
use mizer_node::edge::Edge;
use mizer_node::*;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct PresetNode {
    pub id: PresetId,
}

impl Default for PresetNode {
    fn default() -> Self {
        Self {
            id: PresetId::Intensity(0),
        }
    }
}

impl ConfigurableNode for PresetNode {}

impl PipelineNode for PresetNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Preset".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![input_port!("Call", PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Preset
    }
}

impl ProcessingNode for PresetNode {
    type State = Edge;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.inject::<FixtureManager>() {
            let mut programmer = fixture_manager.get_programmer();
            if let Some(value) = context.read_port("Call") {
                if let Some(true) = state.update(value) {
                    programmer.call_preset(&fixture_manager.presets, self.id);
                }
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
