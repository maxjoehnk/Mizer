use serde::{Deserialize, Serialize};

use mizer_node::*;

const VALUE_OUTPUT: &str = "Output";
const STEPS_INPUT: &str = "Steps";
const STEPS_OUTPUT: &str = "Steps";
const BEAT_OUTPUT: &str = "Beat";

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
        vec![
            output_port!(VALUE_OUTPUT, PortType::Single),
            input_port!(STEPS_INPUT, PortType::Multi),
            output_port!(STEPS_OUTPUT, PortType::Multi, count: self.steps.len() as u64),
            output_port!(BEAT_OUTPUT, PortType::Single),
        ]
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
        let steps = if let Some(steps) = context.multi_input(STEPS_INPUT).read() {
            let mut steps: Vec<_> = steps
                .into_iter()
                .map(|step| step > 0f64 + f64::EPSILON)
                .collect();
            steps.resize(self.steps.len(), false);
            steps
        } else {
            self.steps.clone()
        };
        if steps.len() != state.already_hit.len() {
            state.already_hit = steps.iter().map(|_| false).collect();
        };
        let frame = context.clock();

        let mut value = false;
        for (i, step) in steps.iter().enumerate() {
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

        context.write_port(
            STEPS_OUTPUT,
            steps
                .into_iter()
                .map(|step| step.into())
                .collect::<port_types::MULTI>(),
        );

        context.write_port(BEAT_OUTPUT, frame.beat);

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
