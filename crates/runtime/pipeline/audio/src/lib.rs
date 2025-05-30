use std::collections::HashMap;
use mizer_node::*;
use uuid::Uuid;
use daggy::{Dag, NodeIndex, Walker};
use daggy::petgraph::{Direction, EdgeDirection};
use daggy::petgraph::visit::{VisitMap, Visitable};
use dasp::frame::Stereo;
use dasp::Signal;

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
#[repr(transparent)]
struct WorkerId(Uuid);

pub struct AudioPipeline {
    worker_ids: HashMap<(NodePath, WorkerNodeDefinition), WorkerId>,
}

struct AudioPipelineThread {
    graph: Dag<WorkerId, WorkerPortId>,
    workers: HashMap<WorkerId, Box<dyn AudioWorkerNode>>,
    definitions: HashMap<WorkerId, WorkerNodeDefinition>,
    sample_rate: u32,
}

impl AudioPipelineThread {
    pub fn process(&mut self) {
        let mut visit_map = self.graph.visit_map();
        let roots = self.graph.graph().externals(Direction::Outgoing);

        for root in roots {
            let mut walker = daggy::walker::Filter::new(self.graph.children(root), |dag, (edge, node)| {
                visit_map.visit(*node)
            });

            while let Some((edge_index, node_index)) = walker.walk_next(&self.graph) {
                let node = &self.graph[node_index];
                
                let worker = self.workers.get_mut(node).unwrap();
                let mut context = TestContext {};
                worker.process(&mut context);
            }
        }
    }
}

struct TestContext {}

impl AudioWorkerNodeContext for TestContext {
    fn input_signal(&self, port: WorkerPortId) -> Option<Box<impl Signal<Frame=Stereo<f32>>>> {
        todo!()
    }

    fn output_signal(&mut self, port: WorkerPortId, signal: impl Signal<Frame=Stereo<f32>>) {
        todo!()
    }

    fn read_data<T>(&self, port: WorkerPortId) -> Option<T> {
        todo!()
    }

    fn write_data<T>(&mut self, port: WorkerPortId, data: T) {
        todo!()
    }
}