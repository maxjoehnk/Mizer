use std::f64::consts::PI;

use mizer_node_api::*;

pub struct OscillatorNode {
    pub oscillator_type: OscillatorType,
    pub ratio: f64,
    pub max: f64,
    pub min: f64,
    pub offset: f64,
    pub reverse: bool,
    pub clock: Option<ClockChannel>,
    pub beat: f64,
    pub outputs: Vec<NumericSender>,
}

impl OscillatorNode {
    pub fn new(oscillator_type: OscillatorType) -> Self {
        OscillatorNode {
            oscillator_type,
            ratio: 1f64,
            max: 255f64,
            min: 0f64,
            offset: 0f64,
            reverse: false,
            clock: None,
            beat: 0f64,
            outputs: Vec::new(),
        }
    }
}

impl ProcessingNode for OscillatorNode {
    fn get_details(&self) -> NodeDetails {
        NodeDetails::new("OscillatorNode")
            .with_inputs(vec![NodeInput::new("clock", NodeChannel::Clock)])
            .with_outputs(vec![NodeOutput::numeric("value")])
    }

    fn process(&mut self) {
        if let Some(clock) = self.clock.as_ref() {
            for event in clock.recv_all().unwrap() {
                self.beat += event.delta;
            }
        }
        let value = self.tick(self.beat);
        for channel in &self.outputs {
            channel.send(value);
        }
    }
}

impl InputNode for OscillatorNode {
    fn connect_clock_input(&mut self, input: &str, channel: ClockChannel) -> ConnectionResult {
        if input == "clock" {
            self.clock = Some(channel);
            Ok(())
        } else {
            Err(ConnectionError::InvalidInput)
        }
    }
}

impl OutputNode for OscillatorNode {
    fn connect_to_numeric_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
        if output == "value" {
            let (tx, channel) = NumericChannel::new();
            node.connect_numeric_input(input, channel)?;
            self.outputs.push(tx);
            Ok(())
        }else {
            Err(ConnectionError::InvalidOutput)
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
                let value = f64::sin(
                    (3f64 / 2f64) * PI + PI * ((beat + self.offset) * 2f64) * (1f64 / self.ratio),
                ) * 127.5
                    + 127.5;
                value.floor()
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

#[derive(Clone, Copy, Debug)]
pub enum OscillatorType {
    Square,
    Sine,
    Saw,
    Triangle,
}
