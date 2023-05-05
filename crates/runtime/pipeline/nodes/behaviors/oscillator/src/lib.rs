use std::f64::consts::PI;

use serde::{Deserialize, Serialize};

use mizer_node::*;

const INTERVAL_INPUT_PORT: &str = "Interval";
const MIN_INPUT_PORT: &str = "Min";
const MAX_INPUT_PORT: &str = "Max";
const VALUE_OUTPUT_PORT: &str = "Value";

#[derive(Clone, Copy, Debug, Default, Serialize, Deserialize, PartialEq, Eq)]
#[serde(rename_all = "lowercase")]
pub enum OscillatorType {
    Square,
    #[default]
    Sine,
    Saw,
    Triangle,
}

#[derive(Debug, Clone, Copy, Deserialize, Serialize, PartialEq)]
pub struct OscillatorNode {
    #[serde(rename = "type")]
    pub oscillator_type: OscillatorType,
    #[serde(alias = "ratio", default = "default_interval")]
    pub interval: f64,
    #[serde(default = "default_max")]
    pub max: f64,
    #[serde(default = "default_min")]
    pub min: f64,
    #[serde(default)]
    pub offset: f64,
    #[serde(default)]
    pub reverse: bool,
}

impl Default for OscillatorNode {
    fn default() -> Self {
        OscillatorNode {
            oscillator_type: Default::default(),
            interval: 1f64,
            max: 1f64,
            min: 0f64,
            offset: 0f64,
            reverse: false,
        }
    }
}

fn default_interval() -> f64 {
    OscillatorNode::default().interval
}

fn default_min() -> f64 {
    OscillatorNode::default().min
}

fn default_max() -> f64 {
    OscillatorNode::default().max
}

impl PipelineNode for OscillatorNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(OscillatorNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            output_port!(VALUE_OUTPUT_PORT, PortType::Single),
            input_port!(INTERVAL_INPUT_PORT, PortType::Single),
            input_port!(MIN_INPUT_PORT, PortType::Single),
            input_port!(MAX_INPUT_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Oscillator
    }
}

impl ProcessingNode for OscillatorNode {
    type State = ();

    fn process(&self, context: &impl NodeContext, _state: &mut Self::State) -> anyhow::Result<()> {
        let clock = context.clock();
        let oscillator = OscillatorContext::read(self, context);
        let value = oscillator.tick(clock.frame);
        context.write_port(VALUE_OUTPUT_PORT, value);
        context.push_history_value(value);
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.oscillator_type = config.oscillator_type;
        self.min = config.min;
        self.max = config.max;
        self.offset = config.offset;
        self.interval = config.interval;
        self.reverse = config.reverse;
    }
}

struct OscillatorContext {
    pub oscillator_type: OscillatorType,
    pub interval: f64,
    pub max: f64,
    pub min: f64,
    pub offset: f64,
    pub reverse: bool,
}

impl Default for OscillatorContext {
    fn default() -> Self {
        let node = OscillatorNode::default();

        Self {
            oscillator_type: node.oscillator_type,
            interval: node.interval,
            min: node.min,
            max: node.max,
            offset: node.offset,
            reverse: node.reverse,
        }
    }
}

impl OscillatorContext {
    fn read(node: &OscillatorNode, context: &impl NodeContext) -> Self {
        Self {
            oscillator_type: node.oscillator_type,
            interval: context
                .read_port::<_, f64>(INTERVAL_INPUT_PORT)
                .unwrap_or(node.interval),
            min: context
                .read_port::<_, f64>(MIN_INPUT_PORT)
                .unwrap_or(node.min),
            max: context
                .read_port::<_, f64>(MAX_INPUT_PORT)
                .unwrap_or(node.max),
            offset: node.offset,
            reverse: node.reverse,
        }
    }

    fn tick(&self, beat: f64) -> f64 {
        if self.interval - f64::EPSILON <= 0. {
            return self.min;
        }
        match &self.oscillator_type {
            OscillatorType::Square => {
                let base = self.interval * 0.5;
                let frame = self.get_frame(beat);
                if frame > base {
                    self.min
                } else {
                    self.max
                }
            }
            OscillatorType::Sine => {
                let min = self.min;
                let max = self.max;
                let offset = (max - min) / 2f64;
                let value = f64::sin(
                    (3f64 / 2f64) * PI
                        + PI * ((beat + self.offset) * 2f64) * (1f64 / self.interval),
                ) * offset
                    + offset
                    + min;
                let value = value.clamp(min, max);
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
                let base = self.interval / 2f64;
                let frame = self.get_frame(beat);
                let high = self.max;
                let low = self.min;

                if frame > base {
                    ((high - low) / base) * (base - frame) + high
                } else {
                    ((high - low) / base) * frame + low
                }
            }
            OscillatorType::Saw => {
                let frame = self.get_frame(beat);
                let high = self.max;
                let low = self.min;

                ((high - low) / self.interval) * frame + low
            }
        }
    }

    fn get_frame(&self, beat: f64) -> f64 {
        let mut frame = beat + self.offset;
        if self.interval == 0. {
            return frame;
        }
        while frame > self.interval {
            frame -= self.interval;
        }
        frame
    }
}

#[cfg(test)]
mod tests {
    use test_case::test_case;

    use crate::{OscillatorContext, OscillatorType};

    #[test_case(0.)]
    #[test_case(5.)]
    fn triangle_oscillator_should_start_at_min(min: f64) {
        let node = OscillatorContext {
            oscillator_type: OscillatorType::Triangle,
            min,
            ..Default::default()
        };

        let value = node.tick(0.);

        assert_eq!(value, min);
    }

    #[test_case(0.)]
    #[test_case(5.)]
    fn triangle_oscillator_should_end_at_min(min: f64) {
        let node = OscillatorContext {
            oscillator_type: OscillatorType::Triangle,
            min,
            ..Default::default()
        };

        let value = node.tick(1.);

        assert_eq!(value, min);
    }

    #[test_case(1.)]
    #[test_case(5.)]
    fn triangle_oscillator_should_reach_max_at_halfway_point(max: f64) {
        let node = OscillatorContext {
            oscillator_type: OscillatorType::Triangle,
            max,
            ..Default::default()
        };

        let value = node.tick(0.5);

        assert_eq!(value, max);
    }

    #[test_case(0.)]
    #[test_case(5.)]
    fn saw_oscillator_should_start_at_min(min: f64) {
        let node = OscillatorContext {
            oscillator_type: OscillatorType::Saw,
            min,
            ..Default::default()
        };

        let value = node.tick(0.);

        assert_eq!(value, min);
    }

    #[test_case(1.)]
    #[test_case(5.)]
    fn saw_oscillator_should_end_at_max(max: f64) {
        let node = OscillatorContext {
            oscillator_type: OscillatorType::Saw,
            max,
            ..Default::default()
        };

        let value = node.tick(1.);

        assert_eq!(value, max);
    }

    #[test_case(OscillatorType::Sine)]
    #[test_case(OscillatorType::Saw)]
    #[test_case(OscillatorType::Triangle)]
    #[test_case(OscillatorType::Square)]
    fn oscillator_should_return_0_for_interval_of_0(oscillator: OscillatorType) {
        let node = OscillatorContext {
            oscillator_type: oscillator,
            interval: 0.,
            ..Default::default()
        };

        let value = node.tick(1.);

        assert_eq!(0., value);
    }

    #[test_case(OscillatorType::Sine)]
    #[test_case(OscillatorType::Saw)]
    #[test_case(OscillatorType::Triangle)]
    #[test_case(OscillatorType::Square)]
    fn oscillator_should_return_0_for_interval_below_0(oscillator: OscillatorType) {
        let node = OscillatorContext {
            oscillator_type: oscillator,
            interval: -0.1,
            ..Default::default()
        };

        let value = node.tick(1.);

        assert_eq!(0., value);
    }
}
