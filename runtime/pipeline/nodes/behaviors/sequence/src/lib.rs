use serde::{Deserialize, Serialize};

use mizer_node::*;

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct SequenceStep {
    pub tick: f64,
    pub value: f64,
    #[serde(default)]
    pub hold: bool,
}

impl From<(f64, f64)> for SequenceStep {
    fn from((tick, value): (f64, f64)) -> Self {
        SequenceStep {
            tick,
            value,
            hold: false,
        }
    }
}

impl From<(f64, f64, bool)> for SequenceStep {
    fn from((tick, value, hold): (f64, f64, bool)) -> Self {
        SequenceStep { tick, value, hold }
    }
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct SequenceNode {
    pub steps: Vec<SequenceStep>,
}

pub struct SequenceState {
    beat: f64,
    speed: f64,
    active: bool,
}

impl Default for SequenceState {
    fn default() -> Self {
        Self {
            beat: 0.,
            speed: 1.,
            active: true,
        }
    }
}

impl PipelineNode for SequenceNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: "SequenceNode".into(),
            preview_type: PreviewType::History,
        }
    }

    fn introspect_port(&self, port: &PortId) -> Option<PortMetadata> {
        (port == "value").then(|| PortMetadata {
            port_type: PortType::Single,
            direction: PortDirection::Output,
            ..Default::default()
        })
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![(
            "value".into(),
            PortMetadata {
                port_type: PortType::Single,
                direction: PortDirection::Output,
                ..Default::default()
            },
        )]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Sequence
    }
}

impl ProcessingNode for SequenceNode {
    type State = SequenceState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if self.steps.is_empty() {
            return Ok(());
        }
        if !state.active {
            return Ok(());
        }
        let frame = context.clock();
        state.tick(frame);
        let value = state.get_frame(&self.steps);

        context.write_port("value", value);
        context.push_history_value(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl SequenceState {
    fn tick(&mut self, frame: ClockFrame) {
        self.beat += frame.delta * self.speed;
        while self.beat > 4. {
            self.beat -= 4.;
        }
    }

    fn get_frame(&self, steps: &[SequenceStep]) -> f64 {
        let first_step = steps
            .iter()
            .filter(|step| step.tick < self.beat)
            .last()
            .or_else(|| steps.last())
            .cloned()
            .unwrap();
        let last_step = steps
            .iter()
            .find(|step| step.tick >= self.beat)
            .or_else(|| steps.first())
            .cloned()
            .unwrap();
        if first_step.hold {
            return first_step.value;
        }

        let time = self.beat - first_step.tick;
        let duration = if first_step.tick <= last_step.tick {
            last_step.tick - first_step.tick
        } else {
            (last_step.tick + 4.) - first_step.tick
        };

        let value = ((last_step.value - first_step.value) / duration) * time + first_step.value;

        value.min(1.).max(0.)
    }
}
