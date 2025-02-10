use crate::Pipeline;
use lazy_static::lazy_static;
use mizer_module::*;
use mizer_node::{NodeLink, NodePath, NodeType};
use mizer_nodes::{NodeConfig, NodeDowncast};
use mizer_ports::PortId;
use regex::{Regex, RegexBuilder};
use serde::{Deserialize, Serialize};

lazy_static! {
    static ref CHANNEL_REGEX: Regex = RegexBuilder::new(
        r"^(?P<fc>[a-z0-9\-\+/ ]*)@(?P<fi>[a-z0-9\-/]*)\s->\s(?P<tc>[a-z0-9\-\+/ ]*)@(?P<ti>[a-z0-9\-/]*)$"
    )
    .case_insensitive(true)
    .build()
    .unwrap();
}

pub(crate) struct PipelineProjectHandler;

impl ProjectHandler for PipelineProjectHandler {
    fn get_name(&self) -> &'static str {
        "pipeline"
    }

    fn new_project(
        &mut self,
        _context: &mut impl ProjectHandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let (pipeline, injector) = injector.inject_mut_with_slice::<Pipeline>();
        pipeline.clear();
        pipeline
            .add_node(
                &injector,
                NodeType::Programmer,
                Default::default(),
                None,
                None,
            )
            .unwrap();
        pipeline
            .add_node(
                &injector,
                NodeType::Transport,
                Default::default(),
                None,
                None,
            )
            .unwrap();

        Ok(())
    }

    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        profiling::scope!("CoordinatorRuntime::load_project");
        let (pipeline, injector) = injector.inject_mut_with_slice::<Pipeline>();
        pipeline.clear();
        let nodes = context.read_file::<Vec<NodeConfig>>("nodes")?;
        for node in nodes {
            pipeline.add_node_with_path(&injector, node.path, node.designer, node.config, None)?;
        }
        let channels = context.read_file::<Vec<Channel>>("channels")?;
        for link in channels {
            let source_port =
                pipeline.get_output_port_metadata(&link.from_path, &link.from_channel);
            let target_port = pipeline.get_input_port_metadata(&link.to_path, &link.to_channel);
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

        Ok(())
    }

    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        // let playback_settings = PlaybackSettings {
        //     fps: self.
        // }
        let pipeline = injector.inject::<Pipeline>();
        let mut nodes = Vec::with_capacity(pipeline.list_nodes().count());
        for (path, node) in pipeline.list_nodes() {
            let node = NodeDowncast::downcast(&node);
            let designer = pipeline.get_node_designer(&path).copied();
            let config = NodeConfig {
                path: path.clone(),
                designer: designer.unwrap_or_default(),
                config: node,
            };
            nodes.push(config);
        }
        context.write_file("nodes", &nodes)?;

        let channels = pipeline
            .list_links()
            .map(|link| Channel {
                from_channel: link.source_port.clone(),
                from_path: link.source.clone(),
                to_channel: link.target_port.clone(),
                to_path: link.target.clone(),
            })
            .collect::<Vec<_>>();
        context.write_file("channels", &channels)?;

        Ok(())
    }
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
