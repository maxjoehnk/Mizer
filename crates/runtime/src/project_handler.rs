use serde::{Deserialize, Serialize};
use lazy_static::lazy_static;
use mizer_clock::Clock;
use mizer_module::{LoadProjectContext, ProjectHandler, ProjectHandlerContext, Runtime, SaveProjectContext};
use mizer_node::{NodeLink, NodePath, NodeType};
use mizer_nodes::{Node, NodeConfig};
use mizer_ports::PortId;
use regex::{Regex, RegexBuilder};
use crate::{CoordinatorRuntime, Pipeline};

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z0-9\-\+/ ]*)@(?P<fi>[a-z0-9\-/]*)\s->\s(?P<tc>[a-z0-9\-\+/ ]*)@(?P<ti>[a-z0-9\-/]*)$"
    )
    .case_insensitive(true)
    .build()
    .unwrap();
}

struct RuntimeProjectHandler;

impl ProjectHandler for RuntimeProjectHandler {
    fn get_name(&self) -> &'static str {
        "runtime"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        let mut pipeline = context.try_get_mut::<Pipeline>().unwrap();
        pipeline.add_node(context, NodeType::Programmer, Default::default(), None, None).unwrap();
        pipeline.add_node(context, NodeType::Transport, Default::default(), None, None).unwrap();
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        profiling::scope!("CoordinatorRuntime::load_project");
        let playback = context.read_file::<PlaybackSettings>("playback")?;
        self.set_fps(playback.fps);
        let nodes = context.read_file::<Vec<NodeConfig>>("nodes")?;
        for node in nodes {
            let pipeline = context.try_get_mut::<Pipeline>().unwrap();
            pipeline.add_node_with_path(&context, node.path, node.designer, node.config, None)?;
        }
        let channels = context.read_file::<Vec<Channel>>("channels")?;
        for link in channels {
            let pipeline = context.try_get_mut::<Pipeline>().unwrap();
            let source_port =
                pipeline.get_output_port_metadata(&link.from_path, &link.from_channel);
            let target_port =
                pipeline.get_input_port_metadata(&link.to_path, &link.to_channel);
            anyhow::ensure!(
                source_port.port_type == target_port.port_type,
                "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
                &source_port,
                &target_port,
                &link
            );
            let link = NodeLink {
                source: link.from_path,
                source_port: link.from_channel,
                target: link.to_path,
                target_port: link.to_channel,
                port_type: source_port.port_type,
                local: true,
            };
            pipeline.add_link(link)?;
        }
        self.force_plan();

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        todo!()
    }
}

#[derive(Debug, Clone, Copy, Serialize, Deserialize, PartialEq)]
pub struct PlaybackSettings {
    pub fps: f64,
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
