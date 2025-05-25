use std::collections::HashMap;
use mizer_node::*;
use uuid::Uuid;
use daggy::{Dag, NodeIndex, Walker};
use daggy::petgraph::{Direction, EdgeDirection};
use daggy::petgraph::visit::{VisitMap, Visitable};

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
                
                let worker = &mut self.workers[node];
                let context;
                worker.process(&mut context);
            }
        }


        let mut walker = daggy::walker::Chain::new(self.graph.)
        let mut walker = self.graph.recursive_walk(
            NodeIndex::default(),
            daggy::walker::Chain,
        );
        self.graph.graph().externals(Direction::Outgoing)
        walker.walk_next(&self.graph);
    }
}
