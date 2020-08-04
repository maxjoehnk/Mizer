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
pub use mizer_pixel_nodes::*;
pub use mizer_opc_nodes::*;

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
    VideoTransformNode(VideoTransformNode),
    ScriptingNode(ScriptingNode<'a>),
    PixelOutputNode(PixelDmxNode),
    PixelPatternNode(PixelPatternGeneratorNode),
    OpcOutputNode(OpcOutputNode),
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

        impl<'a> std::fmt::Debug for Node<'a> {
            derive_debug!($($i), *);
        }
    }
}

macro_rules! derive_process {
    ($($i:path),*) => {
        fn get_details(&self) -> NodeDetails {
            match self {
                $($i(node) => node.get_details(),)*
            }
        }

        fn process(&mut self) {
            match self {
                $($i(node) => node.process(),)*
            }
        }
    };
}

macro_rules! derive_input {
    ($($i:path),*) => {
        fn connect_dmx_input(&mut self, input: &str, channels: &[DmxChannel]) -> ConnectionResult {
            match self {
                $($i(node) => node.connect_dmx_input(input, channels),)*
            }
        }

        fn connect_numeric_input(&mut self, input: &str, channel: NumericChannel) -> ConnectionResult {
            match self {
                $($i(node) => node.connect_numeric_input(input, channel),)*
            }
        }

        fn connect_trigger_input(&mut self, input: &str, channel: TriggerChannel) -> ConnectionResult {
            match self {
                $($i(node) => node.connect_trigger_input(input, channel),)*
            }
        }

        fn connect_clock_input(&mut self, input: &str, channel: ClockChannel) -> ConnectionResult {
            match self {
                $($i(node) => node.connect_clock_input(input, channel),)*
            }
        }

        fn connect_video_input(&mut self, input: &str, source: &impl gstreamer::ElementExt) -> ConnectionResult {
            match self {
                $($i(node) => node.connect_video_input(input, source),)*
            }
        }

        fn connect_pixel_input(&mut self, input: &str, channel: PixelChannel) -> ConnectionResult {
            match self {
                $($i(node) => node.connect_pixel_input(input, channel),)*
            }
        }
    };
}

macro_rules! derive_output {
    ($($i:path),*) => {
        fn connect_to_dmx_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
            match self {
                $($i(this) => this.connect_to_dmx_input(output, node, input),)*
            }
        }

        fn connect_to_numeric_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
            match self {
                $($i(this) => this.connect_to_numeric_input(output, node, input),)*
            }
        }

        fn connect_to_trigger_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
            match self {
                $($i(this) => this.connect_to_trigger_input(output, node, input),)*
            }
        }

        fn connect_to_clock_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
            match self {
                $($i(this) => this.connect_to_clock_input(output, node, input),)*
            }
        }

        fn connect_to_video_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
            match self {
                $($i(this) => this.connect_to_video_input(output, node, input),)*
            }
        }

        fn connect_to_pixel_input(&mut self, output: &str, node: &mut impl InputNode, input: &str) -> ConnectionResult {
            match self {
                $($i(this) => this.connect_to_pixel_input(output, node, input),)*
            }
        }
    };
}

macro_rules! derive_debug {
    ($($i:path),*) => {
        fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
            match self {
                $($i(node) => node.get_details().fmt(f),)*
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
    Node::VideoTransformNode,
    Node::ScriptingNode,
    Node::PixelOutputNode,
    Node::PixelPatternNode,
    Node::OpcOutputNode
}
