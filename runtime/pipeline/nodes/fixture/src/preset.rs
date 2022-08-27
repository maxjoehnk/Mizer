use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;
use mizer_node::{
    NodeContext, NodeDetails, NodeType, PipelineNode, PortDirection, PortId, PortMetadata,
    PortType, PreviewType, ProcessingNode,
};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
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

impl PipelineNode for PresetNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "PresetNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "Call".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Input,
                edge: true,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Preset
    }
}

impl ProcessingNode for PresetNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(fixture_manager) = context.inject::<FixtureManager>() {
            let mut programmer = fixture_manager.get_programmer();
            if let Some(true) = context.read_edge("Call") {
                programmer.call_preset(&fixture_manager.presets, self.id);
            }
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
