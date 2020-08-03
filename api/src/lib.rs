use thiserror::Error;

pub use crate::channels::*;

mod channels;

#[derive(Debug, Clone)]
pub struct NodeDetails {
    name: String,
    inputs: Vec<NodeInput>,
    outputs: Vec<NodeOutput>,
    properties: Vec<NodeProperty>,
}

impl NodeDetails {
    pub fn new<S: Into<String>>(name: S) -> Self {
        NodeDetails {
            name: name.into(),
            inputs: Vec::new(),
            outputs: Vec::new(),
            properties: Vec::new()
        }
    }

    pub fn with_inputs(self, inputs: Vec<NodeInput>) -> Self {
        NodeDetails {
            name: self.name,
            outputs: self.outputs,
            properties: self.properties,
            inputs
        }
    }

    pub fn with_outputs(self, outputs: Vec<NodeOutput>) -> Self {
        NodeDetails {
            name: self.name,
            inputs: self.inputs,
            properties: self.properties,
            outputs
        }
    }

    pub fn with_properties(self, properties: Vec<NodeProperty>) -> Self {
        NodeDetails {
            name: self.name,
            outputs: self.outputs,
            inputs: self.inputs,
            properties,
        }
    }
}

#[derive(Debug, Clone, Copy)]
pub enum NodeChannel {
    Dmx,
    Numeric,
    Trigger,
    Clock,
    Video,
    Color,
    Vector,
    Text,
    Midi,
    Timecode,
    Boolean,
    Select
}

#[derive(Debug, Clone)]
pub struct NodeInput {
    pub name: String,
    pub channel_type: NodeChannel
}

impl NodeInput {
    pub fn new<S: Into<String>>(name: S, channel_type: NodeChannel) -> Self {
        NodeInput {
            name: name.into(),
            channel_type
        }
    }

    pub fn dmx<S: Into<String>>(name: S) -> Self {
        NodeInput {
            name: name.into(),
            channel_type: NodeChannel::Dmx
        }
    }

    pub fn numeric<S: Into<String>>(name: S) -> Self {
        NodeInput {
            name: name.into(),
            channel_type: NodeChannel::Numeric
        }
    }
}

#[derive(Debug, Clone)]
pub struct NodeOutput {
    pub name: String,
    pub channel_type: NodeChannel
}

impl NodeOutput {
    pub fn new<S: Into<String>>(name: S, channel_type: NodeChannel) -> Self {
        NodeOutput {
            name: name.into(),
            channel_type
        }
    }

    pub fn dmx<S: Into<String>>(name: S) -> Self {
        NodeOutput {
            name: name.into(),
            channel_type: NodeChannel::Dmx
        }
    }

    pub fn numeric<S: Into<String>>(name: S) -> Self {
        NodeOutput {
            name: name.into(),
            channel_type: NodeChannel::Numeric
        }
    }
}

#[derive(Debug, Clone)]
pub struct NodeProperty {
    pub name: String,
    pub property_type: PropertyType
}

impl NodeProperty {
    pub fn new<S: Into<String>>(name: S, property_type: PropertyType) -> Self {
        NodeProperty {
            name: name.into(),
            property_type
        }
    }

    pub fn numeric<S: Into<String>>(name: S) -> Self {
        NodeProperty {
            name: name.into(),
            property_type: PropertyType::Numeric
        }
    }
}

#[derive(Debug, Clone, Copy)]
pub enum PropertyType {
    Numeric
}

pub trait ProcessingNode: InputNode + OutputNode {
    fn get_details(&self) -> NodeDetails;

    fn process(&mut self) {}

    fn set_numeric_property(&mut self, _property: &str, _value: f64) {}
}

pub trait InputNode {
    fn connect_dmx_input(&mut self, _input: &str, _channels: &[DmxChannel]) -> ConnectionResult {
        Err(ConnectionError::InvalidInput)
    }
    fn connect_numeric_input(&mut self, _input: &str, _channel: NumericChannel) -> ConnectionResult {
        Err(ConnectionError::InvalidInput)
    }
    fn connect_trigger_input(&mut self, _input: &str, _channel: TriggerChannel) -> ConnectionResult {
        Err(ConnectionError::InvalidInput)
    }
    fn connect_clock_input(&mut self, _input: &str, _channel: ClockChannel) -> ConnectionResult {
        Err(ConnectionError::InvalidInput)
    }
    fn connect_video_input(&mut self, _input: &str, _source: &impl gstreamer::ElementExt) -> ConnectionResult {
        Err(ConnectionError::InvalidInput)
    }
}

pub trait OutputNode {
    fn connect_to_dmx_input(&mut self, _output: &str, _node: &mut impl InputNode, _input: &str) -> ConnectionResult {
        Err(ConnectionError::InvalidOutput)
    }
    fn connect_to_numeric_input(&mut self, _output: &str, _node: &mut impl InputNode, _input: &str) -> ConnectionResult {
        Err(ConnectionError::InvalidOutput)
    }
    fn connect_to_trigger_input(&mut self, _output: &str, _node: &mut impl InputNode, _input: &str) -> ConnectionResult {
        Err(ConnectionError::InvalidOutput)
    }
    fn connect_to_clock_input(&mut self, _output: &str, _node: &mut impl InputNode, _input: &str) -> ConnectionResult {
        Err(ConnectionError::InvalidOutput)
    }
    fn connect_to_video_input(&mut self, _output: &str, _node: &mut impl InputNode, _input: &str) -> ConnectionResult {
        Err(ConnectionError::InvalidOutput)
    }
}

#[derive(Debug, Error)]
pub enum ConnectionError {
    #[error("invalid input")]
    InvalidInput,
    #[error("invalid output")]
    InvalidOutput,
    #[error("invalid channel type (expected {expected:?}, actual {actual:?})")]
    InvalidType {
        expected: NodeChannel,
        actual: NodeChannel,
    },
    #[error(transparent)]
    Other(#[from] Box<dyn std::error::Error + Sync + Send>)
}

impl From<glib::error::BoolError> for ConnectionError {
    fn from(err: glib::error::BoolError) -> Self {
        ConnectionError::Other(Box::new(err))
    }
}

pub type ConnectionResult = Result<(), ConnectionError>;

mod deps {
    pub use crossbeam_channel::{Receiver, Sender, TryRecvError};
    pub use crossbeam_channel::unbounded as channel;
}
