use mizer_node_api::*;
use serde::{Deserialize, Serialize};

pub struct SequenceNode {
    clock: ClockChannel,
    speed_channels: Vec<NumericChannel>,
    active_channels: Vec<BoolChannel>,
    outputs: Vec<NumericSender>,
    steps: Vec<SequenceStep>,
    beat: f64,
    speed: f64,
    active: bool,
}

impl SequenceNode {
    pub fn new(steps: Vec<SequenceStep>, default_clock: ClockChannel) -> Self {
        SequenceNode {
            clock: default_clock,
            speed_channels: Default::default(),
            active_channels: Default::default(),
            outputs: Default::default(),
            steps,
            beat: 0f64,
            speed: 1f64,
            active: true,
        }
    }

    fn apply_clock_link(&mut self) {
        if let Some(beat) = self.clock.recv_last().unwrap() {
            self.beat += beat.delta * self.speed;
        }
    }

    fn apply_speed_links(&mut self) {
        for channel in &self.speed_channels {
            if let Some(speed) = channel.recv_last().unwrap() {
                self.speed = speed;
            }
        }
    }

    fn apply_active_links(&mut self) {
        for channel in &self.active_channels {
            if let Some(active) = channel.recv_last().unwrap() {
                self.active = active;
            }
        }
    }

    fn tick(&mut self) -> f64 {
        while self.beat > 4. {
            self.beat -= 4.;
        }
        let first_step = self
            .steps
            .iter()
            .filter(|step| step.tick < self.beat)
            .last()
            .or_else(|| self.steps.last())
            .cloned()
            .unwrap();
        let last_step = self
            .steps
            .iter()
            .find(|step| step.tick >= self.beat)
            .or_else(|| self.steps.first())
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

    fn send(&self, value: f64) {
        for output in &self.outputs {
            output.send(value);
        }
    }
}

impl NodeCreator for SequenceNode {
    fn create(context: &mut dyn NodeContext) -> Self {
        SequenceNode::new(Default::default(), context.connect_default_clock())
    }
}

impl ProcessingNode for SequenceNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("SequenceNode")
            .with_inputs(vec![
                NodeInput::numeric("speed"),
                NodeInput::new("clock", NodeChannel::Clock),
                // TODO: do we actually need this or can this be replaced with another node and a reset trigger?
                NodeInput::new("active", NodeChannel::Boolean),
            ])
            .with_outputs(vec![NodeOutput::numeric("value")])
            .with_properties(vec![NodeProperty::numeric("speed")])
    }

    fn process(&mut self) {
        if !self.active {
            return;
        }
        self.apply_speed_links();
        self.apply_clock_link();
        self.apply_active_links();
        let value = self.tick();

        self.send(value);
    }
}

impl SourceNode for SequenceNode {
    fn connect_numeric_input(&mut self, input: &str, channel: NumericChannel) -> ConnectionResult {
        if input == "speed" {
            self.speed_channels.push(channel);
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }

    fn connect_clock_input(&mut self, input: &str, channel: ClockChannel) -> ConnectionResult {
        if input == "clock" {
            self.clock = channel;
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}
impl DestinationNode for SequenceNode {
    fn connect_to_numeric_input(
        &mut self,
        output: &str,
        node: &mut impl SourceNode,
        input: &str,
    ) -> ConnectionResult {
        if output == "value" {
            let (sender, channel) = NumericChannel::new();
            self.outputs.push(sender);
            node.connect_numeric_input(input, channel)
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct SequenceStep {
    pub tick: f64,
    pub value: f64,
    #[serde(default)]
    pub hold: bool,
}
