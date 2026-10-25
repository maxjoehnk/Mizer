use indexmap::{IndexMap, IndexSet};
use mizer_node::{NodeLink, NodePath};
use mizer_util::HashMapExtension;

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
}

impl SubGraph {
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
    fn sort(&mut self) {
        let mut edges = self.links.clone();

        let mut l = Vec::with_capacity(self.nodes.len());
        let mut s = self.get_nodes_without_inputs();

        while !s.is_empty() {
            let n = s.pop().unwrap();

            let outgoing_edges = edges.iter().filter(|e| e.source == n).cloned().collect::<Vec<_>>();
            for edge in outgoing_edges {
                edges.shift_remove(&edge);
            }
            // links.

            l.push(n);
        }

        if !edges.is_empty() {
            panic!("Graph has cycles")
        }
        for (i, node) in l.into_iter().enumerate() {
            self.nodes.shift_insert(i, node);
        }
    }

    fn get_nodes_without_inputs(&mut self) -> Vec<NodePath> {
        todo!()
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

    pub fn link_node(&mut self, link: NodeLink) -> anyhow::Result<()> {
        let source = *self.node_graphs.get(&link.source).ok_or_else(|| anyhow::anyhow!("Missing source {}", link.source))?;
        let target = *self.node_graphs.get(&link.target).ok_or_else(|| anyhow::anyhow!("Missing target {}", link.target))?;

        if source != target {
            if let Some(source_graph) = self.sub_graphs.get_mut(&source) {
                source_graph.nodes.insert(link.target.clone());
                self.node_graphs.insert(link.target.clone(), source);
            }

            if let Some(target_graph) = self.sub_graphs.get_mut(&target) {
                target_graph.nodes.shift_remove(&link.target);
            }
        }

        if let Some(graph) = self.sub_graphs.get_mut(&source) {
            graph.links.insert(link);
            graph.sort();
        }

        self.clear_empty_graphs();

        Ok(())
    }

    pub fn get_execution_order(&self) -> impl Iterator<Item = &NodePath> {
        self.sub_graphs.iter()
            .flat_map(|(_, graph)| graph.nodes.iter())
    }

    pub fn rename_node(&mut self, from: &NodePath, to: NodePath) -> anyhow::Result<()> {
        if let Some(id) = self.node_graphs.get(from) {
            if let Some(nodes) = self.sub_graphs.get_mut(id) {
                if let Some(index) = nodes.nodes.get_index_of(from) {
                    nodes.nodes.replace_index(index, to.clone()).map_err(|(index, value)| anyhow::anyhow!("new name already exists at index {index}"))?;
                }
            }
        }
        self.node_graphs.rename_key(from, to);

        Ok(())
    }

    pub fn remove_link(&mut self, link: &NodeLink) {

    }

    fn clear_empty_graphs(&mut self) {
        let to_remove = self.sub_graphs.iter().filter(|(_, g)| g.nodes.is_empty()).map(|(id, _)| *id).collect::<Vec<_>>();
        for id in to_remove {
            self.sub_graphs.shift_remove(&id);
        }
    }
}

#[cfg(test)]
mod tests {
    use mizer_ports::PortType;
    use super::*;
    use test_case::test_case;
    use assertables::*;
    use proptest::prelude::*;

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
        engine.add_node(source.clone());
        engine.add_node(sink.clone());

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
        engine.add_node(source.clone());
        engine.add_node(sink.clone());

        let nodes = engine.get_execution_order().collect::<Vec<_>>();

        assert_iter_eq!(nodes, vec![&source, &sink]);
    }

    proptest! {
        #[test]
        fn get_execution_order_should_return_related_nodes_in_dependency_order(count in 2..50) {
            let paths = (0..count).map(|i| NodePath::from(format!("/node-{i}"))).collect::<Vec<_>>();
            let mut engine = ExecutionEngine::default();
            for path in &paths {
                engine.add_node(path.clone());
            }
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
            for path in &paths {
                engine.add_node(path.clone());
            }
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
        engine.add_node(sink.clone());
        engine.add_node(left.clone());
        engine.add_node(right.clone());
        engine.add_node(source.clone());
        link_node(&mut engine, &source, &left);
        link_node(&mut engine, &source, &right);
        link_node(&mut engine, &left, &sink);
        link_node(&mut engine, &right, &sink);

        let nodes = engine.get_execution_order().collect::<Vec<_>>();

        assert_iter_eq!(nodes, vec![&source, &left, &right, &sink]);
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
        assert_iter_eq!(order, vec![&after]);
    }

    fn link_node(engine: &mut ExecutionEngine, from: &NodePath, to: &NodePath) {
        engine.link_node(NodeLink {
            source: from.clone(),
            source_port: "Value".into(),
            target: to.clone(),
            target_port: "Value".into(),
            port_type: PortType::Single,
            local: true,
        }).unwrap();
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
