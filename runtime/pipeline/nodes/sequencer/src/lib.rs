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
        }else {
            None
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            ("go".into(), PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            })
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Sequencer
    }
}

impl ProcessingNode for SequencerNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _: &mut Self::State) -> anyhow::Result<()> {
        if let Some(sequencer) = context.inject::<Sequencer>() {

            // if let Some(mut fixture) = manager.get_fixture_mut(self.fixture_id) {
            //     for port in context.input_ports() {
            //         if let Some(value) = context.read_port(port.clone()) {
            //             fixture.write(&port.0, value);
            //         }
            //     }
            // } else {
            //     log::error!("could not find fixture for id {}", self.fixture_id);
            // }
        } else {
            log::warn!("missing fixture module");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}
