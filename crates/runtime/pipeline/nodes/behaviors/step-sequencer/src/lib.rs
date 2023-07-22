use serde::{Deserialize, Serialize};

use mizer_node::*;

const VALUE_OUTPUT: &str = "Output";

const STEPS_SETTING: &str = "Steps";
const BAR_COUNT_SETTING: &str = "Bar Count";

const STEPS_IN_BAR: usize = 16;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct StepSequencerNode {
    pub steps: Vec<bool>,
    pub bar_count: u32,
}

impl Default for StepSequencerNode {
    fn default() -> Self {
        let count = 1;
        Self {
            steps: vec![false; count * STEPS_IN_BAR],
            bar_count: count as u32,
        }
    }
}

impl ConfigurableNode for StepSequencerNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![
            setting!(STEPS_SETTING, self.steps.clone()),
            // setting!(BAR_COUNT_SETTING, self.bar_count) // TODO: implement support for variable bar count
            //     .min(1u32)
            //     .max(16u32),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(steps setting, STEPS_SETTING, self.steps);
        update!(uint setting, BAR_COUNT_SETTING, self.bar_count);

        update_fallback!(setting)
    }
}

impl PipelineNode for StepSequencerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "Step Sequencer".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_OUTPUT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::StepSequencer
    }
}

impl ProcessingNode for StepSequencerNode {
    type State = StepSequencerState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if self.steps.is_empty() {
            return Ok(());
        }
        if self.steps.len() != state.already_hit.len() {
            state.already_hit = self.steps.iter().map(|_| false).collect();
        };
        let frame = context.clock();

        let mut value = false;
        for (i, step) in self.steps.iter().enumerate() {
            let already_hit = state.already_hit[i];
            if !*step {
                continue;
            }
            let beat = (i as f64) * 0.25;

            if frame.beat > beat && !already_hit {
                value = true;
                state.already_hit[i] = true;
                break;
            }
            if frame.beat < beat || frame.downbeat {
                state.already_hit[i] = false;
            }
        }

        let value = if value { 1.0 } else { 0.0 };

        context.write_port(VALUE_OUTPUT, value);
        context.push_history_value(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        StepSequencerState {
            already_hit: self.steps.iter().map(|_| false).collect(),
        }
    }
}

#[derive(Default, Clone)]
pub struct StepSequencerState {
    already_hit: Vec<bool>,
}
