use enum_iterator::Sequence;
use mizer_node::edge::Edge;
use mizer_node::*;
use num_enum::{IntoPrimitive, TryFromPrimitive};
use serde::{Deserialize, Serialize};
use std::fmt::{Display, Formatter};

const VALUE_OUTPUT: &str = "Output";
const STEPS_INPUT: &str = "Steps";
const STEPS_OUTPUT: &str = "Steps";
const BEAT_OUTPUT: &str = "Beat";

const STEPS_SETTING: &str = "Steps";
const BAR_COUNT_SETTING: &str = "Bar Count";
const OUTPUT_WIDTH_SETTING: &str = "Output Width";
const INPUT_MODE_SETTING: &str = "Input Mode";

const STEPS_IN_BAR: usize = 16;

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct StepSequencerNode {
    pub steps: Vec<bool>,
    pub bar_count: u32,
    #[serde(default)]
    pub output_width_mode: OutputWidth,
    #[serde(default)]
    pub input_mode: InputMode,
}

#[derive(
    Debug,
    Default,
    Clone,
    Copy,
    Deserialize,
    Serialize,
    PartialEq,
    Eq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[repr(u8)]
pub enum OutputWidth {
    #[default]
    Pulse,
    Step,
}

impl Display for OutputWidth {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

#[derive(
    Debug,
    Default,
    Clone,
    Copy,
    Deserialize,
    Serialize,
    PartialEq,
    Eq,
    Sequence,
    TryFromPrimitive,
    IntoPrimitive,
)]
#[repr(u8)]
pub enum InputMode {
    #[default]
    Hold,
    Toggle,
}

impl Display for InputMode {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        write!(f, "{self:?}")
    }
}

impl Default for StepSequencerNode {
    fn default() -> Self {
        let count = 1;
        Self {
            steps: vec![false; count * STEPS_IN_BAR],
            bar_count: count as u32,
            output_width_mode: OutputWidth::default(),
            input_mode: InputMode::default(),
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
            setting!(enum OUTPUT_WIDTH_SETTING, self.output_width_mode),
            setting!(enum INPUT_MODE_SETTING, self.input_mode),
        ]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(steps setting, STEPS_SETTING, self.steps);
        update!(uint setting, BAR_COUNT_SETTING, self.bar_count);
        update!(enum setting, OUTPUT_WIDTH_SETTING, self.output_width_mode);
        update!(enum setting, INPUT_MODE_SETTING, self.input_mode);

        update_fallback!(setting)
    }
}

impl PipelineNode for StepSequencerNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Step Sequencer".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
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
        state.update_baseline(&self.steps);
        if let Some(input) = context.multi_input(STEPS_INPUT).read() {
            if self.input_mode == InputMode::Hold {
                let mut steps: Vec<_> = input
                    .into_iter()
                    .map(|step| step > 0f64 + f64::EPSILON)
                    .collect();
                steps.resize(self.steps.len(), false);

                state.values = steps;
            }else if self.input_mode == InputMode::Toggle {
                state.update_edges(input);
            }
        }

        let steps = &state.values;
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
            let next_beat = ((i + 1) as f64) * 0.25;

            match self.output_width_mode {
                OutputWidth::Step => {
                    if (frame.beat > beat) && (frame.beat <= next_beat) {
                        value = true;
                        state.already_hit[i] = true;
                        break;
                    }
                }
                OutputWidth::Pulse => {
                    if frame.beat > beat && !already_hit {
                        value = true;
                        state.already_hit[i] = true;
                        break;
                    }
                }
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
                .iter()
                .map(|step| (*step).into())
                .collect::<port_types::MULTI>(),
        );

        context.write_port(BEAT_OUTPUT, frame.beat);

        state.last_beat = (frame.beat / 0.25).floor() as u8;

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        StepSequencerState {
            already_hit: self.steps.iter().map(|_| false).collect(),
            baseline: self.steps.clone(),
            values: self.steps.clone(),
            edges: self.steps.iter().map(|v| Edge::new()).collect(),
            last_beat: 0,
        }
    }
}

impl StepSequencerNode {
    pub fn value(&self, state: &StepSequencerState) -> [bool; 16] {
        debug_assert!(state.values.len() == 16, "TODO: implement support for variable bar count");
        let mut steps = [false; 16];
        steps.copy_from_slice(&state.values);

        steps
    }

    pub fn beat(&self, state: &StepSequencerState) -> u8 {
        state.last_beat
    }
}

#[derive(Default, Clone)]
pub struct StepSequencerState {
    already_hit: Vec<bool>,
    baseline: Vec<bool>,
    values: Vec<bool>,
    edges: Vec<Edge>,
    last_beat: u8,
}

impl StepSequencerState {
    fn update_baseline(&mut self, steps: &[bool]) {
        debug_assert!(self.edges.len() == steps.len(), "TODO: implement support for variable bar count");
        for ((baseline, step), value) in self.baseline.iter_mut().zip(steps).zip(self.values.iter_mut()) {
            if *baseline != *step {
                *baseline = *step;
                *value = *step;
            }
        }
    }

    fn update_edges(&mut self, input: port_types::MULTI) {
        for (i, (edge, value)) in self.edges.iter_mut().zip(input.into_iter()).enumerate() {
            if let Some(true) = edge.update(value) {
                self.values[i] = !self.values[i];
            }
        }
    }
}
