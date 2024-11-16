use serde::{Deserialize, Serialize};

use mizer_node::edge::Edge;
use mizer_node::*;

const TAP_INPUT: &str = "Tap";
const RESYNC_INPUT: &str = "Resync";
const PLAY_INPUT: &str = "Play";
const PAUSE_INPUT: &str = "Pause";
const STOP_INPUT: &str = "Stop";
const BPM_INPUT: &str = "Tempo";
const BPM_OUTPUT: &str = "Tempo";
const PLAYING_OUTPUT: &str = "Playing";
const CLOCK_OUTPUT: &str = "Clock";

#[derive(Debug, Default, Clone, Deserialize, Serialize, PartialEq, Eq)]
pub struct TransportNode;

impl ConfigurableNode for TransportNode {}

impl PipelineNode for TransportNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "Transport".into(),
            preview_type: PreviewType::None,
            category: NodeCategory::None,
        }
    }

    fn list_ports(&self, _injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        vec![
            input_port!(TAP_INPUT, PortType::Single),
            input_port!(RESYNC_INPUT, PortType::Single),
            input_port!(PLAY_INPUT, PortType::Single),
            input_port!(PAUSE_INPUT, PortType::Single),
            input_port!(STOP_INPUT, PortType::Single),
            input_port!(BPM_INPUT, PortType::Single),
            output_port!(BPM_OUTPUT, PortType::Single),
            output_port!(PLAYING_OUTPUT, PortType::Single),
            output_port!(CLOCK_OUTPUT, PortType::Clock),
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
            context.tap_clock();
        }
        if let Some(true) = context
            .read_port(RESYNC_INPUT)
            .and_then(|value| state.resync_edge.update(value))
        {
            context.resync_clock();
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
        context.write_port::<_, port_types::CLOCK>(
            CLOCK_OUTPUT,
            context.clock().to_duration(context.fps()),
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
    resync_edge: Edge,
    play_edge: Edge,
    pause_edge: Edge,
    stop_edge: Edge,
}
