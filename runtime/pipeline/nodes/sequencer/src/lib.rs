use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_sequencer::Sequencer;

#[derive(Default, Clone, Deserialize, Serialize)]
pub struct SequencerNode {
    #[serde(rename = "sequence")]
    pub sequence_id: u32,
}

impl std::fmt::Debug for SequencerNode {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("SequencerNode")
            .field("sequence_id", &self.sequence_id)
            .finish()
    }
}

impl PartialEq<Self> for SequencerNode {
    fn eq(&self, other: &SequencerNode) -> bool {
        self.sequence_id == other.sequence_id
    }
}

impl PipelineNode for SequencerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "SequencerNode".into(),
            preview_type: PreviewType::None,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        if port == "go" {
            Some(PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            })
        } else {
            None
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "go".into(),
            PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Sequencer
    }
}

impl ProcessingNode for SequencerNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(_sequencer) = context.inject::<Sequencer>() {
            // TODO: implement sequencer node
        } else {
            log::warn!("missing fixture module");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
