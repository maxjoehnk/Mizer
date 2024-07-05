use std::collections::HashMap;
use indexmap::IndexMap;
use mizer_clock::ClockFrame;
use mizer_debug_ui_impl::Injector;
use mizer_node::{NodeDesigner, NodeLink, NodeMetadata, NodePath, NodeSetting, NodeType, PortMetadata};
use mizer_nodes::Node;
use mizer_pipeline::{PipelineWorker, ProcessingNodeExt};
use mizer_ports::PortId;
use mizer_processing::Processor;
use crate::commands::StaticNodeDescriptor;

pub struct Pipeline {
    nodes: IndexMap<NodePath, NodeState>,
    worker: PipelineWorker,
}

struct NodeState {
    node: Box<dyn ProcessingNodeExt>,
    designer: NodeDesigner,
    metadata: NodeMetadata,
    settings: Vec<NodeSetting>,
    ports: Vec<(PortId, PortMetadata)>,
}

impl Pipeline {
    pub fn add_node(&mut self, node_type: NodeType, designer: NodeDesigner, node: Option<Node>, parent: Option<&NodePath>) -> anyhow::Result<StaticNodeDescriptor> {
        let node = node.unwrap_or_else(|| node_type.into());
        let state = NodeState {
            metadata: Default::default(),
            designer,
            settings: node.settings(),
            ports: node.list_ports(),
            node: Box::new(node),
        };

        todo!()
    }
    
    pub fn remove_node(&mut self, node_path: &NodePath) -> anyhow::Result<()> {
        todo!()
    }
    
    pub fn contains_node(&self, path: &NodePath) -> bool {
        todo!()
    }
}


impl Processor for Pipeline {
    fn pre_process(&mut self, _injector: &mut Injector, _frame: ClockFrame, _fps: f64) {
        profiling::scope!("Pipeline::pre_process");
        self.worker.pre_process();
    }

    fn process(&mut self, _injector: &Injector, _frame: ClockFrame) {
        profiling::scope!("Pipeline::process");
        self.worker.process();
    }

    fn post_process(&mut self, _injector: &mut Injector, _frame: ClockFrame) {
        profiling::scope!("Pipeline::post_process");
        self.worker.post_process();
    }
}
