use crate::nodes::Node;
use crate::nodes::*;
use anyhow::{anyhow, Context};
use mizer_fixtures::manager::FixtureManager;
use mizer_node_api::*;
use mizer_project_files::{NodeConfig, Project, Channel};
use mizer_devices::DeviceManager;
use crate::node_builder::NodeBuilder;
use crate::pipeline_view::PipelineView;
use std::sync::Arc;
use dashmap::DashMap;
use crate::NodeDesigner;

#[derive(Debug)]
pub struct Pipeline<'a> {
    default_clock: ClockNode,
    nodes: Arc<DashMap<String, Node<'a>>>,
    designer: Arc<DashMap<String, NodeDesigner>>,
    channels: Vec<Channel>,
}

impl<'a> Default for Pipeline<'a> {
    fn default() -> Self {
        Pipeline {
            default_clock: ClockNode::new(90.),
            nodes: Default::default(),
            designer: Default::default(),
            channels: Default::default(),
        }
    }
}

impl<'a> Pipeline<'a> {
    pub fn load_project(
        &mut self,
        project: Project,
        fixture_manager: &FixtureManager,
        device_manager: DeviceManager,
    ) -> anyhow::Result<()> {
        for node_config in project.nodes {
            let id = node_config.id.clone();
            let mut node = node_config.config.build(fixture_manager, &device_manager, &mut self.default_clock);
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

    pub fn view(&self) -> PipelineView {
        PipelineView::new(&self.nodes, &self.designer, self.channels.clone())
    }
}

