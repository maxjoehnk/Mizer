use rand::prelude::*;
use serde::{Deserialize, Serialize};

use mizer_node::*;
use mizer_util::LerpExt;

const VALUE_OUTPUT: &str = "Value";

#[derive(Clone, Debug, Deserialize, Serialize, PartialEq)]
pub struct NoiseNode {
    pub tick_rate: u64,
    pub fade: bool,
}

impl Default for NoiseNode {
    fn default() -> Self {
        Self {
            tick_rate: 1,
            fade: true,
        }
    }
}

impl PipelineNode for NoiseNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(NoiseNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![output_port!(VALUE_OUTPUT, PortType::Single)]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Noise
    }
}

impl ProcessingNode for NoiseNode {
    type State = NoiseNodeState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let value = state.next(&self);
        context.push_history_value(value);
        context.write_port(VALUE_OUTPUT, value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }

    fn update(&mut self, config: &Self) {
        self.tick_rate = config.tick_rate;
        self.fade = config.fade;
    }
}

pub struct NoiseNodeState {
    rng: ThreadRng,
    last_tick: u64,
    last_value: (u64, f64),
    next_value: f64,
}

impl Default for NoiseNodeState {
    fn default() -> Self {
        let mut rng = thread_rng();
        let value = rng.gen();

        Self {
            rng,
            last_tick: 0,
            last_value: (0, 0f64),
            next_value: value,
        }
    }
}

impl NoiseNodeState {
    fn next(&mut self, config: &NoiseNode) -> f64 {
        self.last_tick += 1;
        if self.last_tick < self.last_value.0 + config.tick_rate {
            if config.fade {
                let min_tick = self.last_value.0;
                let max_tick = self.last_value.0 + config.tick_rate;

                self.last_tick
                    .linear_extrapolate((min_tick, max_tick), (self.last_value.1, self.next_value))
            } else {
                self.last_value.1
            }
        } else {
            let value = self.next_value;
            self.last_value = (self.last_tick, value);
            self.next_value = self.rng.gen();

            value
        }
    }
}

#[cfg(test)]
mod tests {
    use crate::{NoiseNode, NoiseNodeState};
    use test_case::test_case;

    #[test_case(1f64, 2, 0, 0)]
    #[test_case(0f64, 2, 0, 0)]
    #[test_case(0f64, 2, 2, 2)]
    #[test_case(0f64, 10, 5, 0)]
    fn next_should_return_previous_value_when_tick(
        value: f64,
        tick_rate: u64,
        last_tick: u64,
        last_value_tick: u64,
    ) {
        let config = NoiseNode {
            tick_rate,
            fade: false,
        };
        let mut state = NoiseNodeState {
            last_value: (last_value_tick, value),
            last_tick,
            ..Default::default()
        };

        let result = state.next(&config);

        assert_eq!(value, result);
    }
}
