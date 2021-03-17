use dashmap::mapref::one::Ref;
use dashmap::DashMap;
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PipelineNode, PortId, PortMetadata};
use mizer_layouts::Layout;
use pinboard::NonEmptyPinboard;
use std::collections::HashMap;
use std::sync::Arc;

#[derive(Clone)]
pub struct RuntimeApi {
    pub(crate) nodes: Arc<DashMap<NodePath, Box<dyn PipelineNode>>>,
    pub(crate) designer: Arc<NonEmptyPinboard<HashMap<NodePath, NodeDesigner>>>,
    pub(crate) links: Arc<NonEmptyPinboard<Vec<NodeLink>>>,
    pub(crate) layouts: Arc<NonEmptyPinboard<Vec<Layout>>>,
    pub(crate) sender: flume::Sender<ApiCommand>,
}

#[derive(Debug, Clone)]
pub enum ApiCommand {
    AddNode(NodeType, NodeDesigner, flume::Sender<anyhow::Result<NodePath>>),
    AddLink(NodeLink, flume::Sender<anyhow::Result<()>>),
    WritePort(NodePath, PortId, f64, flume::Sender<anyhow::Result<()>>),
}

impl RuntimeApi {
    pub fn nodes(&self) -> Vec<NodeDescriptor> {
        let designer = self.designer.read();
        self.nodes
            .iter()
            .map(|entry| entry.key().clone())
            .map(|path| {
                let node = self.nodes.get(&path).unwrap();
                let ports = node.list_ports();
                let designer = designer[&path].clone();

                NodeDescriptor {
                    path,
                    node,
                    designer,
                    ports,
                }
            })
            .collect()
    }

    pub fn links(&self) -> Vec<NodeLink> {
        self.links.read()
    }

    pub fn layouts(&self) -> Vec<Layout> {
        self.layouts.read()
    }

    pub fn add_node(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
    ) -> anyhow::Result<NodeDescriptor<'_>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::AddNode(node_type, designer.clone(), tx))?;

        // TODO: this blocks, we should use the async method
        let path = rx.recv()??;
        let node = self.nodes.get(&path).unwrap();
        let ports = node.list_ports();

        Ok(NodeDescriptor {
            path,
            designer,
            node,
            ports,
        })
    }

    pub fn write_node_port(
        &self,
        node_path: NodePath,
        port: PortId,
        value: f64,
    ) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::WritePort(node_path, port, value, tx))?;
        let result = rx.recv()?;

        result
    }

    pub fn link_nodes(&self, link: NodeLink) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::AddLink(link, tx))?;
        let result = rx.recv()?;

        result
    }
}

pub struct NodeDescriptor<'a> {
    pub path: NodePath,
    pub node: Ref<'a, NodePath, Box<dyn PipelineNode>>,
    pub designer: NodeDesigner,
    pub ports: Vec<(PortId, PortMetadata)>,
}

impl<'a> NodeDescriptor<'a> {
    pub fn node_type(&self) -> NodeType {
        self.node.node_type()
    }
}
