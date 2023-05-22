use serde::{Deserialize, Serialize};
use std::time::Instant;

use mizer_node::edge::Edge;
use mizer_node::*;

const TAP_INPUT: &str = "Tap";
const PLAY_INPUT: &str = "Play";
const PAUSE_INPUT: &str = "Pause";
const STOP_INPUT: &str = "Stop";
const BPM_INPUT: &str = "Tempo";
const BPM_OUTPUT: &str = "Tempo";
const PLAYING_OUTPUT: &str = "Playing";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct TransportNode;

impl ConfigurableNode for TransportNode {}

impl PipelineNode for TransportNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            name: stringify!(TransportNode).into(),
            preview_type: PreviewType::None,
        }
    }

    fn list_ports(&self) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(TAP_INPUT, PortType::Single),
            input_port!(PLAY_INPUT, PortType::Single),
            input_port!(PAUSE_INPUT, PortType::Single),
            input_port!(STOP_INPUT, PortType::Single),
            input_port!(BPM_INPUT, PortType::Single),
            output_port!(BPM_OUTPUT, PortType::Single),
            output_port!(PLAYING_OUTPUT, PortType::Single),
        ]
    }

    fn node_type(&self) -> NodeType {
        NodeType::Transport
    }
}

impl ProcessingNode for TransportNode {
    type State = TransportState;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        if let Some(true) = context
            .read_port(TAP_INPUT)
            .and_then(|value| state.tap_edge.update(value))
        {
            if let Some(speed) = state.tapper.tap() {
                context.write_clock_tempo(speed);
            }
        }
        if let Some(speed) = context.read_port_changes(BPM_INPUT) {
            context.write_clock_tempo(speed);
        }
        if let Some(true) = context
            .read_port(PLAY_INPUT)
            .and_then(|value| state.play_edge.update(value))
        {
            context.write_clock_state(ClockState::Playing);
        }
        if let Some(true) = context
            .read_port(PAUSE_INPUT)
            .and_then(|value| state.pause_edge.update(value))
        {
            context.write_clock_state(ClockState::Paused);
        }
        if let Some(true) = context
            .read_port(STOP_INPUT)
            .and_then(|value| state.stop_edge.update(value))
        {
            context.write_clock_state(ClockState::Stopped);
        }
        context.write_port(BPM_OUTPUT, context.clock().speed);
        context.write_port(
            PLAYING_OUTPUT,
            if matches!(context.clock_state(), ClockState::Playing) {
                1f64
            } else {
                0f64
            },
        );
        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

#[derive(Default)]
pub struct TransportState {
    tap_edge: Edge,
    play_edge: Edge,
    pause_edge: Edge,
    stop_edge: Edge,
    tapper: Tapper,
}

struct Tapper {
    last_tap: Instant,
    bpm: Option<f64>,
    last_bpms: Vec<f64>,
}

impl Default for Tapper {
    fn default() -> Self {
        Self {
            last_tap: Instant::now(),
            bpm: Default::default(),
            last_bpms: Default::default(),
        }
    }
}

impl Tapper {
    fn tap(&mut self) -> Option<f64> {
        let tap = Instant::now();
        let duration = tap - self.last_tap;
        if duration.as_millis() > 2000 {
            self.last_tap = tap;
            self.last_bpms.clear();
            self.bpm = None;

            return None;
        }
        let bpm = 60000f64 / duration.as_millis() as f64;
        self.last_bpms.push(bpm);
        if self.bpm.is_none() {
            self.bpm = Some(bpm);
        } else {
            let bpm_sum: f64 = self.last_bpms.iter().copied().sum();
            let average = bpm_sum / self.last_bpms.len() as f64;

            self.bpm = Some(average);
        }
        self.last_tap = tap;

        self.bpm.map(|bpm| bpm.round())
    }
}
