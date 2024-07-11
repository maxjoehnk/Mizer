use std::convert::TryFrom;
use std::io::{Read, Seek};
use std::net::Ipv4Addr;
use std::path::Path;

use indexmap::IndexMap;
use serde::{Deserialize, Serialize};

use mizer_fixtures::fixture::FixtureConfiguration;
use mizer_fixtures::programmer::Group;
use mizer_layouts::ControlConfig;
use mizer_nodes::NodeConfig;
use mizer_runtime::Channel;
use mizer_plan::Plan;
use mizer_protocol_mqtt::MqttAddress;
use mizer_protocol_osc::OscAddress;
use mizer_sequencer::{Effect, Sequence};
use mizer_surfaces::Surface;
use mizer_timecode::{TimecodeControl, TimecodeTrack};

use crate::fixtures::PresetsStore;
use crate::project_file::ProjectFile;
use crate::versioning::{migrate, Migrations};
pub use crate::handler_context::HandlerContext;

mod connections;
mod fixtures;
pub mod history;
mod versioning;
mod handler_context;
mod project_file;
mod media;

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

impl Default for PlaybackSettings {
    fn default() -> Self {
        Self { fps: 60. }
    }
}

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct Timecodes {
    pub timecodes: Vec<TimecodeTrack>,
    pub controls: Vec<TimecodeControl>,
}

impl Project {
    pub fn new() -> Self {
        Self {
            version: Migrations::latest_version(),
            ..Default::default()
        }
    }

    #[profiling::function]
    pub fn load_file<P: AsRef<Path>>(path: P) -> anyhow::Result<Project> {
        let path = path.as_ref();
        let mut project_file = ProjectFile::open(path.as_ref())?;
        migrate(&mut project_file)?;
        todo!();
    }

    // pub fn load(content: &str) -> anyhow::Result<Project> {
    //     let mut content = content.to_string();
    //     let file_content = unsafe { content.as_mut_vec() };
    //     migrate(file_content)?;
    //     let project = serde_yaml::from_str(&content)?;
    // 
    //     Ok(project)
    // }
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
