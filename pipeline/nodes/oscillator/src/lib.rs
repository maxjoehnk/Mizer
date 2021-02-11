use serde::{Deserialize, Serialize};
use std::f64::consts::PI;

use mizer_node_api::*;

pub struct OscillatorNode {
    pub oscillator_type: OscillatorType,
    pub ratio: f64,
    pub max: f64,
    pub min: f64,
    pub offset: f64,
    pub reverse: bool,
    pub clock: ClockChannel,
    pub beat: f64,
    pub outputs: Vec<NumericSender>,
}

impl OscillatorNode {
    pub fn new(oscillator_type: OscillatorType, default_clock: ClockChannel) -> Self {
        OscillatorNode {
            oscillator_type,
            ratio: 1f64,
            max: 1f64,
            min: 0f64,
            offset: 0f64,
            reverse: false,
            clock: default_clock,
            beat: 0f64,
            outputs: Vec::new(),
        }
    }
}

impl NodeCreator for OscillatorNode {
    fn create(context: &mut dyn NodeContext) -> Self {
        OscillatorNode::new(Default::default(), context.connect_default_clock())
    }
}

impl ProcessingNode for OscillatorNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("OscillatorNode")
            .with_inputs(vec![NodeInput::new("clock", NodeChannel::Clock)])
            .with_outputs(vec![NodeOutput::numeric("value")])
    }

    fn process(&mut self) {
        for event in self.clock.recv_all().unwrap() {
            self.beat += event.delta;
        }
        let value = self.tick(self.beat);
        for channel in &self.outputs {
            channel.send(value);
        }
    }

    fn set_numeric_property(&mut self, property: &str, value: f64) {
        match property {
            "ratio" => self.ratio = value,
            "max" => self.max = value,
            "min" => self.min = value,
            "offset" => self.offset = value,
            _ => (),
        }
    }
}

impl SourceNode for OscillatorNode {
    fn connect_clock_input(&mut self, input: &str, channel: ClockChannel) -> ConnectionResult {
        if input == "clock" {
            self.clock = channel;
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl DestinationNode for OscillatorNode {
    fn connect_to_numeric_input(
        &mut self,
        output: &str,
        node: &mut impl SourceNode,
        input: &str,
    ) -> ConnectionResult {
        if output == "value" {
            let (tx, channel) = NumericChannel::new();
            node.connect_numeric_input(input, channel)?;
            self.outputs.push(tx);
            Ok(())
        } else {
            Err(ConnectionError::InvalidOutput(output.to_string()))
        }
    }
}

impl OscillatorNode {
    fn tick(&self, beat: f64) -> f64 {
        match &self.oscillator_type {
            OscillatorType::Square => {
                let base = self.ratio * 0.5;
                let frame = self.get_frame(beat);
                if frame > base {
                    self.min.clone()
                } else {
                    self.max.clone()
                }
            }
            OscillatorType::Sine => {
                let min = self.min.clone();
                let max = self.max.clone();
                let offset = (max - min) / 2f64;
                let value = f64::sin(
                    (3f64 / 2f64) * PI + PI * ((beat + self.offset) * 2f64) * (1f64 / self.ratio),
                ) * offset
                    + offset
                    + min;
                let value = value.max(min).min(max);
                log::trace!(
                    "min: {}, max: {}, offset: {}, result: {}",
                    min,
                    max,
                    offset,
                    value
                );
                value
            }
            OscillatorType::Triangle => {
                let base = self.ratio / 2f64;
                let frame = self.get_frame(beat);
                let time = if frame > base { frame - base } else { frame };
                let high = self.max;
                let low = self.min;
                let value = ((high - low) / self.ratio) * time + low;
                if frame > base {
                    let value = high - value;
                    value
                } else {
                    value
                }
            }
            oscillator => unimplemented!("{:?}", oscillator),
        }
    }

    fn get_frame(&self, beat: f64) -> f64 {
        let mut frame = beat + self.offset;
        while frame > self.ratio {
            frame -= self.ratio;
        }
        frame
    }
}

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum OscillatorType {
    Square,
    Sine,
    Saw,
    Triangle,
}

impl Default for OscillatorType {
    fn default() -> Self {
        OscillatorType::Sine
    }
}
