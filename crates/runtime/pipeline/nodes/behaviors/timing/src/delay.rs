use serde::{Deserialize, Serialize};
use std::collections::VecDeque;

use mizer_node::*;

const INPUT_VALUE_PORT: &str = "value";
const OUTPUT_VALUE_PORT: &str = "value";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct DelayNode {
    pub buffer_size: usize,
}

impl Default for DelayNode {
    fn default() -> Self {
        Self { buffer_size: 1 }
    }
}

impl PipelineNode for DelayNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(DelayNode).into(),
            preview_type: PreviewType::History,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_VALUE_PORT, PortType::Single),
            output_port!(OUTPUT_VALUE_PORT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Delay
    }
}

impl ProcessingNode for DelayNode {
    type State = DelayBuffer;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        state.check_size(self.buffer_size);
        if let Some(value) = context.read_port(INPUT_VALUE_PORT) {
            state.push_value(value);
        } else {
            state.repeat_last_value();
        }

        let value = state.last_value();

        context.write_port("value", value);
        context.push_history_value(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        DelayBuffer::new(self.buffer_size)
    }

    fn update(&mut self, config: &Self) {
        self.buffer_size = config.buffer_size;
    }
}

#[derive(Debug, Default)]
pub struct DelayBuffer {
    buffer: VecDeque<f64>,
}

impl DelayBuffer {
    fn new(size: usize) -> Self {
        let buffer = vec![0f64; size];

        Self {
            buffer: VecDeque::from(buffer),
        }
    }

    fn check_size(&mut self, size: usize) {
        if self.buffer.len() == size {
            return;
        }
        self.buffer.resize(size, 0f64);
    }

    fn push_value(&mut self, value: f64) {
        self.buffer.push_front(value);
    }

    fn repeat_last_value(&mut self) {
        let value = self.buffer.front().copied().unwrap_or_default();
        self.buffer.push_front(value);
    }

    fn last_value(&mut self) -> f64 {
        self.buffer.pop_back().unwrap_or_default()
    }
}
