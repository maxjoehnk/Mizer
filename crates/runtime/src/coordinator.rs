use std::collections::HashMap;
use std::sync::atomic::AtomicBool;
use std::sync::Arc;
use std::time::Duration;

use itertools::Itertools;
use pinboard::NonEmptyPinboard;

use mizer_clock::{Clock, ClockSnapshot, SystemClock};
use mizer_debug_ui_impl::*;
use mizer_fixtures::manager::FixtureManager;
use mizer_fixtures::programmer::PresetId;
use mizer_layouts::{ControlConfig, ControlType, Layout, LayoutStorage};
use mizer_module::Runtime;
use mizer_node::*;
use mizer_nodes::*;
use mizer_pipeline::*;
use mizer_plan::PlanStorage;
use mizer_processing::*;
use mizer_project_files::{Project, ProjectManagerMut};
use mizer_status_bus::StatusBus;

use crate::api::RuntimeAccess;
use crate::{LayoutsView, NodeMetadataRef, Pipeline};

const DEFAULT_FPS: f64 = 60.0;

pub struct CoordinatorRuntime<TClock: Clock> {
    layouts: LayoutStorage,
    plans: PlanStorage,
    pub clock: TClock,
    injector: Injector,
    processors: Vec<Box<dyn Processor>>,
    clock_recv: flume::Receiver<ClockSnapshot>,
    clock_sender: flume::Sender<ClockSnapshot>,
    clock_snapshot: Arc<NonEmptyPinboard<ClockSnapshot>>,
    layout_fader_view: LayoutsView,
    node_metadata: Arc<NonEmptyPinboard<HashMap<NodePath, NodeRuntimeMetadata>>>,
    status_bus: StatusBus,
    read_node_settings: Arc<AtomicBool>,
}

impl CoordinatorRuntime<SystemClock> {
    pub fn new() -> Self {
        let clock = SystemClock::default();

        Self::with_clock(clock)
    }
}

impl<TClock: Clock> CoordinatorRuntime<TClock> {
    pub fn with_clock(clock: TClock) -> CoordinatorRuntime<TClock> {
        let (clock_tx, clock_rx) = flume::unbounded();
        let snapshot = clock.snapshot();
        let node_metadata = Arc::new(NonEmptyPinboard::new(Default::default()));
        let mut runtime = Self {
            layouts: NonEmptyPinboard::new(Default::default()).into(),
            plans: NonEmptyPinboard::new(Default::default()).into(),
            clock,
            injector: Default::default(),
            processors: Default::default(),
            clock_recv: clock_rx,
            clock_sender: clock_tx,
            clock_snapshot: NonEmptyPinboard::new(snapshot).into(),
            layout_fader_view: Default::default(),
            node_metadata,
            status_bus: Default::default(),
            read_node_settings: Arc::new(AtomicBool::new(false)),
        };
        runtime.bootstrap();

        runtime
    }

    fn bootstrap(&mut self) {
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

    pub fn generate_pipeline_graph(&self) -> anyhow::Result<()> {
        let pipeline = self.injector.inject::<Pipeline>();
        pipeline.generate_pipeline_graph()?;

        Ok(())
    }

    pub fn provide<T: 'static>(&mut self, service: T) {
        self.injector.provide(service);
    }

    pub fn access(&self) -> RuntimeAccess {
        RuntimeAccess {
            layouts: self.layouts.clone(),
            plans: self.plans.clone(),
            clock_recv: self.clock_recv.clone(),
            clock_snapshot: self.clock_snapshot.clone(),
            layouts_view: self.layout_fader_view.clone(),
            status_bus: self.status_bus.clone(),
            read_node_settings: self.read_node_settings.clone(),
        }
    }

    pub fn get_preview_ref(&self, path: &NodePath) -> Option<NodePreviewRef> {
        self.injector.inject::<Pipeline>().get_preview_ref(path)
    }

    pub fn get_node_metadata_ref(&self) -> NodeMetadataRef {
        NodeMetadataRef::new(Arc::clone(&self.node_metadata))
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

        let pipeline = self.injector.inject::<Pipeline>();

        let fader_values = nodes
            .iter()
            .filter_map(|path| {
                pipeline.get_node_with_state::<FaderNode>(path)
                    .map(|(_node, state)| *state)
                    .map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();

        self.layout_fader_view.write_fader_values(fader_values);

        let dial_values = nodes
            .iter()
            .filter_map(|path| {
                pipeline.get_node_with_state::<DialNode>(path)
                    .map(|(_node, state)| *state)
                    .map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();
        self.layout_fader_view.write_dial_values(dial_values);

        let button_values = nodes
            .iter()
            .filter_map(|path| {
                pipeline.get_node_with_state::<ButtonNode>(path)
                    .map(|(node, state)| node.value(state))
                    .map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();

        self.layout_fader_view.write_button_values(button_values);

        let label_values = nodes
            .iter()
            .filter_map(|path| {
                pipeline.get_node_with_state::<LabelNode>(path)
                    .map(|(node, state)| node.label(state))
                    .map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();

        self.layout_fader_view.write_label_values(label_values);

        let button_colors = nodes
            .iter()
            .filter_map(|path| {
                pipeline.get_node_with_state::<ButtonNode>(path)
                    .and_then(|(node, state)| node.color(state))
                    .map(|value| (path.clone(), value))
            })
            .collect::<HashMap<_, _>>();
        
        self.layout_fader_view.write_control_colors(button_colors);
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
    pub(crate) fn read_node_settings(&mut self) {
        let (pipeline, injector) = self.injector.get_slice_mut::<Pipeline>().unwrap();
        pipeline.refresh_settings(injector);
    }

    #[profiling::function]
    pub(crate) fn read_node_metadata(&mut self) {
        let (pipeline, injector) = self.injector.get_slice_mut::<Pipeline>().unwrap();
        pipeline.refresh_metadata(injector);
    }

    /// Should only be used for testing purposes
    // TODO: this should be private, the implementation of the nodes test is such a huge smell regarding app architecture
    #[doc(hidden)]
    #[profiling::function]
    pub fn read_node_ports(&mut self) {
        let (pipeline, injector) = self.injector.get_slice_mut::<Pipeline>().unwrap();
        pipeline.refresh_ports(injector);
    }
}

impl<TClock: Clock> Runtime for CoordinatorRuntime<TClock> {
    fn injector_mut(&mut self) -> &mut Injector {
        &mut self.injector
    }

    fn injector(&self) -> &Injector {
        &self.injector
    }

    fn add_processor(&mut self, processor: impl Processor + 'static) {
        self.processors.push(Box::new(processor));
    }

    fn process(&mut self) {
        profiling::scope!("CoordinatorRuntime::process");
        tracing::trace!("tick");
        let frame = self.clock.tick();
        let snapshot = self.clock.snapshot();
        if let Err(err) = self.clock_sender.send(snapshot) {
            tracing::error!("Could not send clock snapshot {:?}", err);
        }
        self.clock_snapshot.set(snapshot);
        tracing::trace!("pre_process");
        for processor in self.processors.iter_mut() {
            processor.pre_process(&mut self.injector, frame, self.clock.fps());
        }
        tracing::trace!("process");
        for processor in self.processors.iter_mut() {
            processor.process(&mut self.injector, frame);
        }
        tracing::trace!("post_process");
        for processor in self.processors.iter_mut() {
            processor.post_process(&mut self.injector, frame);
        }
        if self
            .read_node_settings
            .load(std::sync::atomic::Ordering::Relaxed)
        {
            self.read_node_settings();
            self.read_node_metadata();
            self.read_node_ports();
        }
        if let Some((ui, injector)) = self.injector.get_slice_mut::<DebugUiImpl>() {
            tracing::trace!("Update Debug UI");
            let mut render_handle = ui.pre_render();
            let pipeline = injector.inject::<Pipeline>();
            render_handle.draw(injector, pipeline);

            ui.render();
        }
        self.read_states_into_view();
    }

    fn add_status_message(&self, message: impl Into<String>, timeout: Option<Duration>) {
        self.status_bus.add_status_message(message, timeout);
    }

    fn fps(&self) -> f64 {
        self.clock.fps()
    }

    fn set_fps(&mut self, fps: f64) {
        *self.clock.fps_mut() = fps;
    }
}

impl<TClock: Clock> ProjectManagerMut for CoordinatorRuntime<TClock> {
    fn new_project(&mut self) {
        profiling::scope!("CoordinatorRuntime::new_project");
        self.set_fps(DEFAULT_FPS);
        let preset_ids = self.get_preset_ids();
        let (pipeline, injector) = self.injector.get_slice_mut::<Pipeline>().unwrap();
        pipeline.new_project(injector);
        for preset_id in preset_ids {
            pipeline
                .add_node(
                    injector,
                    NodeType::Preset,
                    NodeDesigner {
                        hidden: true,
                        ..Default::default()
                    },
                    Some(Node::Preset(PresetNode { id: preset_id })),
                    None,
                )
                .unwrap();
        }
    }

    fn load(&mut self, project: &Project) -> anyhow::Result<()> {
        profiling::scope!("CoordinatorRuntime::load");
        self.set_fps(project.playback.fps);
        let (pipeline, injector) = self.injector.get_slice_mut::<Pipeline>().unwrap();
        pipeline.load(project, injector)?;
        self.add_layouts(project.layouts.clone());
        self.plans.set(project.plans.clone());
        Ok(())
    }

    fn save(&self, project: &mut Project) {
        profiling::scope!("CoordinatorRuntime::save");
        project.playback.fps = self.fps();
        let pipeline = self.injector.inject::<Pipeline>();
        pipeline.save(project);
        project.layouts = self
            .layouts
            .read()
            .into_iter()
            .map(|layout| (layout.id, layout.controls))
            .collect();
        project.plans = self.plans.read();
    }

    fn clear(&mut self) {
        self.set_fps(DEFAULT_FPS);
        let pipeline = self.injector.get_mut::<Pipeline>().unwrap();
        pipeline.clear();
        self.layouts.set(vec![Layout {
            id: "Default".into(),
            controls: Vec::new(),
        }]);
        self.plans.set(Default::default());
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn node_runner_should_lend_state_ref() {
        let mut runner = CoordinatorRuntime::new();
        let mut pipeline = Pipeline::new();
        let node = pipeline.add_node(runner.injector(), NodeType::Fader, Default::default(), Default::default(), Default::default()).unwrap();
        runner.injector.provide(pipeline);

        runner.process();

        let pipeline = runner.injector.inject::<Pipeline>();
        let state = pipeline
            .read_state::<<FaderNode as ProcessingNode>::State>(&node.path)
            .unwrap();
        assert_eq!(state, &0f64);
    }
}
