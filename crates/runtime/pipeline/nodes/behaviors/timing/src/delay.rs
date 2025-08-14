use std::collections::VecDeque;

use serde::{Deserialize, Serialize};

use mizer_node::*;

const INPUT_VALUE_PORT: &str = "Input";
const OUTPUT_VALUE_PORT: &str = "Output";

const BUFFER_SIZE_INPUT: &str = "Delay";
const BUFFER_SIZE_SETTING: &str = "Buffer Size";

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct DelayNode {
    pub buffer_size: f64,
}

impl Default for DelayNode {
    fn default() -> Self {
        Self { buffer_size: 1. }
    }
}

impl ConfigurableNode for DelayNode {
    fn settings(&self, _injector: &Injector) -> Vec<NodeSetting> {
        vec![setting!(BUFFER_SIZE_SETTING, self.buffer_size).label("Delay (Beats)")
            .min(0.)
            .max_hint(4.)
            .step_size(1.)]
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(float  setting, BUFFER_SIZE_SETTING, self.buffer_size);

        update_fallback!(setting)
    }
}

impl PipelineNode for DelayNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Delay".into(),
            preview_type: PreviewType::History,
            category: NodeCategory::Standard,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(INPUT_VALUE_PORT, PortType::Single),
            input_port!(BUFFER_SIZE_INPUT, PortType::Single),
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
        let delay_in_beats = context.read_port(BUFFER_SIZE_INPUT)
            .unwrap_or(self.buffer_size);
        let bpm = context.clock().speed;
        let fps = context.fps();

        let buffer_size = ((delay_in_beats * fps * 60.) / bpm).round() as usize;

        state.check_size(buffer_size);
        if let Some(value) = context.read_port(INPUT_VALUE_PORT) {
            state.push_value(value);
        } else {
            state.repeat_last_value();
        }

        let value = state.last_value();

        context.write_port(OUTPUT_VALUE_PORT, value);
        context.push_history_value(value);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        DelayBuffer::default()
    }

    fn debug_ui<'a>(&self, ui: &mut impl DebugUiDrawHandle<'a>, state: &Self::State) {
        ui.label(format!("Delay Buffer Size: {}", state.buffer.len()));
    }
}

#[derive(Debug)]
pub struct DelayBuffer {
    buffer: VecDeque<f64>,
}

impl Default for DelayBuffer {
    fn default() -> Self {
        let buffer = Vec::with_capacity(6000);

        Self {
            buffer: VecDeque::from(buffer),
        }
    }
}

impl DelayBuffer {
    fn check_size(&mut self, size: usize) {
        if self.buffer.len() == size {
            return;
        }
        // FIXME: we should probably keep popped values in storage so we can fill the deque when the size has increased
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
