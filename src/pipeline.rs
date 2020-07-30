use crate::nodes::Node;
use mizer_node_api::*;

#[derive(Debug, Default)]
pub struct Pipeline<'a> {
    nodes: Vec<Node<'a>>,
}

impl<'a> Pipeline<'a> {
    pub fn add_node<N: Into<Node<'a>>>(&mut self, node: N) {
        self.nodes.push(node.into());
    }

    pub fn process(&mut self) {
        for node in self.nodes.iter_mut() {
            node.process();
        }
    }
}
