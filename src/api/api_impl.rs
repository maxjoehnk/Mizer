use crate::{ApiCommand, ApiHandler};
use mizer_api::RuntimeApi;
use mizer_clock::{ClockSnapshot, ClockState};
use mizer_layouts::{ControlConfig, Layout};
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodeType, PortId};
use mizer_nodes::{FixtureNode, Node};
use mizer_runtime::{DefaultRuntime, NodeDescriptor, RuntimeAccess};
use std::collections::HashMap;
use mizer_connections::Connection;

#[derive(Clone)]
pub struct Api {
    access: RuntimeAccess,
    sender: flume::Sender<ApiCommand>,
}

impl RuntimeApi for Api {
    fn nodes(&self) -> Vec<NodeDescriptor> {
        let designer = self.access.designer.read();
        self.access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .map(|path| self.get_descriptor(path, &designer))
            .collect()
    }

    fn links(&self) -> Vec<NodeLink> {
        self.access.links.read()
    }

    fn layouts(&self) -> Vec<Layout> {
        self.access.layouts.read()
    }

    fn add_layout(&self, name: String) {
        let mut layouts = self.access.layouts.read();
        layouts.push(Layout {
            id: name,
            controls: Default::default(),
        });
        self.access.layouts.set(layouts);
    }

    fn remove_layout(&self, id: String) {
        let mut layouts = self.access.layouts.read();
        layouts.retain(|layout| layout.id != id);
        self.access.layouts.set(layouts);
    }

    fn rename_layout(&self, id: String, name: String) {
        let mut layouts = self.access.layouts.read();
        if let Some(layout) = layouts.iter_mut().find(|layout| layout.id == id) {
            layout.id = name;
        }
        self.access.layouts.set(layouts);
    }

    fn delete_layout_control(&self, layout_id: String, control_id: String) {
        let mut layouts = self.access.layouts.read();
        if let Some(layout) = layouts.iter_mut().find(|layout| layout.id == layout_id) {
            if let Some(index) = layout
                .controls
                .iter()
                .position(|control| control.node == control_id)
            {
                layout.controls.remove(index);
            }
        }
        self.access.layouts.set(layouts);
    }

    fn update_layout_control<F: FnOnce(&mut ControlConfig)>(
        &self,
        layout_id: String,
        control_id: String,
        update: F,
    ) {
        let mut layouts = self.access.layouts.read();
        if let Some(layout) = layouts.iter_mut().find(|layout| layout.id == layout_id) {
            if let Some(control) = layout
                .controls
                .iter_mut()
                .find(|control| control.node == control_id)
            {
                update(control);
            }
        }
        self.access.layouts.set(layouts);
    }

    fn add_node(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
    ) -> anyhow::Result<NodeDescriptor<'_>> {
        self.add_node_internal(node_type, designer, None)
    }

    fn add_node_for_fixture(&self, fixture_id: u32) -> anyhow::Result<NodeDescriptor<'_>> {
        let node = FixtureNode {
            fixture_id,
            ..Default::default()
        };
        self.add_node_internal(
            NodeType::Fixture,
            NodeDesigner::default(),
            Some(node.into()),
        )
    }

    fn write_node_port(&self, node_path: NodePath, port: PortId, value: f64) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::WritePort(node_path, port, value, tx))?;

        rx.recv()?
    }

    fn link_nodes(&self, link: NodeLink) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::AddLink(link, tx))?;

        rx.recv()?
    }

    fn get_node_history(&self, node: NodePath) -> anyhow::Result<Vec<f64>> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetNodePreview(node, tx))?;

        rx.recv()?
    }

    fn update_node(&self, path: NodePath, config: Node) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::UpdateNode(path, config, tx))?;

        rx.recv()?
    }

    fn set_clock_state(&self, state: ClockState) -> anyhow::Result<()> {
        self.sender.send(ApiCommand::SetClockState(state))?;

        Ok(())
    }

    fn new_project(&self) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::NewProject(tx))?;

        rx.recv()?
    }

    fn save_project(&self) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::SaveProject(tx))?;

        rx.recv()?
    }

    fn load_project(&self, path: String) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::LoadProject(path, tx))?;

        rx.recv()?
    }

    fn transport_recv(&self) -> flume::Receiver<ClockSnapshot> {
        self.access.clock_recv.clone()
    }

    fn get_connections(&self) -> Vec<Connection> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetConnections(tx)).unwrap();

        rx.recv().unwrap()
    }
}

impl Api {
    pub fn setup(runtime: &DefaultRuntime) -> (ApiHandler, Api) {
        let (tx, rx) = flume::unbounded();
        let access = runtime.access();

        (ApiHandler { recv: rx }, Api { sender: tx, access })
    }

    fn add_node_internal(
        &self,
        node_type: NodeType,
        designer: NodeDesigner,
        node: Option<Node>,
    ) -> anyhow::Result<NodeDescriptor<'_>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::AddNode(node_type, designer.clone(), node, tx))?;

        // TODO: this blocks, we should use the async method
        let path = rx.recv()??;
        let node = self.access.nodes.get(&path).unwrap();
        let ports = node.list_ports();

        Ok(NodeDescriptor {
            path,
            node,
            designer,
            ports,
        })
    }

    fn get_descriptor(
        &self,
        path: NodePath,
        designer: &HashMap<NodePath, NodeDesigner>,
    ) -> NodeDescriptor {
        let node = self.access.nodes.get(&path).unwrap();
        let ports = node.list_ports();
        let designer = designer[&path].clone();

        NodeDescriptor {
            path,
            node,
            designer,
            ports,
        }
    }
}
