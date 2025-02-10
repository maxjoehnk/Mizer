use std::net::Ipv4Addr;

use indexmap::IndexMap;
use serde::{Deserialize, Serialize};

use mizer_fixtures::fixture::FixtureConfiguration;
use mizer_fixtures::programmer::Group;
use mizer_layouts::ControlConfig;
use mizer_nodes::NodeConfig;
use mizer_plan::Plan;
use mizer_protocol_mqtt::MqttAddress;
use mizer_protocol_osc::OscAddress;
use mizer_runtime::{Channel, PlaybackSettings};
use mizer_sequencer::{Effect, Sequence};
use mizer_surfaces::Surface;
use mizer_timecode::{TimecodeControl, TimecodeTrack};

use crate::fixtures::PresetsStore;
pub use crate::handler_context::HandlerContext;

mod fixtures;
mod handler_context;
pub mod history;
mod media;
mod project_file;
mod versioning;

pub const SHOWFILE_EXTENSION: &str = "mshow";

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Project {
    #[serde(default)]
    pub version: u32,
    #[serde(default)]
    pub playback: PlaybackSettings,
    #[serde(default)]
    pub nodes: Vec<NodeConfig>,
    #[serde(default)]
    pub channels: Vec<Channel>,
    #[serde(default)]
    pub media: media::Media,
    #[serde(default)]
    pub layouts: IndexMap<String, Vec<ControlConfig>>,
    #[serde(default)]
    pub connections: Vec<ConnectionConfig>,
    #[serde(default)]
    pub fixtures: Vec<FixtureConfig>,
    #[serde(default)]
    pub groups: Vec<Group>,
    #[serde(default)]
    pub presets: PresetsStore,
    #[serde(default)]
    pub sequences: Vec<Sequence>,
    #[serde(default)]
    pub effects: Vec<Effect>,
    #[serde(default)]
    pub plans: Vec<Plan>,
    #[serde(default)]
    pub timecodes: Timecodes,
    #[serde(default)]
    pub surfaces: Vec<Surface>,
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Timecodes {
    pub timecodes: Vec<TimecodeTrack>,
    pub controls: Vec<TimecodeControl>,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct FixtureConfig {
    pub id: u32,
    pub name: String,
    pub fixture: String,
    pub channel: u16,
    pub universe: Option<u16>,
    #[serde(default)]
    pub mode: Option<String>,
    #[serde(default)]
    pub configuration: FixtureConfiguration,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub struct ConnectionConfig {
    pub id: String,
    pub name: String,
    #[serde(flatten)]
    pub config: ConnectionTypes,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
#[serde(tag = "type", rename_all = "kebab-case")]
pub enum ConnectionTypes {
    Sacn {
        priority: Option<u8>,
    },
    #[serde(alias = "artnet")]
    ArtnetOutput {
        host: String,
        port: Option<u16>,
    },
    ArtnetInput {
        host: Ipv4Addr,
        port: Option<u16>,
    },
    Mqtt(MqttAddress),
    Osc(OscAddress),
}
