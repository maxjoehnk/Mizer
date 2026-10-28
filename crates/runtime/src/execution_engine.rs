use indexmap::{IndexMap, IndexSet};
use mizer_node::{NodeLink, NodePath};
use mizer_ports::PortId;
use mizer_util::HashMapExtension;
use std::collections::{HashMap, VecDeque};

#[derive(Default, Debug)]
pub(crate) struct ExecutionEngine {
    last_id: usize,
    sub_graphs: IndexMap<SubGraphId, SubGraph>,
    node_graphs: IndexMap<NodePath, SubGraphId>,
}

#[derive(Debug, Clone, Copy, PartialOrd, PartialEq, Ord, Eq, Hash)]
#[repr(transparent)]
struct SubGraphId(usize);

#[derive(Default, Debug)]
struct SubGraph {
    nodes: IndexSet<NodePath>,
    links: IndexSet<NodeLink>,
    outgoing_edges: HashMap<NodePath, HashMap<PortId, IndexSet<NodeLink>>>,
    incoming_links: HashMap<NodePath, IndexSet<NodeLink>>,
}

impl SubGraph {
    fn new(path: NodePath) -> Self {
        Self {
            nodes: IndexSet::from_iter([path]),
            ..Default::default()
        }
    }

    /// L ← Empty list that will contain the sorted elements
    /// S ← Set of all nodes with no incoming edge
    ///
    /// while S is not empty do
    ///     remove a node n from S
    ///     add n to L
    ///     for each node m with an edge e from n to m do
    ///         remove edge e from the graph
    ///         if m has no other incoming edges then
    ///             insert m into S
    ///
    /// if graph has edges then
    ///     return error   (graph has at least one cycle)
    /// else
    ///     return L   (a topologically sorted order)
    #[profiling::function]
    fn sort(&mut self) {
        // TODO: reduce allocations by using indices instead of clones
        tracing::debug!("Sorting {:?}", self.nodes);
        let mut edges = self.links.clone();
        let mut incoming_links = self.incoming_links.clone();

        let mut sorted_nodes = IndexSet::with_capacity(self.nodes.len());
        let mut nodes_without_incoming = self
            .nodes
            .iter()
            .filter(|node| !incoming_links.contains_key(node))
            .collect::<VecDeque<_>>();

        while !nodes_without_incoming.is_empty() {
            let current_source_node = nodes_without_incoming.pop_front().unwrap();

            sorted_nodes.insert(current_source_node.clone());

            let Some(outgoing_edges) = self.outgoing_edges.get(&current_source_node) else {
                continue;
            };
            for (_, links) in outgoing_edges {
                for e in links.iter() {
                    edges.shift_remove(e);

                    let current_target_node = &e.target;
                    if let Some(incoming_links) = incoming_links.get_mut(current_target_node) {
                        incoming_links.shift_remove(e);
                    }

                    if incoming_links
                        .get(current_target_node)
                        .is_none_or(|links| links.is_empty())
                    {
                        nodes_without_incoming.push_back(current_target_node);
                    }
                }
            }
        }

        if !edges.is_empty() {
            tracing::warn!("Graph has edges that were not placed, indicating cycles: {}", edges.len());
        }
        self.nodes = sorted_nodes;
    }

    /// Remove the given link from the graph, returning a new subgraph in case this frees any nodes
    fn remove_link(&mut self, link: &NodeLink) -> Option<SubGraph> {
        let has_incoming_links_before = self.has_incoming_links(link);
        let has_outgoing_links_before = self.has_outgoing_links(link);

        self.links.shift_remove(link);

        if let Some(incoming) = self.incoming_links.get_mut(&link.target) {
            incoming.shift_remove(link);
        }

        if let Some(outgoing) = self.outgoing_edges.get_mut(&link.source) {
            if let Some(outgoing) = outgoing.get_mut(&link.source_port) {
                tracing::debug!("removing outgoing connection");
                outgoing.shift_remove(link);
            }
        }

        let has_incoming_links = self.has_incoming_links(link);
        let has_outgoing_links = self.has_outgoing_links(link);

        if !has_incoming_links && !has_outgoing_links {
            if let Some(node) = self.nodes.shift_take(&link.source) {
                return Some(SubGraph::new(node));
            }
        }

        // TODO: support splitting out bigger graphs
        if has_outgoing_links != has_outgoing_links_before {
            tracing::debug!("splitting graph at output");
            let mut graph = SubGraph::default();

            let mut to_be_split = [link.source.clone()].into_iter().collect::<VecDeque<_>>();

            while !to_be_split.is_empty() {
                let node = to_be_split.pop_front().unwrap();
                if let Some(incoming) = self.incoming_links.remove(&node) {
                    to_be_split.extend(incoming.iter().map(|incoming| incoming.source.clone()));
                    graph.links.extend(incoming.clone());
                    graph.incoming_links.insert(node.clone(), incoming);
                }
                if let Some(outgoing) = self.outgoing_edges.remove(&node) {
                    for (port, links) in outgoing {
                        to_be_split.extend(links.iter().map(|incoming| incoming.source.clone()));
                        graph.links.extend(links.clone());
                        graph.outgoing_edges.insert(node.clone(), port);
                    }
                }
                graph.nodes.insert(node);
            }

            if let Some(incoming) = self.incoming_links.remove(&link.source) {
                graph
                    .nodes
                    .extend(incoming.iter().map(|incoming| incoming.source.clone()));
                graph.links.extend(incoming.clone());
                graph.incoming_links.insert(link.source.clone(), incoming);
            }
            graph.nodes.insert(link.source.clone());

            for node in &graph.nodes {
                self.nodes.shift_remove(node);
            }
            for link in &graph.links {
                self.links.shift_remove(link);
            }

            return Some(graph);
        }

        // TODO: support splitting out bigger graphs
        if has_incoming_links != has_incoming_links_before {
            tracing::debug!("splitting graph at input");
            let mut graph = SubGraph::default();
            graph.nodes.insert(link.target.clone());
            if let Some(outgoing) = self.outgoing_edges.remove(&link.target) {
                for (port, links) in outgoing {
                    graph
                        .nodes
                        .extend(links.iter().map(|outgoing| outgoing.target.clone()));
                    graph.links.extend(links.clone());
                    graph
                        .outgoing_edges
                        .entry(link.target.clone())
                        .or_default()
                        .entry(port.clone())
                        .or_default()
                        .extend(links);
                }
            }

            for node in &graph.nodes {
                self.nodes.shift_remove(node);
            }
            for link in &graph.links {
                self.links.shift_remove(link);
            }

            return Some(graph);
        }

        None
    }

    fn has_incoming_links(&self, link: &NodeLink) -> bool {
        self.incoming_links
            .get(&link.target)
            .map_or(false, |incoming| !incoming.is_empty())
    }

    fn has_outgoing_links(&self, link: &NodeLink) -> bool {
        self.outgoing_edges
            .get(&link.source)
            .map_or(false, |ports| {
                ports
                    .get(&link.source_port)
                    .map_or(false, |outgoing| !outgoing.is_empty())
            })
    }
}

impl ExecutionEngine {
    fn next_id(&mut self) -> SubGraphId {
        self.last_id += 1;

        SubGraphId(self.last_id)
    }

    pub fn add_node(&mut self, path: NodePath) {
        let mut graph = SubGraph::default();
        graph.nodes.insert(path.clone());
        let id = self.next_id();
        tracing::debug!("Inserting node {path} into sub graph {id:?}");
        self.sub_graphs.insert(id, graph);

        self.node_graphs.insert(path, id);
    }

    pub fn remove_node(&mut self, path: &NodePath) {
        if let Some(id) = self.node_graphs.shift_remove(path) {
            if let Some(graph) = self.sub_graphs.get_mut(&id) {
                graph.nodes.shift_remove(path);
            }
        }
    }

    #[profiling::function]
    pub fn link_node(&mut self, link: NodeLink) -> anyhow::Result<()> {
        let source = *self
            .node_graphs
            .get(&link.source)
            .ok_or_else(|| anyhow::anyhow!("Missing source {}", link.source))?;
        let target = *self
            .node_graphs
            .get(&link.target)
            .ok_or_else(|| anyhow::anyhow!("Missing target {}", link.target))?;

        if source != target {
            if let [Some(source_graph), Some(target_graph)] =
                self.sub_graphs.get_disjoint_mut([&source, &target])
            {
                for node in &target_graph.nodes {
                    tracing::debug!("Moving node {} to sub graph {source:?}", node);
                    source_graph.nodes.insert(node.clone());
                    self.node_graphs.insert(node.clone(), source);
                }
                target_graph.nodes.clear();

                for link in &target_graph.links {
                    tracing::debug!("Moving link {} to sub graph {source:?}", link);
                    source_graph.links.insert(link.clone());

                    source_graph
                        .incoming_links
                        .entry(link.target.clone())
                        .or_default()
                        .insert(link.clone());

                    let edge = source_graph
                        .outgoing_edges
                        .entry(link.source.clone())
                        .or_default();
                    let edge = edge.entry(link.source_port.clone()).or_default();
                    edge.insert(link.clone());
                }
            }
        }

        if let Some(graph) = self.sub_graphs.get_mut(&source) {
            tracing::debug!("Inserting link {} to sub graph {source:?}", link);
            graph
                .incoming_links
                .entry(link.target.clone())
                .or_default()
                .insert(link.clone());

            let edge = graph.outgoing_edges.entry(link.source.clone()).or_default();
            let edge = edge.entry(link.source_port.clone()).or_default();
            edge.insert(link.clone());

            graph.links.insert(link);

            graph.sort();
        }

        self.clear_empty_graphs();

        Ok(())
    }

    pub fn get_execution_order(&self) -> impl Iterator<Item = &NodePath> {
        self.sub_graphs
            .iter()
            .flat_map(|(_, graph)| graph.nodes.iter())
    }

    pub fn rename_node(&mut self, from: &NodePath, to: NodePath) -> anyhow::Result<()> {
        if let Some(id) = self.node_graphs.get(from) {
            if let Some(nodes) = self.sub_graphs.get_mut(id) {
                if let Some(index) = nodes.nodes.get_index_of(from) {
                    nodes
                        .nodes
                        .replace_index(index, to.clone())
                        .map_err(|(index, value)| {
                            anyhow::anyhow!("new name already exists at index {index}")
                        })?;
                }
            }
        }
        self.node_graphs.rename_key(from, to);

        Ok(())
    }

    pub fn remove_link(&mut self, link: &NodeLink) {
        let Some(graph) = self
            .node_graphs
            .get(&link.source)
            .and_then(|id| self.sub_graphs.get_mut(id))
        else {
            return;
        };

        if let Some(new_graph) = graph.remove_link(link) {
            let id = self.next_id();
            for node in &new_graph.nodes {
                self.node_graphs.insert(node.clone(), id);
            }

            self.sub_graphs.insert(id, new_graph);
        }
    }

    fn clear_empty_graphs(&mut self) {
        let to_remove = self
            .sub_graphs
            .iter()
            .filter(|(_, g)| g.nodes.is_empty())
            .map(|(id, _)| *id)
            .collect::<Vec<_>>();
        for id in to_remove {
            self.sub_graphs.shift_remove(&id);
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use assertables::*;
    use mizer_ports::PortType;
    use proptest::prelude::*;
    use test_case::test_case;

    #[test]
    fn add_node_should_create_new_graph_for_node() {
        let path = NodePath::from("/source");
        let mut engine = ExecutionEngine::default();

        engine.add_node(path.clone());

        assert_eq!(engine.sub_graphs.len(), 1);
        assert!(engine.sub_graphs[0].nodes.contains(&path));
        assert_eq!(engine.node_graphs.get(&path), Some(&SubGraphId(1)));
    }

    #[test]
    fn add_link_should_combine_two_subgraphs() {
        let source = NodePath::from("/source");
        let sink = NodePath::from("/sink");
        let mut engine = ExecutionEngine::default();
        add_nodes(&mut engine, [&source, &sink]);

        link_node(&mut engine, &source, &sink);

        assert_eq!(engine.sub_graphs.len(), 1);
        let graph = &engine.sub_graphs[0];
        assert_eq!(graph.nodes.len(), 2);
        assert_eq!(graph.nodes[0], source);
        assert_eq!(graph.nodes[1], sink);
        assert_eq!(engine.node_graphs.len(), 2);
        assert_eq!(engine.node_graphs[&source], SubGraphId(1));
        assert_eq!(engine.node_graphs[&sink], SubGraphId(1));
    }

    #[test]
    fn get_execution_order_should_return_unrelated_nodes_in_insertion_order() {
        let source = NodePath::from("/source");
        let sink = NodePath::from("/sink");
        let mut engine = ExecutionEngine::default();
        add_nodes(&mut engine, [&source, &sink]);

        let nodes = engine.get_execution_order().collect::<Vec<_>>();

        assert_iter_eq!(nodes, vec![&source, &sink]);
    }

    proptest! {
        #[test]
        fn get_execution_order_should_return_related_nodes_in_dependency_order(count in 2..50) {
            let paths = (0..count).map(|i| NodePath::from(format!("/node-{i}"))).collect::<Vec<_>>();
            let mut engine = ExecutionEngine::default();
            add_nodes(&mut engine, &paths);
            for window in paths.windows(2) {
                link_node(&mut engine, &window[0], &window[1]);
            }

            let nodes = engine.get_execution_order().collect::<Vec<_>>();

            let expected = paths.iter().collect::<Vec<_>>();
            assert_iter_eq!(nodes, expected);
        }

        #[test]
        fn get_execution_order_should_return_reversed_nodes_in_dependency_order(count in 2..50) {
            let paths = (0..count).map(|i| NodePath::from(format!("/node-{i}"))).collect::<Vec<_>>();
            let mut engine = ExecutionEngine::default();
            add_nodes(&mut engine, &paths);
            for window in paths.windows(2) {
                link_node(&mut engine, &window[1], &window[0]);
            }

            let nodes = engine.get_execution_order().collect::<Vec<_>>();

            let expected = paths.iter().rev().collect::<Vec<_>>();
            assert_iter_eq!(nodes, expected);
        }
    }

    #[test]
    fn get_execution_order_should_return_nodes_in_diamond_shape() {
        let sink = NodePath::from("/fader-1");
        let left = NodePath::from("/fader-2");
        let right = NodePath::from("/fader-3");
        let source = NodePath::from("/fader-4");
        let mut engine = ExecutionEngine::default();
        add_nodes(&mut engine, [&sink, &left, &right, &source]);
        link_node(&mut engine, &source, &left);
        link_node(&mut engine, &source, &right);
        link_node(&mut engine, &left, &sink);
        link_node(&mut engine, &right, &sink);

        let nodes = engine.get_execution_order().collect::<Vec<_>>();

        assert_iter_eq!(nodes, [&source, &left, &right, &sink]);
    }

    #[test_case("/source", "/sink")]
    #[test_case("/fader-1", "/main-level")]
    fn rename_node_should_update_the_name_in_the_execution_order(before: &str, after: &str) {
        let before = NodePath::from(before);
        let after = NodePath::from(after);
        let mut engine = ExecutionEngine::default();
        engine.add_node(before.clone());

        engine.rename_node(&before, after.clone()).unwrap();

        let order = engine.get_execution_order().collect::<Vec<_>>();
        assert_iter_eq!(order, [&after]);
    }

    #[test]
    fn remove_link_should_split_unrelated_nodes_into_separate_graphs() {
        let left = NodePath::from("/left");
        let middle = NodePath::from("/middle");
        let right = NodePath::from("/right");
        let mut engine = ExecutionEngine::default();
        add_nodes(&mut engine, [&left, &middle, &right]);
        link_node(&mut engine, &left, &middle);
        link_node(&mut engine, &middle, &right);

        remove_link(&mut engine, &left, &middle);

        assert_eq!(engine.sub_graphs.len(), 2);
        let graphs = engine.sub_graphs.values().collect::<Vec<_>>();
        assert_iter_eq!(graphs[0].nodes, [middle, right]);
        assert_iter_eq!(graphs[1].nodes, [left]);
    }

    proptest! {
        #[test]
        fn remove_link_should_split_two_sub_graphs_from_source(left_count in 1..100, right_count in 1..100) {
            let mut engine = ExecutionEngine::default();
            let left_paths = (0..left_count).map(|i| NodePath::from(format!("/left-{}", i))).collect::<Vec<_>>();
            add_nodes(&mut engine, left_paths.iter());
            let right_paths = (0..right_count).map(|i| NodePath::from(format!("/right-{}", i))).collect::<Vec<_>>();
            add_nodes(&mut engine, right_paths.iter());
            for window in left_paths.windows(2) {
                link_node(&mut engine, &window[0], &window[1]);
            }
            for window in right_paths.windows(2) {
                link_node(&mut engine, &window[0], &window[1]);
            }
            let source = NodePath::from("/source");
            add_nodes(&mut engine, [&source]);
            link_node(&mut engine, &source, &left_paths[0]);
            link_node(&mut engine, &source, &right_paths[0]);

            remove_link(&mut engine, &source, &left_paths[0]);

            assert_eq!(engine.sub_graphs.len(), 2);
            let graphs = engine.sub_graphs.values().collect::<Vec<_>>();
            let mut expected = right_paths.clone();
            expected.insert(0, source);
            assert_iter_eq!(graphs[0].nodes, expected);
            assert_iter_eq!(graphs[1].nodes, left_paths);
        }
    }

    proptest! {
        #[test]
        fn remove_link_should_split_two_sub_graphs_from_target(left_count in 1..100, right_count in 1..100) {
            let mut engine = ExecutionEngine::default();
            let left_paths = (0..left_count).map(|i| NodePath::from(format!("/left-{}", i))).collect::<Vec<_>>();
            add_nodes(&mut engine, left_paths.iter());
            let right_paths = (0..right_count).map(|i| NodePath::from(format!("/right-{}", i))).collect::<Vec<_>>();
            add_nodes(&mut engine, right_paths.iter());
            for window in left_paths.windows(2) {
                link_node(&mut engine, &window[0], &window[1]);
            }
            for window in right_paths.windows(2) {
                link_node(&mut engine, &window[0], &window[1]);
            }
            let sum = NodePath::from("/sum");
            add_nodes(&mut engine, [&sum]);
            link_node(&mut engine, &left_paths[0], &sum);
            link_node(&mut engine, &right_paths[0], &sum);

            remove_link(&mut engine, &left_paths[0], &sum);

            assert_eq!(engine.sub_graphs.len(), 2);
            let graphs = engine.sub_graphs.values().collect::<Vec<_>>();
            let mut expected = right_paths.clone();
            expected.push(sum);
            assert_iter_eq!(graphs[0].nodes, expected);
            assert_iter_eq!(graphs[1].nodes, left_paths);
        }
    }

    fn add_nodes<'a>(engine: &mut ExecutionEngine, nodes: impl IntoIterator<Item = &'a NodePath>) {
        for node in nodes {
            engine.add_node(node.clone());
        }
    }

    fn link_node(engine: &mut ExecutionEngine, from: &NodePath, to: &NodePath) {
        engine
            .link_node(NodeLink {
                source: from.clone(),
                source_port: "Value".into(),
                target: to.clone(),
                target_port: "Value".into(),
                port_type: PortType::Single,
                local: true,
            })
            .unwrap();
    }

    fn remove_link(engine: &mut ExecutionEngine, from: &NodePath, to: &NodePath) {
        engine.remove_link(&NodeLink {
            source: from.clone(),
            source_port: "Value".into(),
            target: to.clone(),
            target_port: "Value".into(),
            port_type: PortType::Single,
            local: true,
        });
    }

    proptest! {
        #[test]
        fn remove_node_should_remove_it_from_execution_order(path in arb_node_path()) {
            let mut engine = ExecutionEngine::default();
            engine.add_node(path.clone());

            engine.remove_node(&path);

            let order = engine.get_execution_order().collect::<Vec<_>>();
            assert_is_empty!(order);
        }
    }

    prop_compose! {
        fn arb_node_path()(path: String) -> NodePath {
            NodePath::from(path)
        }
    }
}
