use std::convert::TryFrom;
use std::fs::File;
use std::io::{Cursor, Read, Seek};
use std::net::Ipv4Addr;
use std::path::Path;

use indexmap::IndexMap;
use lazy_static::lazy_static;
use regex::{Regex, RegexBuilder};
use serde::{Deserialize, Serialize};

use mizer_fixtures::fixture::FixtureConfiguration;
use mizer_fixtures::programmer::Group;
use mizer_layouts::ControlConfig;
use mizer_node::{NodeDesigner, NodePath, PortId};
use mizer_plan::Plan;
use mizer_protocol_mqtt::MqttAddress;
use mizer_protocol_osc::OscAddress;
use mizer_sequencer::{Effect, Sequence};
use mizer_surfaces::Surface;
use mizer_timecode::{TimecodeControl, TimecodeTrack};

use crate::fixtures::PresetsStore;
use crate::media::Media;
use crate::project_file::ProjectFile;
use crate::versioning::{migrate, Migrations};
pub use crate::handler_context::HandlerContext;

mod connections;
mod fixtures;
pub mod history;
mod media;
mod timecode;
mod versioning;
mod handler_context;
mod project_file;

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z0-9\-\+/ ]*)@(?P<fi>[a-z0-9\-/]*)\s->\s(?P<tc>[a-z0-9\-\+/ ]*)@(?P<ti>[a-z0-9\-/]*)$"
    )
    .case_insensitive(true)
    .build()
    .unwrap();
}

#[derive(Default, Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Project {
    #[serde(default)]
    pub version: u32,
    #[serde(default)]
    pub playback: PlaybackSettings,
    #[serde(default)]
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub channels: Vec<Channel>,
    #[serde(default)]
    pub media: Media,
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

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub struct PlaybackSettings {
    pub fps: f64,
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

    // TODO: do file persistence on background thread
    #[profiling::function]
    pub fn save_file<P: AsRef<Path>>(&self, path: P) -> anyhow::Result<()> {
        let file = File::create(path)?;
        serde_yaml::to_writer(file, &self)?;

        Ok(())
    }
}

pub trait ProjectManagerMut {
    fn new_project(&mut self) {}
    fn load(&mut self, project: &Project) -> anyhow::Result<()>;
    fn save(&self, project: &mut Project);
    fn clear(&mut self);
}

pub trait ProjectManager {
    fn new_project(&self) {}
    fn load(&self, project: &Project) -> anyhow::Result<()>;
    fn save(&self, project: &mut Project);
    fn clear(&self);
}

#[derive(Clone, Serialize, Deserialize, PartialEq, Eq)]
#[serde(try_from = "String", into = "String")]
pub struct Channel {
    pub from_path: NodePath,
    pub from_channel: PortId,
    pub to_path: NodePath,
    pub to_channel: PortId,
}

impl TryFrom<String> for Channel {
    type Error = String;

    fn try_from(value: String) -> Result<Self, Self::Error> {
        if let Some(captures) = CHANNEL_REGEX.captures(&value) {
            let from_path = captures.name("fi").unwrap().as_str().into();
            let from_channel = captures.name("fc").unwrap().as_str().into();
            let to_path = captures.name("ti").unwrap().as_str().into();
            let to_channel = captures.name("tc").unwrap().as_str().into();

            Ok(Channel {
                from_path,
                from_channel,
                to_path,
                to_channel,
            })
        } else {
            Err("invalid channel format".into())
        }
    }
}

impl From<Channel> for String {
    fn from(channel: Channel) -> Self {
        format!("{:?}", channel)
    }
}

impl std::fmt::Debug for Channel {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(
            f,
            "{}@{} -> {}@{}",
            self.from_channel, self.from_path, self.to_channel, self.to_path
        )
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct Node {
    pub path: NodePath,
    #[serde(flatten)]
    pub config: mizer_nodes::Node,
    #[serde(default)]
    pub designer: NodeDesigner,
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
