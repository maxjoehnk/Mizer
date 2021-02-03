use crate::nodes::Node;
use crate::nodes::*;
use anyhow::{anyhow, Context};
use mizer_fixtures::manager::FixtureManager;
use mizer_node_api::*;
use mizer_project_files::{Project, Channel};
use mizer_devices::DeviceManager;
use crate::node_builder::NodeBuilder;
use crate::pipeline_view::PipelineView;
use std::sync::Arc;
use dashmap::DashMap;
use crate::{NodeDesigner, NodeTemplate, NodeDefinition, NodePortDefinition};
use std::fmt::Formatter;

pub enum PipelineCommand {
    AddNode(NodeTemplate, flume::Sender<(String, NodeDefinition)>)
}

pub struct Pipeline<'a> {
    default_clock: ClockNode,
    nodes: Arc<DashMap<String, Node<'a>>>,
    designer: Arc<DashMap<String, NodeDesigner>>,
    channels: Vec<Channel>,
    command_channel: (flume::Sender<PipelineCommand>, flume::Receiver<PipelineCommand>),
    fixture_manager: FixtureManager,
    device_manager: DeviceManager,
    next_id: u32
}

impl<'a> std::fmt::Debug for Pipeline<'a> {
    fn fmt(&self, f: &mut std::fmt::Formatter) -> std::fmt::Result {
        f.debug_struct("Pipeline")
            .field("default_clock", &self.default_clock)
            .field("nodes", &self.nodes)
            .field("designer", &self.designer)
            .field("channels", &self.channels)
            .finish()
    }
}

impl<'a> Pipeline<'a> {
    pub fn new(
        fixture_manager: FixtureManager,
        device_manager: DeviceManager,
    ) -> Self {
        Pipeline {
            default_clock: Default::default(),
            nodes: Default::default(),
            designer: Default::default(),
            channels: Default::default(),
            command_channel: flume::unbounded(),
            fixture_manager,
            device_manager,
            next_id: 0
        }
    }
}

impl<'a> Pipeline<'a> {
    pub fn load_project(
        &mut self,
        project: Project,
    ) -> anyhow::Result<()> {
        let mut pipeline_context = PipelineContext {
            clock: &mut self.default_clock,
            fixture_manager: &self.fixture_manager,
            device_manager: &self.device_manager
        };
        for node_config in project.nodes {
            let id = node_config.id.clone();
            let mut node = node_config.config.build(&mut pipeline_context);
            for (key, value) in node_config.properties {
                node.set_numeric_property(&key, value);
            }
            self.nodes.insert(id.clone(), node);
            self.designer.insert(id, node_config.designer.into());
        }

        for channel in project.channels {
            self.connect_nodes(&channel)?;
            self.channels.push(channel);
        }

        Ok(())
    }

    fn get_context(&mut self) -> PipelineContext {
        PipelineContext {
            clock: &mut self.default_clock,
            fixture_manager: &self.fixture_manager,
            device_manager: &self.device_manager,
        }
    }

    fn connect_nodes(&mut self, channel: &Channel) -> anyhow::Result<()> {
        let mut lhs = self.nodes.get_mut(&channel.from_id).ok_or_else(|| anyhow!("unknown node {}", &channel.from_id))?;
        let mut rhs = self.nodes.get_mut(&channel.to_id).ok_or_else(|| anyhow!("unknown node {}", &channel.to_id))?;
        let context = format!("{:?}\noutput: {:?}\ninput: {:?}", &channel, lhs.value(), rhs.value());
        match lhs.get_details().get_output_type(&channel.from_channel) {
            Some(NodeChannel::Dmx) => lhs
                .connect_to_dmx_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Numeric) => lhs
                .connect_to_numeric_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Boolean) => lhs
                .connect_to_bool_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Trigger) => lhs
                .connect_to_trigger_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Clock) => lhs
                .connect_to_clock_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Video) => lhs
                .connect_to_video_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Pixels) => lhs
                .connect_to_pixel_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(NodeChannel::Laser) => lhs
                .connect_to_laser_input(&channel.from_channel, rhs.value_mut(), &channel.to_channel)
                .context(context)?,
            Some(channel) => unimplemented!("channel not implemented {:?}", channel),
            None => return Err(anyhow!("unknown output").context(context)),
        }
        Ok(())
    }

    pub fn process(&mut self) {
        self.work_commands();
        self.default_clock.process();
        for mut item in self.nodes.iter_mut() {
            let id = item.key().clone();
            let node = item.value_mut();
            let before = std::time::Instant::now();
            node.process();
            let after = std::time::Instant::now();
            metrics::timing!("mizer.process_time", before, after, "id" => id);
        }
    }

    fn work_commands(&mut self) {
        match self.command_channel.1.try_recv() {
            Ok(PipelineCommand::AddNode(template, resp)) => {
                log::debug!("Adding node from template: {:?}", template);
                let node = template.node_type.build(&mut self.get_context());
                let details = node.get_details();
                let id = format!("new-node-{}", self.next_id);
                self.next_id += 1;
                self.designer.insert(id.clone(), template.designer.clone());
                let definition = NodeDefinition {
                    node_type: (&node).into(),
                    designer: template.designer,
                    inputs: details.inputs.into_iter().map(NodePortDefinition::from).collect(),
                    outputs: details.outputs.into_iter().map(NodePortDefinition::from).collect(),
                };
                self.nodes.insert(id.clone(), node);

                resp.send((id, definition));
            },
            Err(flume::TryRecvError::Empty) => {},
            Err(flume::TryRecvError::Disconnected) => unreachable!(),
        }
    }

    pub fn view(&self) -> PipelineView {
        PipelineView::new(&self.nodes, &self.designer, self.channels.clone(), self.command_channel.0.clone())
    }
}

struct PipelineContext<'a> {
    clock: &'a mut ClockNode,
    fixture_manager: &'a FixtureManager,
    device_manager: &'a DeviceManager,
}

impl<'a> NodeContext for PipelineContext<'a> {
    fn connect_default_clock(&mut self) -> ClockChannel {
        self.clock.get_clock_channel()
    }

    fn device_manager(&self) -> &'a DeviceManager {
        self.device_manager
    }

    fn fixture_manager(&self) -> &'a FixtureManager {
        self.fixture_manager
    }
}
