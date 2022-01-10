use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_node::edge::Edge;
use mizer_sequencer::Sequencer;

const GO_FORWARD: &str = "Go+";
const STOP: &str = "Stop";
const ACTIVE: &str = "Active";
const CUE: &str = "Cue";

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

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            GO_FORWARD.into(),
            PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            },
        ), (
            STOP.into(),
            PortMetadata {
                direction: PortDirection::Input,
                port_type: PortType::Single,
                ..Default::default()
            },
        ), (
            ACTIVE.into(),
            PortMetadata {
                direction: PortDirection::Output,
                port_type: PortType::Single,
                ..Default::default()
            }
        ), (
             CUE.into(),
             PortMetadata {
                 direction: PortDirection::Output,
                 port_type: PortType::Single,
                 ..Default::default()
             }
         )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Sequencer
    }
}

impl ProcessingNode for SequencerNode {
    type State = SequencerState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(sequencer) = context.inject::<Sequencer>() {
            if let Some(value) = context.read_port(GO_FORWARD) {
                if let Some(true) = state.go_forward.update(value) {
                    sequencer.sequence_go(self.sequence_id);
                }
            }
            if let Some(value) = context.read_port(STOP) {
                if let Some(true) = state.stop.update(value) {
                    sequencer.sequence_stop(self.sequence_id);
                }
            }
            if let Some(sequence_state) = sequencer.get_sequencer_view().read().get(&self.sequence_id) {
                context.write_port(ACTIVE, if sequence_state.active { 1f64 } else { 0f64 });
                if let Some(cue_id) = sequence_state.cue_id {
                    context.write_port(CUE, cue_id as f64);
                }
            }
        } else {
            log::warn!("missing fixture module");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default)]
pub struct SequencerState {
    go_forward: Edge,
    stop: Edge,
}
