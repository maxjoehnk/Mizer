use std::cmp::Ordering;
use std::collections::HashMap;
use std::ops::DerefMut;
use std::str::FromStr;
use std::sync::Arc;

use anyhow::Context;
use dashmap::DashMap;
use indexmap::IndexMap;
use pinboard::NonEmptyPinboard;

use mizer_node::*;
use mizer_nodes::NodeDowncast;
use mizer_nodes::*;
use mizer_pipeline::*;

pub struct PipelineAccess {
    pub(crate) nodes: IndexMap<NodePath, Box<dyn ProcessingNodeExt>>,
    pub nodes_view: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>,
    pub(crate) links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    pub(crate) settings: Arc<NonEmptyPinboard<HashMap<NodePath, Vec<NodeSetting>>>>,
    pub(crate) ports: Arc<DashMap<NodePath, Vec<(PortId, PortMetadata)>>>,
}

impl Default for PipelineAccess {
    fn default() -> Self {
        Self {
            nodes: Default::default(),
            nodes_view: Default::default(),
            designer: NonEmptyPinboard::new(Default::default()).into(),
            metadata: NonEmptyPinboard::new(Default::default()).into(),
            links: NonEmptyPinboard::new(Default::default()).into(),
            settings: NonEmptyPinboard::new(Default::default()).into(),
            ports: Default::default(),
        }
    }
}

impl NodePortReader for PipelineAccess {
    fn list_ports(&self, path: &NodePath) -> Option<Vec<(PortId, PortMetadata)>> {
        self.ports.get(path).map(|ports| ports.clone())
    }
}

impl PipelineAccess {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn duplicate_node(
        &mut self,
        path: &NodePath,
    ) -> anyhow::Result<NodePath> {
        let config = {
            let node_to_duplicate = self.nodes_view.get(path).ok_or_else(|| anyhow::anyhow!("Unknown node {path}"))?;
            let config = node_to_duplicate.downcast();
            
            config
        };
        let designer = self
            .designer
            .read()
            .get(&path)
            .cloned()
            .unwrap_or_default();

        let new_path = self.handle_add_node(config.node_type(), designer, Some(config))?;
        self.ports.insert(new_path.clone(), self.ports.get(path).map(|ports| ports.value().clone()).unwrap_or_default());
        
        Ok(new_path)
    }

    pub fn handle_add_node(
        &mut self,
        node_type: NodeType,
        designer: NodeDesigner,
        node: Option<Node>,
    ) -> anyhow::Result<NodePath> {
        let node_type_name = node_type.get_name();
        let id = self.get_next_id(node_type);
        let path: NodePath = format!("/{}-{}", node_type_name, id).into();
        let node = node.unwrap_or_else(|| node_type.into());
        self.internal_add_node(path.clone(), node, designer);

        Ok(path)
    }

    pub(crate) fn internal_add_node(&mut self, path: NodePath, node: Node, designer: NodeDesigner) {
        self.add_project_node(path.clone(), node);
        self.add_designer_node(path, designer);
    }

    fn get_next_id(&self, node_type: NodeType) -> u32 {
        let node_type_prefix = format!("/{}-", node_type.get_name());
        let mut ids = self
            .nodes
            .keys()
            .filter_map(|path| path.0.strip_prefix(&node_type_prefix))
            .filter_map(|suffix| u32::from_str(suffix).ok())
            .collect::<Vec<_>>();
        tracing::trace!("found ids for prefix {}: {:?}", node_type_prefix, ids);
        ids.sort_unstable();
        ids.last().map(|last_id| last_id + 1).unwrap_or_default()
    }

    fn add_project_node(&mut self, path: NodePath, node: Node) {
        use Node::*;
        match node {
            DmxOutput(node) => self.add_node(path, node),
            DmxInput(node) => self.add_node(path, node),
            Oscillator(node) => self.add_node(path, node),
            Clock(node) => self.add_node(path, node),
            Scripting(node) => self.add_node(path, node),
            StepSequencer(node) => self.add_node(path, node),
            Envelope(node) => self.add_node(path, node),
            Merge(node) => self.add_node(path, node),
            Combine(node) => self.add_node(path, node),
            Select(node) => self.add_node(path, node),
            Threshold(node) => self.add_node(path, node),
            Encoder(node) => self.add_node(path, node),
            Fixture(node) => self.add_node(path, node),
            FixtureControl(node) => self.add_node(path, node),
            Programmer(node) => self.add_node(path, node),
            Group(node) => self.add_node(path, node),
            GroupControl(node) => self.add_node(path, node),
            Preset(node) => self.add_node(path, node),
            Sequencer(node) => self.add_node(path, node),
            IldaFile(node) => self.add_node(path, node),
            Laser(node) => self.add_node(path, node),
            Fader(node) => self.add_node(path, node),
            Dial(node) => self.add_node(path, node),
            Button(node) => self.add_node(path, node),
            Label(node) => self.add_node(path, node),
            OpcOutput(node) => self.add_node(path, node),
            PixelPattern(node) => self.add_node(path, node),
            PixelDmx(node) => self.add_node(path, node),
            OscInput(node) => self.add_node(path, node),
            OscOutput(node) => self.add_node(path, node),
            VideoFile(node) => self.add_node(path, node),
            ImageFile(node) => self.add_node(path, node),
            VideoTransform(node) => self.add_node(path, node),
            VideoHsv(node) => self.add_node(path, node),
            VideoOutput(node) => self.add_node(path, node),
            VideoMixer(node) => self.add_node(path, node),
            VideoRgb(node) => self.add_node(path, node),
            VideoRgbSplit(node) => self.add_node(path, node),
            TextureBorder(node) => self.add_node(path, node),
            DropShadow(node) => self.add_node(path, node),
            StaticColor(node) => self.add_node(path, node),
            Invert(node) => self.add_node(path, node),
            VideoText(node) => self.add_node(path, node),
            Webcam(node) => self.add_node(path, node),
            ScreenCapture(node) => self.add_node(path, node),
            ColorizeTexture(node) => self.add_node(path, node),
            TextureMask(node) => self.add_node(path, node),
            TextureOpacity(node) => self.add_node(path, node),
            LumaKey(node) => self.add_node(path, node),
            MidiInput(node) => self.add_node(path, node),
            MidiOutput(node) => self.add_node(path, node),
            ColorConstant(node) => self.add_node(path, node),
            ColorBrightness(node) => self.add_node(path, node),
            ColorHsv(node) => self.add_node(path, node),
            ColorRgb(node) => self.add_node(path, node),
            ColorToHsv(node) => self.add_node(path, node),
            Gamepad(node) => self.add_node(path, node),
            Container(node) => self.add_node(path, node),
            Math(node) => self.add_node(path, node),
            MqttInput(node) => self.add_node(path, node),
            MqttOutput(node) => self.add_node(path, node),
            NumberToData(node) => self.add_node(path, node),
            DataToNumber(node) => self.add_node(path, node),
            DataToText(node) => self.add_node(path, node),
            MultiToData(node) => self.add_node(path, node),
            DataFile(node) => self.add_node(path, node),
            NumberToClock(node) => self.add_node(path, node),
            Value(node) => self.add_node(path, node),
            Extract(node) => self.add_node(path, node),
            PlanScreen(node) => self.add_node(path, node),
            Delay(node) => self.add_node(path, node),
            Countdown(node) => self.add_node(path, node),
            TimeTrigger(node) => self.add_node(path, node),
            Ramp(node) => self.add_node(path, node),
            Noise(node) => self.add_node(path, node),
            Transport(node) => self.add_node(path, node),
            G13Input(node) => self.add_node(path, node),
            G13Output(node) => self.add_node(path, node),
            ConstantNumber(node) => self.add_node(path, node),
            Conditional(node) => self.add_node(path, node),
            TimecodeControl(node) => self.add_node(path, node),
            TimecodeOutput(node) => self.add_node(path, node),
            TimecodeRecorder(node) => self.add_node(path, node),
            AudioFile(node) => self.add_node(path, node),
            AudioOutput(node) => self.add_node(path, node),
            AudioVolume(node) => self.add_node(path, node),
            AudioInput(node) => self.add_node(path, node),
            AudioMix(node) => self.add_node(path, node),
            AudioMeter(node) => self.add_node(path, node),
            Template(node) => self.add_node(path, node),
            Beats(node) => self.add_node(path, node),
            ProDjLinkClock(node) => self.add_node(path, node),
            PioneerCdj(node) => self.add_node(path, node),
            NdiOutput(node) => self.add_node(path, node),
            NdiInput(node) => self.add_node(path, node),
            SurfaceMapping(node) => self.add_node(path, node),
            VectorFile(node) => self.add_node(path, node),
            RasterizeVector(node) => self.add_node(path, node),
            Comparison(node) => self.add_node(path, node),
            TestSink(node) => self.add_node(path, node),
        }
    }

    pub fn add_node<T: 'static + ProcessingNode<State = S>, S: 'static>(
        &mut self,
        path: NodePath,
        node: T,
    ) {
        tracing::debug!("adding node {}: {:?}", &path, node);
        self.nodes_view.insert(path.clone(), Box::new(node.clone()));
        let node = Box::new(node);
        self.nodes.insert(path, node);
    }

    pub fn add_designer_node(&mut self, path: NodePath, designer: NodeDesigner) {
        let mut nodes = self.designer.read();
        nodes.insert(path, designer);
        self.designer.set(nodes);
    }

    pub fn delete_node(
        &mut self,
        path: NodePath,
    ) -> anyhow::Result<(Node, NodeDesigner, Vec<NodeLink>)> {
        let node = self
            .nodes
            .shift_remove(&path)
            .ok_or_else(|| anyhow::anyhow!("Deleting unknown node"))?;
        let node = NodeDowncast::downcast(&node);
        self.nodes_view.remove(&path);
        let mut designer = self.designer.read();
        let node_designer = designer
            .remove(&path)
            .ok_or_else(|| anyhow::anyhow!("Missing designer state for node"))?;
        self.designer.set(designer);
        let links = self.links.read();
        let (links, removed_links) = links
            .into_iter()
            .partition(|link| link.source != path && link.target != path);
        self.links.set(links);

        Ok((node, node_designer, removed_links))
    }

    pub fn add_link(&mut self, mut link: NodeLink) -> anyhow::Result<()> {
        let (source_port, target_port) = self
            .get_ports(&link)
            .context(format!("Fetching ports for link {link:?}"))?;
        anyhow::ensure!(
            source_port.port_type == target_port.port_type,
            "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
            &source_port,
            &target_port,
            &link
        );
        link.port_type = source_port.port_type;
        let mut links = self.links.read();
        links.push(link);
        self.links.set(links);

        Ok(())
    }

    pub fn remove_link(&mut self, link: &NodeLink) {
        let mut links = self.links.read();
        links.retain(|l| l != link);
        self.links.set(links);
    }

    fn get_ports(&self, link: &NodeLink) -> anyhow::Result<(PortMetadata, PortMetadata)> {
        let _source_node = self.nodes.get(&link.source).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.source)
        })?;
        let _target_node = self.nodes.get(&link.target).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.target)
        })?;
        let source_port = self
            .try_get_output_port_metadata(&link.source, &link.source_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.source_port,
                    link.source
                )
            })?;
        let target_port = self
            .try_get_input_port_metadata(&link.target, &link.target_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.target_port,
                    link.target
                )
            })?;

        Ok((source_port, target_port))
    }

    pub(crate) fn try_get_input_port_metadata(
        &self,
        path: &NodePath,
        port: &PortId,
    ) -> Option<PortMetadata> {
        self.get_port_metadata(path, port, PortDirection::Input)
    }

    pub(crate) fn get_input_port_metadata(&self, path: &NodePath, port: &PortId) -> PortMetadata {
        self.try_get_input_port_metadata(path, port)
            .unwrap_or_default()
    }

    pub(crate) fn try_get_output_port_metadata(
        &self,
        path: &NodePath,
        port: &PortId,
    ) -> Option<PortMetadata> {
        self.get_port_metadata(path, port, PortDirection::Output)
    }

    pub(crate) fn get_output_port_metadata(&self, path: &NodePath, port: &PortId) -> PortMetadata {
        self.try_get_output_port_metadata(path, port)
            .unwrap_or_default()
    }

    fn get_port_metadata(
        &self,
        path: &NodePath,
        port: &PortId,
        direction: PortDirection,
    ) -> Option<PortMetadata> {
        self.ports.get(path).and_then(|ports| {
            ports
                .iter()
                .filter(|(_, port)| port.direction == direction)
                .find(|(id, _)| id == port)
                .map(|(_, port)| *port)
        })
    }

    pub fn get_settings(&self, path: &NodePath) -> Option<Vec<NodeSetting>> {
        let mut settings = self.settings.read();

        settings.remove(path)
    }

    pub fn apply_node_config(&mut self, path: &NodePath, config: Node) -> anyhow::Result<Node> {
        let node = self
            .nodes
            .get(path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {path}"))?;
        let previous = node.downcast();
        let node = self
            .nodes
            .get_mut(path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {path}"))?;
        let node: &mut dyn ProcessingNodeExt = node.deref_mut();
        config.apply_to(node.as_pipeline_node_mut())?;

        let mut node = self
            .nodes_view
            .get_mut(path)
            .ok_or_else(|| anyhow::anyhow!("Unknown Node {path}"))?;
        let node = node.value_mut();
        config.apply_to(node.deref_mut())?;

        Ok(previous)
    }
    
    pub(crate) fn reorder_nodes(&mut self) {
        profiling::scope!("PipelineAccess::reorder_nodes");
        let dependencies = self
            .links
            .read()
            .into_iter()
            .fold(HashMap::<NodePath, Vec<NodePath>>::default(), |mut map, link| {
                map.entry(link.target).or_default().push(link.source);
                map
            });
        // TODO: this doesn't actually guarantee execution order, but it's the same algorithm as before
        // Because two nodes don't have to relate to each other just using sort_by doesn't work for our use case
        self.nodes.sort_by(|left, _, right, _| {
            let deps = dependencies.get(left).zip(dependencies.get(right));
            if let Some((left_deps, right_deps)) = deps {
                if left_deps.contains(right) {
                    Ordering::Less
                } else if right_deps.contains(left) {
                    Ordering::Greater
                } else {
                    Ordering::Equal
                }
            }else {
                Ordering::Equal
            }
        });
        tracing::debug!("Reordered nodes: {:?}", self.nodes.keys().collect::<Vec<_>>());
    }
}
