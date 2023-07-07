use std::collections::HashMap;
use std::io::Write;
use std::sync::Arc;

use pinboard::NonEmptyPinboard;

use itertools::Itertools;
use mizer_clock::{Clock, ClockSnapshot, SystemClock};
#[cfg(feature = "debug-ui")]
use mizer_debug_ui::DebugUi;
use mizer_execution_planner::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;
use mizer_layouts::{ControlConfig, ControlType, Layout, LayoutStorage};
use mizer_module::Runtime;
use mizer_node::*;
use mizer_nodes::*;
use mizer_pipeline::*;
use mizer_plan::PlanStorage;
use mizer_processing::*;
use mizer_project_files::{Channel, Project, ProjectManagerMut};
use tracing_unwrap::ResultExt;

use crate::api::RuntimeAccess;
use crate::pipeline_access::PipelineAccess;
use crate::{LayoutsView, NodeMetadataRef};

pub struct CoordinatorRuntime<TClock: Clock> {
    executor_id: ExecutorId,
    layouts: LayoutStorage,
    plans: PlanStorage,
    // TODO: this should not be pub
    pub pipeline: PipelineWorker,
    pub clock: TClock,
    injector: Injector,
    processors: Vec<Box<dyn Processor>>,
    clock_recv: flume::Receiver<ClockSnapshot>,
    clock_sender: flume::Sender<ClockSnapshot>,
    clock_snapshot: Arc<NonEmptyPinboard<ClockSnapshot>>,
    layout_fader_view: LayoutsView,
    #[cfg(feature = "debug-ui")]
    ui: Option<DebugUi>,
    node_metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeMetadata>>>,
}

impl CoordinatorRuntime<SystemClock> {
    pub fn new(debug_ui: bool) -> Self {
        let clock = SystemClock::default();

        Self::with_clock(clock, debug_ui)
    }
}

impl<TClock: Clock> CoordinatorRuntime<TClock> {
    pub fn with_clock(clock: TClock, debug_ui: bool) -> CoordinatorRuntime<TClock> {
        let (clock_tx, clock_rx) = flume::unbounded();
        let snapshot = clock.snapshot();
        let node_metadata = Arc::new(NonEmptyPinboard::new(Default::default()));
        let mut runtime = Self {
            executor_id: ExecutorId("coordinator".to_string()),
            layouts: NonEmptyPinboard::new(Default::default()).into(),
            plans: NonEmptyPinboard::new(Default::default()).into(),
            pipeline: PipelineWorker::new(Arc::clone(&node_metadata)),
            clock,
            injector: Default::default(),
            processors: Default::default(),
            clock_recv: clock_rx,
            clock_sender: clock_tx,
            clock_snapshot: NonEmptyPinboard::new(snapshot).into(),
            layout_fader_view: Default::default(),
            #[cfg(feature = "debug-ui")]
            ui: debug_ui.then(DebugUi::new).and_then(|ui| match ui {
                Ok(ui) => Some(ui),
                Err(err) => {
                    log::error!("Debug UI is not available: {err:?}");

                    None
                }
            }),
            node_metadata,
        };
        runtime.bootstrap();

        runtime
    }

    fn bootstrap(&mut self) {
        let executor = Executor {
            id: self.executor_id.clone(),
        };
        let mut planner = ExecutionPlanner::default();
        planner.add_executor(executor);
        self.injector.provide(planner);
        self.injector.provide(PipelineAccess::new());
        self.injector.provide(self.plans.clone());
        self.injector.provide(self.layouts.clone());
    }

    fn add_layouts(&self, layouts: impl IntoIterator<Item = (String, Vec<ControlConfig>)>) {
        let layouts = layouts
            .into_iter()
            .map(|(id, controls)| Layout { id, controls })
            .collect();

        self.layouts.set(layouts);
    }

    fn process_pipeline(&mut self, frame: ClockFrame) {
        let pipeline_access = self.injector.get::<PipelineAccess>().unwrap();
        let nodes = pipeline_access.nodes.iter().collect::<Vec<_>>();

        self.pipeline
            .process(nodes, frame, &self.injector, &mut self.clock);
    }

    pub fn generate_pipeline_graph(&self) -> anyhow::Result<()> {
        let pipeline_access: &PipelineAccess = self.injector.get().unwrap();
        let mut file = std::fs::File::create("pipeline.dot")?;
        writeln!(&mut file, "digraph pipeline {{")?;
        let mut node_ids = HashMap::new();
        for (counter, (path, _)) in pipeline_access.nodes.iter().enumerate() {
            node_ids.insert(path, format!("N{}", counter));
            writeln!(&mut file, "  N{}[label=\"{}\",shape=box];", counter, path)?;
        }
        for link in pipeline_access.links.read().iter() {
            let left_id = node_ids.get(&link.source).unwrap();
            let right_id = node_ids.get(&link.target).unwrap();

            writeln!(&mut file, "  {} -> {}[label=\"\"]", left_id, right_id)?;
        }
        writeln!(&mut file, "}}")?;
        Ok(())
    }

    pub fn provide<T: 'static>(&mut self, service: T) {
        self.injector.provide(service);
    }

    pub fn access(&self) -> RuntimeAccess {
        let pipeline_access: &PipelineAccess = self.injector.get().unwrap();
        RuntimeAccess {
            nodes: pipeline_access.nodes_view.clone(),
            designer: pipeline_access.designer.clone(),
            links: pipeline_access.links.clone(),
            settings: pipeline_access.settings.clone(),
            layouts: self.layouts.clone(),
            plans: self.plans.clone(),
            clock_recv: self.clock_recv.clone(),
            clock_snapshot: self.clock_snapshot.clone(),
            layouts_view: self.layout_fader_view.clone(),
        }
    }

    pub fn get_preview_ref(&self, path: &NodePath) -> Option<NodePreviewRef> {
        self.pipeline.get_preview_ref(path)
    }

    pub fn get_node_metadata_ref(&self) -> NodeMetadataRef {
        NodeMetadataRef::new(Arc::clone(&self.node_metadata))
    }

    fn rebuild_pipeline(&mut self, plan: ExecutionPlan) {
        log::debug!("Rebuilding pipeline");
        profiling::scope!("CoordinatorRuntime::rebuild_pipeline");
        tracing::trace!(plan = debug(&plan));

        let pipeline_access = self.injector.get::<PipelineAccess>().unwrap();
        if let Some(executor) = plan.get_executor(&self.executor_id) {
            for command in executor.commands {
                log::debug!("Updating pipeline worker: {:?}", command);
                match command {
                    ExecutorCommand::AddNode(execution_node) => {
                        let node = pipeline_access
                            .nodes_view
                            .get(&execution_node.path)
                            .unwrap();
                        let node = node.downcast();
                        register_node(&mut self.pipeline, execution_node.path, node);
                    }
                    ExecutorCommand::RemoveNode(path) => {
                        self.pipeline.remove_node(&path, &[]);
                    }
                    ExecutorCommand::AddLink(link) => {
                        let source_port = pipeline_access
                            .get_output_port_metadata(&link.source, &link.source_port);
                        let target_port = pipeline_access
                            .get_input_port_metadata(&link.target, &link.target_port);
                        self.pipeline
                            .connect_nodes(link, source_port, target_port)
                            .unwrap_or_log();
                    }
                    ExecutorCommand::RemoveLink(link) => {
                        self.pipeline.disconnect_port(&link);
                    }
                    ExecutorCommand::RenameNode(from, to) => {
                        if let Err(err) = self.pipeline.rename_node(from, to) {
                            log::error!("Renaming node failed: {err:?}");
                        }
                    }
                }
            }
        } else {
            self.pipeline = PipelineWorker::new(Arc::clone(&self.node_metadata));
        }
    }

    #[profiling::function]
    fn force_plan(&mut self) {
        let planner = self.injector.get_mut::<ExecutionPlanner>().unwrap();
        let plan = planner.plan();
        self.rebuild_pipeline(plan);
    }

    #[profiling::function]
    pub(crate) fn read_states_into_view(&self) {
        let layouts = self.layouts.read();
        let nodes = layouts
            .into_iter()
            .flat_map(|layout| layout.controls)
            .filter_map(|control| match control.control_type {
                ControlType::Node { path: node } => Some(node),
                _ => None,
            })
            .sorted()
            .dedup()
            .collect::<Vec<_>>();

        let fader_values = nodes
            .iter()
            .filter_map(|path| {
                let value = self.pipeline.get_state::<f64>(path).copied();

                value.map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();

        self.layout_fader_view.write_fader_values(fader_values);
        let button_values = nodes
            .iter()
            .filter_map(|path| {
                let value = self
                    .pipeline
                    .get_state::<<ButtonNode as ProcessingNode>::State>(path);

                value.map(|(value, _)| (path.clone(), *value))
            })
            .collect::<HashMap<_, _>>();

        self.layout_fader_view.write_button_values(button_values);

        let pipeline_access = self.injector.get::<PipelineAccess>().unwrap();
        let node_views = pipeline_access.nodes.iter().collect::<Vec<_>>();

        let label_values = nodes
            .iter()
            .filter_map(|path| {
                let state = self
                    .pipeline
                    .get_state::<<LabelNode as ProcessingNode>::State>(path);
                let value = node_views
                    .iter()
                    .find(|(p, _)| &path == p)
                    .map(|(_, node)| node)
                    .and_then(|node| node.downcast_node::<LabelNode>(node.node_type()))
                    .zip(state)
                    .map(|(node, state)| node.label(state));

                value.map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();

        self.layout_fader_view.write_label_values(label_values);
    }

    fn get_preset_ids(&self) -> Vec<PresetId> {
        let fixture_manager = self.injector.get::<FixtureManager>().unwrap();
        fixture_manager
            .presets
            .color_presets()
            .into_iter()
            .map(|(id, _)| id)
            .chain(
                fixture_manager
                    .presets
                    .intensity_presets()
                    .into_iter()
                    .map(|(id, _)| id),
            )
            .chain(
                fixture_manager
                    .presets
                    .shutter_presets()
                    .into_iter()
                    .map(|(id, _)| id),
            )
            .chain(
                fixture_manager
                    .presets
                    .position_presets()
                    .into_iter()
                    .map(|(id, _)| id),
            )
            .collect()
    }

    #[profiling::function]
    pub(crate) fn read_node_settings(&self) {
        let pipeline_access: &PipelineAccess = self.injector.get().unwrap();
        let settings = pipeline_access
            .nodes
            .iter()
            .map(|(path, node)| {
                let _scope = format!("{:?}Node::settings", node.node_type());
                profiling::scope!(&_scope);
                let settings = node.settings(&self.injector);

                (path.clone(), settings)
            })
            .collect();
        pipeline_access.settings.set(settings);
    }
}

impl<TClock: Clock> Runtime for CoordinatorRuntime<TClock> {
    fn injector_mut(&mut self) -> &mut Injector {
        &mut self.injector
    }

    fn injector(&self) -> &Injector {
        &self.injector
    }

    fn add_processor(&mut self, processor: Box<dyn Processor>) {
        self.processors.push(processor);
    }

    fn process(&mut self) {
        profiling::scope!("CoordinatorRuntime::process");
        log::trace!("tick");
        let frame = self.clock.tick();
        let snapshot = self.clock.snapshot();
        if let Err(err) = self.clock_sender.send(snapshot) {
            log::error!("Could not send clock snapshot {:?}", err);
        }
        self.clock_snapshot.set(snapshot);
        log::trace!("pre_process");
        for processor in self.processors.iter_mut() {
            processor.pre_process(&mut self.injector, frame);
        }
        log::trace!("plan");
        let planner = self.injector.get_mut::<ExecutionPlanner>().unwrap();
        if planner.should_rebuild() {
            let plan = planner.plan();
            self.rebuild_pipeline(plan);
        }
        log::trace!("process_pipeline");
        self.process_pipeline(frame);
        log::trace!("process");
        for processor in self.processors.iter_mut() {
            processor.process(&self.injector, frame);
        }
        log::trace!("post_process");
        for processor in self.processors.iter_mut() {
            processor.post_process(&self.injector, frame);
        }
        self.read_node_settings();
        #[cfg(feature = "debug-ui")]
        if let Some(ui) = self.ui.as_mut() {
            log::trace!("Update Debug UI");
            let mut render_handle = ui.pre_render();
            render_handle.draw(|ui, texture_map| {
                let pipeline_access = self.injector.get::<PipelineAccess>().unwrap();
                let nodes = pipeline_access.nodes.iter().collect::<Vec<_>>();
                self.pipeline.debug_ui(ui, &nodes);
                Self::debug_ui(ui, texture_map, &self.layouts, &self.plans);
                for processor in self.processors.iter_mut() {
                    processor.update_debug_ui(&self.injector, ui);
                }
            });

            ui.render();
        }
        self.read_states_into_view();
    }
}

impl<TClock: Clock> ProjectManagerMut for CoordinatorRuntime<TClock> {
    fn new_project(&mut self) {
        profiling::scope!("CoordinatorRuntime::new_project");
        let preset_ids = self.get_preset_ids();
        let pipeline_access = self.injector.get_mut::<PipelineAccess>().unwrap();
        let mut paths = Vec::new();
        let programmer_path = pipeline_access
            .handle_add_node(NodeType::Programmer, NodeDesigner::default(), None)
            .unwrap();
        paths.push(programmer_path);
        let transport_path = pipeline_access
            .handle_add_node(NodeType::Transport, NodeDesigner::default(), None)
            .unwrap();
        paths.push(transport_path);
        for preset_id in preset_ids {
            let path = pipeline_access
                .handle_add_node(
                    NodeType::Preset,
                    NodeDesigner {
                        hidden: true,
                        ..Default::default()
                    },
                    Some(Node::Preset(PresetNode { id: preset_id })),
                )
                .unwrap();
            paths.push(path);
        }

        let executor = self.injector.get_mut::<ExecutionPlanner>().unwrap();
        for path in paths {
            executor.add_node(ExecutionNode {
                path,
                attached_executor: None,
            });
        }
        self.force_plan();
    }

    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("CoordinatorRuntime::load");
        for node in &project.nodes {
            let mut node_config: Node = node.config.clone();
            node_config.prepare(&self.injector);
            let pipeline_access = self.injector.get_mut::<PipelineAccess>().unwrap();
            pipeline_access.internal_add_node(
                node.path.clone(),
                node_config,
                node.designer.clone(),
            );
            let executor = self.injector.get_mut::<ExecutionPlanner>().unwrap();
            executor.add_node(ExecutionNode {
                path: node.path.clone(),
                attached_executor: None,
            });
        }
        for link in &project.channels {
            let pipeline_access = self.injector.get_mut::<PipelineAccess>().unwrap();
            let source_port =
                pipeline_access.get_output_port_metadata(&link.from_path, &link.from_channel);
            let target_port =
                pipeline_access.get_input_port_metadata(&link.to_path, &link.to_channel);
            anyhow::ensure!(
                source_port.port_type == target_port.port_type,
                "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
                &source_port,
                &target_port,
                &link
            );
            let link = NodeLink {
                source: link.from_path.clone(),
                source_port: link.from_channel.clone(),
                target: link.to_path.clone(),
                target_port: link.to_channel.clone(),
                port_type: source_port.port_type,
                local: true,
            };
            pipeline_access.add_link(link.clone())?;
            let executor = self.injector.get_mut::<ExecutionPlanner>().unwrap();
            executor.add_link(link);
        }
        self.add_layouts(project.layouts.clone());
        self.plans.set(project.plans.clone());
        self.force_plan();
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("CoordinatorRuntime::save");
        let pipeline_access = self.injector.get::<PipelineAccess>().unwrap();
        project.channels = pipeline_access
            .links
            .read()
            .into_iter()
            .map(|link| Channel {
                from_channel: link.source_port,
                from_path: link.source,
                to_channel: link.target_port,
                to_path: link.target,
            })
            .collect();
        project.layouts = self
            .layouts
            .read()
            .into_iter()
            .map(|layout| (layout.id, layout.controls))
            .collect();
        let designer = pipeline_access.designer.read();
        project.nodes = pipeline_access
            .nodes
            .iter()
            .map(|(name, node)| {
                let node = node.downcast();
                mizer_project_files::Node {
                    designer: designer[name].clone(),
                    path: name.clone(),
                    config: node,
                }
            })
            .collect();
        project.plans = self.plans.read();
    }

    fn clear(&mut self) {
        let pipeline_access = self.injector.get_mut::<PipelineAccess>().unwrap();
        pipeline_access.designer.set(Default::default());
        pipeline_access.nodes.clear();
        self.layouts.set(vec![Layout {
            id: "Default".into(),
            controls: Vec::new(),
        }]);
        pipeline_access.links.set(Default::default());
        pipeline_access.nodes_view.clear();
        self.pipeline = PipelineWorker::new(Arc::clone(&self.node_metadata));
        self.plans.set(Default::default());
        let executor = self.injector.get_mut::<ExecutionPlanner>().unwrap();
        executor.clear();
        self.force_plan();
    }
}

fn register_node(pipeline: &mut PipelineWorker, path: NodePath, node: Node) {
    match node {
        Node::Clock(node) => pipeline.register_node(path, &node),
        Node::Oscillator(node) => pipeline.register_node(path, &node),
        Node::DmxOutput(node) => pipeline.register_node(path, &node),
        Node::Scripting(node) => pipeline.register_node(path, &node),
        Node::Sequence(node) => pipeline.register_node(path, &node),
        Node::Envelope(node) => pipeline.register_node(path, &node),
        Node::Select(node) => pipeline.register_node(path, &node),
        Node::Merge(node) => pipeline.register_node(path, &node),
        Node::Threshold(node) => pipeline.register_node(path, &node),
        Node::Encoder(node) => pipeline.register_node(path, &node),
        Node::Fixture(node) => pipeline.register_node(path, &node),
        Node::Programmer(node) => pipeline.register_node(path, &node),
        Node::Group(node) => pipeline.register_node(path, &node),
        Node::Preset(node) => pipeline.register_node(path, &node),
        Node::Sequencer(node) => pipeline.register_node(path, &node),
        Node::IldaFile(node) => pipeline.register_node(path, &node),
        Node::Laser(node) => pipeline.register_node(path, &node),
        Node::Fader(node) => pipeline.register_node(path, &node),
        Node::Button(node) => pipeline.register_node(path, &node),
        Node::Label(node) => pipeline.register_node(path, &node),
        Node::MidiInput(node) => pipeline.register_node(path, &node),
        Node::MidiOutput(node) => pipeline.register_node(path, &node),
        Node::OpcOutput(node) => pipeline.register_node(path, &node),
        Node::PixelPattern(node) => pipeline.register_node(path, &node),
        Node::PixelDmx(node) => pipeline.register_node(path, &node),
        Node::OscInput(node) => pipeline.register_node(path, &node),
        Node::OscOutput(node) => pipeline.register_node(path, &node),
        Node::VideoFile(node) => pipeline.register_node(path, &node),
        Node::VideoColorBalance(node) => pipeline.register_node(path, &node),
        Node::VideoOutput(node) => pipeline.register_node(path, &node),
        Node::VideoTransform(node) => pipeline.register_node(path, &node),
        Node::VideoMixer(node) => pipeline.register_node(path, &node),
        Node::VideoRgb(node) => pipeline.register_node(path, &node),
        Node::VideoRgbSplit(node) => pipeline.register_node(path, &node),
        Node::ColorConstant(node) => pipeline.register_node(path, &node),
        Node::ColorBrightness(node) => pipeline.register_node(path, &node),
        Node::ColorRgb(node) => pipeline.register_node(path, &node),
        Node::ColorHsv(node) => pipeline.register_node(path, &node),
        Node::Gamepad(node) => pipeline.register_node(path, &node),
        Node::Container(node) => pipeline.register_node(path, &node),
        Node::Math(node) => pipeline.register_node(path, &node),
        Node::MqttInput(node) => pipeline.register_node(path, &node),
        Node::MqttOutput(node) => pipeline.register_node(path, &node),
        Node::NumberToData(node) => pipeline.register_node(path, &node),
        Node::DataToNumber(node) => pipeline.register_node(path, &node),
        Node::Value(node) => pipeline.register_node(path, &node),
        Node::Extract(node) => pipeline.register_node(path, &node),
        Node::PlanScreen(node) => pipeline.register_node(path, &node),
        Node::Delay(node) => pipeline.register_node(path, &node),
        Node::Ramp(node) => pipeline.register_node(path, &node),
        Node::Noise(node) => pipeline.register_node(path, &node),
        Node::Transport(node) => pipeline.register_node(path, &node),
        Node::G13Input(node) => pipeline.register_node(path, &node),
        Node::G13Output(node) => pipeline.register_node(path, &node),
        Node::ConstantNumber(node) => pipeline.register_node(path, &node),
        Node::Conditional(node) => pipeline.register_node(path, &node),
        Node::TimecodeControl(node) => pipeline.register_node(path, &node),
        Node::TimecodeOutput(node) => pipeline.register_node(path, &node),
        Node::AudioFile(node) => pipeline.register_node(path, &node),
        Node::AudioOutput(node) => pipeline.register_node(path, &node),
        Node::AudioVolume(node) => pipeline.register_node(path, &node),
        Node::AudioInput(node) => pipeline.register_node(path, &node),
        Node::AudioMix(node) => pipeline.register_node(path, &node),
        Node::AudioMeter(node) => pipeline.register_node(path, &node),
        Node::Template(node) => pipeline.register_node(path, &node),
        Node::TestSink(node) => pipeline.register_node(path, &node),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn node_runner_should_lend_state_ref() {
        let mut runner = CoordinatorRuntime::new(false);
        let node = FaderNode::default();
        let path = NodePath("/test".to_string());
        runner
            .injector
            .get_mut::<PipelineAccess>()
            .unwrap()
            .internal_add_node(path.clone(), node.into(), Default::default());
        runner
            .injector
            .get_mut::<ExecutionPlanner>()
            .unwrap()
            .add_node(ExecutionNode {
                path: path.clone(),
                attached_executor: None,
            });

        runner.process();

        let state = runner
            .pipeline
            .get_state::<<FaderNode as ProcessingNode>::State>(&path)
            .unwrap();
        assert_eq!(state, &0f64);
    }
}
