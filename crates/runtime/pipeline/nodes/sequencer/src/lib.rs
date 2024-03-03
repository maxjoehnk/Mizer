use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;
use mizer_sequencer::Sequencer;

const GO_FORWARD: &str = "Go+";
const PLAYBACK: &str = "Playback";
const TOGGLE_PLAYBACK: &str = "Playback Toggle";
const STOP: &str = "Stop";
const ACTIVE: &str = "Active";
const CUE: &str = "Cue";
const RATE: &str = "Rate";

const SEQUENCE_SETTING: &str = "Sequence";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq)]
pub struct SequencerNode {
    #[serde(rename = "sequence")]
    pub sequence_id: u32,
}

impl ConfigurableNode for SequencerNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let sequencer = injector.get::<Sequencer>().unwrap();
        let sequences = sequencer
            .sequences()
            .into_iter()
            .map(|sequence| IdVariant {
                value: sequence.id,
                label: sequence.name,
            })
            .collect();

        vec![setting!(id SEQUENCE_SETTING, self.sequence_id, sequences).disabled()]
    }
}

impl PipelineNode for SequencerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Sequencer".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn display_name(&self, injector: &Injector) -> String {
        if let Some(sequence) = injector
            .get::<Sequencer>()
            .and_then(|sequencer| sequencer.sequence(self.sequence_id))
        {
            format!("Sequencer ({})", sequence.name)
        } else {
            format!("Sequencer (ID {})", self.sequence_id)
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(GO_FORWARD, PortType::Single),
            input_port!(PLAYBACK, PortType::Single),
            input_port!(TOGGLE_PLAYBACK, PortType::Single),
            input_port!(STOP, PortType::Single),
            output_port!(ACTIVE, PortType::Single),
            output_port!(CUE, PortType::Single),
            input_port!(CUE, PortType::Single),
            input_port!(RATE, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Sequencer
    }
}

impl ProcessingNode for SequencerNode {
    type State = SequencerState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(sequencer) = context.try_inject::<Sequencer>() {
            if let Some(value) = context.read_port(PLAYBACK) {
                if (state.playback > 0f64) != (value > 0f64) {
                    if value > 0f64 {
                        sequencer.sequence_go(self.sequence_id);
                    } else {
                        sequencer.sequence_stop(self.sequence_id);
                    }
                }
                state.playback = value;
            }
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
            if let Some(value) = context.read_port(TOGGLE_PLAYBACK) {
                if let Some(true) = state.playback_toggle.update(value) {
                    if let Some(sequence_state) =
                        sequencer.get_sequencer_view().read().get(&self.sequence_id)
                    {
                        if sequence_state.active {
                            sequencer.sequence_stop(self.sequence_id);
                        } else {
                            sequencer.sequence_go(self.sequence_id);
                        }
                    }
                }
            }
            if let Some(value) = context.read_port_changes::<_, f64>(CUE) {
                sequencer.sequence_go_to(self.sequence_id, value.round() as u32);
            }
            let playback_rate = context.read_port(RATE).unwrap_or(1.);
            sequencer.sequence_playback_rate(self.sequence_id, playback_rate)?;
            if let Some(sequence_state) =
                sequencer.get_sequencer_view().read().get(&self.sequence_id)
            {
                context.write_port(ACTIVE, if sequence_state.active { 1f64 } else { 0f64 });
                if let Some(cue_id) = sequence_state.cue_id {
                    context.write_port(CUE, cue_id as f64);
                }
            }
        } else {
            tracing::warn!("missing fixture module");
        }

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default)]
pub struct SequencerState {
    playback: f64,
    go_forward: Edge,
    stop: Edge,
    playback_toggle: Edge,
}
