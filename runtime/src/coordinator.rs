use crate::api::{ApiCommand, RuntimeApi};
use dashmap::DashMap;
use mizer_clock::{Clock, SystemClock};
use mizer_execution_planner::*;
use mizer_module::Runtime;
use mizer_node::*;
use mizer_nodes::Node;
use mizer_pipeline::*;
use mizer_processing::*;
use mizer_project_files::{NodeConfig, Project};
use pinboard::NonEmptyPinboard;
use std::collections::HashMap;
use std::io::Write;
use std::sync::Arc;
use mizer_layouts::{Layout, ControlConfig};

pub struct CoordinatorRuntime<TClock: Clock> {
    executor_id: ExecutorId,
    planner: ExecutionPlanner,
    nodes: HashMap<NodePath, Box<dyn ProcessingNodeExt>>,
    nodes_view: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    pipeline: PipelineWorker,
    assigned_nodes: Vec<NodePath>,
    clock: TClock,
    injector: Injector,
    processors: Vec<Box<dyn Processor>>,
    api_recv: flume::Receiver<ApiCommand>,
    api_sender: flume::Sender<ApiCommand>,
}

impl CoordinatorRuntime<SystemClock> {
    pub fn new() -> Self {
        let (tx, rx) = flume::unbounded();
        let mut runtime = Self {
            executor_id: ExecutorId("coordinator".to_string()),
            planner: Default::default(),
            nodes: Default::default(),
            nodes_view: Default::default(),
            designer: NonEmptyPinboard::new(Default::default()).into(),
            links: NonEmptyPinboard::new(Default::default()).into(),
            layouts: NonEmptyPinboard::new(Default::default()).into(),
            pipeline: PipelineWorker::new(),
            assigned_nodes: Default::default(),
            clock: SystemClock::default(),
            injector: Default::default(),
            processors: Default::default(),
            api_recv: rx,
            api_sender: tx,
        };
        runtime.bootstrap();

        runtime
    }
}

impl<TClock: Clock> CoordinatorRuntime<TClock> {
    pub fn with_clock(clock: TClock) -> CoordinatorRuntime<TClock> {
        let (tx, rx) = flume::unbounded();
        let mut runtime = Self {
            executor_id: ExecutorId("coordinator".to_string()),
            planner: Default::default(),
            nodes: Default::default(),
            nodes_view: Default::default(),
            designer: NonEmptyPinboard::new(Default::default()).into(),
            links: NonEmptyPinboard::new(Default::default()).into(),
            layouts: NonEmptyPinboard::new(Default::default()).into(),
            pipeline: PipelineWorker::new(),
            assigned_nodes: Default::default(),
            clock,
            injector: Default::default(),
            processors: Default::default(),
            api_recv: rx,
            api_sender: tx,
        };
        runtime.bootstrap();

        runtime
    }

    fn bootstrap(&mut self) {
        let executor = Executor {
            id: self.executor_id.clone(),
        };
        self.planner.add_executor(executor);
    }

    pub fn load_project(&mut self, project: Project) -> anyhow::Result<()> {
        for node in project.nodes {
            self.add_project_node(node.path.clone(), node.config.into());
            self.add_designer_node(node.path, node.designer);
        }
        for link in project.channels {
            let link = NodeLink {
                source: link.from_path,
                source_port: link.from_channel,
                target: link.to_path,
                target_port: link.to_channel,
                port_type: PortType::Single,
                local: true,
            };
            self.add_link(link)?;
        }
        self.add_layouts(project.layouts);
        Ok(())
    }

    fn add_project_node(&mut self, path: NodePath, node: Node) {
        use Node::*;
        match node {
            DmxOutput(node) => self.add_node(path, node),
            Oscillator(node) => self.add_node(path, node),
            Clock(node) => self.add_node(path, node),
            Scripting(node) => self.add_node(path, node),
            Sequence(node) => self.add_node(path, node),
            Fixture(mut node) => {
                node.fixture_manager = self.injector.get().cloned();
                self.add_node(path, node)
            }
            IldaFile(node) => self.add_node(path, node),
            Laser(node) => self.add_node(path, node),
            Fader(node) => self.add_node(path, node),
            Button(node) => self.add_node(path, node),
            OpcOutput(node) => self.add_node(path, node),
            PixelPattern(node) => self.add_node(path, node),
            PixelDmx(node) => self.add_node(path, node),
            OscInput(node) => self.add_node(path, node),
            VideoFile(node) => self.add_node(path, node),
            VideoTransform(node) => self.add_node(path, node),
            VideoColorBalance(node) => self.add_node(path, node),
            VideoEffect(node) => self.add_node(path, node),
            VideoOutput(node) => self.add_node(path, node),
            MidiInput(node) => self.add_node(path, node),
            MidiOutput(node) => self.add_node(path, node),
        }
    }

    fn add_designer_node(&mut self, path: NodePath, designer: NodeDesigner) {
        let mut nodes = self.designer.read();
        nodes.insert(path, designer);
        self.designer.set(nodes);
    }

    pub fn add_node<T: 'static + ProcessingNode<State = S>, S: 'static>(
        &mut self,
        path: NodePath,
        node: T,
    ) {
        log::debug!("adding node {}: {:?}", &path, node);
        self.nodes_view.insert(path.clone(), Box::new(node.clone()));
        let execution_node = (path.clone(), &node).into();
        // TODO: this needs to be called by plan in the future
        self.pipeline.register_node(path.clone(), &node);
        let node = Box::new(node);
        self.nodes.insert(path, node);
        self.planner.add_node(execution_node);

        self.plan();
    }

    pub fn add_link(&mut self, mut link: NodeLink) -> anyhow::Result<()> {
        let (source_port, target_port) = self.get_ports(&link)?;
        anyhow::ensure!(
            source_port.port_type == target_port.port_type,
            "Missmatched port types\nsource: {:?}\ntarget: {:?}\nlink: {:?}",
            &source_port,
            &target_port,
            &link
        );
        link.port_type = source_port.port_type;
        let mut links = self.links.read();
        links.push(link.clone());
        self.links.set(links);
        self.planner.add_link(link.clone());
        self.plan();

        self.pipeline
            .connect_nodes(link, source_port, target_port)?;

        Ok(())
    }

    fn get_ports(&self, link: &NodeLink) -> anyhow::Result<(PortMetadata, PortMetadata)> {
        let source_node = self.nodes.get(&link.source).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.source)
        })?;
        let target_node = self.nodes.get(&link.target).ok_or_else(|| {
            anyhow::anyhow!("trying to add link for unknown node: {}", &link.target)
        })?;
        let source_port = source_node
            .introspect_port(&link.source_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.source_port,
                    link.source
                )
            })?;
        let target_port = target_node
            .introspect_port(&link.target_port)
            .ok_or_else(|| {
                anyhow::anyhow!(
                    "Unknown port '{}' on node '{}'",
                    link.target_port,
                    link.target
                )
            })?;

        Ok((source_port, target_port))
    }

    fn add_layouts(&self, layouts: HashMap<String, Vec<ControlConfig>>) {
        let layouts = layouts.into_iter()
            .map(|(id, controls)| Layout {
                id,
                controls
            })
            .collect();

        self.layouts.set(layouts);
    }

    fn plan(&mut self) {
        let plan = self.planner.plan();
        log::trace!("{:?}", plan);

        let executor = plan.get_executor(&self.executor_id).unwrap();
        self.assigned_nodes = executor
            .associated_nodes
            .into_iter()
            .map(|node| node.path)
            .collect();
    }

    fn process_pipeline(&mut self) {
        let frame = self.clock.tick();

        let nodes = self
            .nodes
            .iter()
            .filter(|(path, _)| self.assigned_nodes.contains(path))
            .collect::<Vec<_>>(); // run filter closure here so mutable and immutable borrow is okay

        self.pipeline.process(nodes, frame, &self.injector);
    }

    pub fn generate_pipeline_graph(&self) -> anyhow::Result<()> {
        let mut file = std::fs::File::create("pipeline.dot")?;
        writeln!(&mut file, "digraph pipeline {{")?;
        let mut node_ids = HashMap::new();
        for (counter, (path, _)) in self.nodes.iter().enumerate() {
            node_ids.insert(path, format!("N{}", counter));
            writeln!(&mut file, "  N{}[label=\"{}\",shape=box];", counter, path)?;
        }
        for link in self.links.read().iter() {
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

    pub fn api(&self) -> RuntimeApi {
        RuntimeApi {
            nodes: self.nodes_view.clone(),
            designer: self.designer.clone(),
            links: self.links.clone(),
            layouts: self.layouts.clone(),
            sender: self.api_sender.clone(),
        }
    }

    fn handle_api_commands(&mut self) {
        match self.api_recv.try_recv() {
            Ok(ApiCommand::AddNode(node_type, designer, sender)) => {
                self.handle_add_node(node_type, designer, sender)
            }
            Ok(ApiCommand::WritePort(path, port, value)) => {
                self.pipeline.write_port(path, port, value)
            }
            Err(flume::TryRecvError::Empty) => {}
            Err(flume::TryRecvError::Disconnected) => panic!("api command receiver disconnected"),
        }
    }

    fn handle_add_node(
        &mut self,
        node_type: NodeType,
        designer: NodeDesigner,
        sender: flume::Sender<NodePath>,
    ) {
        let path: NodePath = format!("/{}", node_type.get_name(1)).into();
        self.add_project_node(path.clone(), node_type.into());
        self.add_designer_node(path.clone(), designer);

        sender.send(path);
    }
}

impl<TClock: Clock> Runtime for CoordinatorRuntime<TClock> {
    fn injector(&mut self) -> &mut Injector {
        &mut self.injector
    }

    fn add_processor(&mut self, processor: Box<dyn Processor>) {
        self.processors.push(processor);
    }

    fn process(&mut self) {
        self.handle_api_commands();
        self.process_pipeline();
        for processor in self.processors.iter() {
            processor.process(&self.injector);
        }
        for processor in self.processors.iter() {
            processor.post_process(&self.injector);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn node_runner_should_lend_state_ref() {
        let mut runner = CoordinatorRuntime::new();
        let node = TestNode;
        let path = NodePath("/test".to_string());
        runner.add_node(path.clone(), node);

        runner.process();

        let state = runner.pipeline.get_state::<TestState>(&path).unwrap();
        assert_eq!(state, &TestState { counter: 1 });
    }

    #[derive(Default, Debug, Clone)]
    struct TestNode;

    #[derive(Debug, Default, PartialEq, Eq)]
    struct TestState {
        counter: u8,
    }

    impl PipelineNode for TestNode {
        fn details(&self) -> NodeDetails {
            NodeDetails {
                name: "TestNode".into(),
            }
        }

        fn node_type(&self) -> NodeType {
            unimplemented!()
        }
    }

    impl ProcessingNode for TestNode {
        type State = TestState;

        fn process(&self, _: &impl NodeContext, state: &mut TestState) -> anyhow::Result<()> {
            state.counter += 1;
            println!("{:?}", state);
            Ok(())
        }

        fn create_state(&self) -> Self::State {
            Default::default()
        }
    }
}
