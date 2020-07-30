use derive_more::From;

use mizer_node_api::*;

pub use mizer_artnet_nodes::*;
pub use mizer_conversion_nodes::*;
pub use mizer_input_nodes::*;
pub use mizer_log_nodes::*;
pub use mizer_sequence_nodes::*;
pub use mizer_oscillator_nodes::*;
pub use mizer_clock_nodes::*;
pub use mizer_osc_nodes::*;
pub use mizer_video_nodes::*;
pub use mizer_scripting_nodes::*;

#[derive(From)]
pub enum Node<'a> {
    Fader(FaderNode),
    ConvertToDmxNode(ConvertToDmxNode),
    LogNode(LogNode),
    ArtnetOutputNode(ArtnetOutputNode),
    OscillatorNode(OscillatorNode),
    ClockNode(ClockNode),
    OscInputNode(OscInputNode),
    VideoFileNode(VideoFileNode),
    VideoOutputNode(VideoOutputNode),
    VideoEffectNode(VideoEffectNode),
    ScriptingNode(ScriptingNode<'a>)
}

macro_rules! derive_node {
    ($($i:path),*) => {
        impl<'a> ProcessingNode for Node<'a> {
            derive_process!($($i), *);
        }

        impl<'a> InputNode for Node<'a> {
            derive_input!($($i), *);
        }

        impl<'a> OutputNode for Node<'a> {
            derive_output!($($i), *);
        }
    }
}

macro_rules! derive_process {
    ($($i:path),*) => {
        fn process(&mut self) {
            match self {
                $($i(node) => node.process(),)*
            }
        }
    };
}

macro_rules! derive_input {
    ($($i:path),*) => {
        fn connect_dmx_input(&mut self, channels: &[DmxChannel]) {
            match self {
                $($i(node) => node.connect_dmx_input(channels),)*
            }
        }

        fn connect_numeric_input(&mut self, channel: NumericChannel) {
            match self {
                $($i(node) => node.connect_numeric_input(channel),)*
            }
        }
    };
}

macro_rules! derive_output {
    ($($i:path),*) => {
        fn connect_to_dmx_input(&mut self, input: &mut impl InputNode) {
            match self {
                $($i(node) => node.connect_to_dmx_input(input),)*
            }
        }

        fn connect_to_numeric_input(&mut self, input: &mut impl InputNode) {
            match self {
                $($i(node) => node.connect_to_numeric_input(input),)*
            }
        }
    };
}

derive_node! {
    Node::Fader,
    Node::ConvertToDmxNode,
    Node::LogNode,
    Node::ArtnetOutputNode,
    Node::OscillatorNode,
    Node::ClockNode,
    Node::OscInputNode,
    Node::VideoFileNode,
    Node::VideoOutputNode,
    Node::VideoEffectNode,
    Node::ScriptingNode
}
