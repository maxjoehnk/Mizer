use std::collections::HashMap;

use mizer_api::RuntimeApi;
use mizer_clock::{ClockSnapshot, ClockState};
use mizer_connections::Connection;
use mizer_layouts::{ControlConfig, ControlPosition, ControlSize, Layout};
use mizer_node::{NodeDesigner, NodeLink, NodePath, NodePosition, NodeType, PortId};
use mizer_nodes::{FixtureNode, Node, SequencerNode};
use mizer_runtime::{DefaultRuntime, NodeDescriptor, RuntimeAccess};

use crate::{ApiCommand, ApiHandler};
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

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
        self.update_layout(id, |layout| {
            layout.id = name;
        });
    }

    fn add_layout_control(
        &self,
        layout_id: String,
        path: NodePath,
        position: ControlPosition,
        size: ControlSize,
    ) {
        log::debug!(
            "add_layout_control {} {:?} {:?} {:?}",
            layout_id,
            path,
            position,
            size
        );
        self.update_layout(layout_id, |layout| {
            layout.controls.push(ControlConfig {
                node: path,
                label: None,
                position,
                size,
                decoration: Default::default(),
            });
        });
    }

    fn delete_layout_control(&self, layout_id: String, control_id: String) {
        self.update_layout(layout_id, |layout| {
            if let Some(index) = layout
                .controls
                .iter()
                .position(|control| control.node == control_id)
            {
                layout.controls.remove(index);
            }
        });
    }

    fn update_layout_control<F: FnOnce(&mut ControlConfig)>(
        &self,
        layout_id: String,
        control_id: String,
        update: F,
    ) {
        self.update_layout(layout_id, |layout| {
            if let Some(control) = layout
                .controls
                .iter_mut()
                .find(|control| control.node == control_id)
            {
                update(control);
            }
        });
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
            NodeDesigner {
                hidden: true,
                ..Default::default()
            },
            Some(node.into()),
        )
    }

    fn add_node_for_sequence(&self, sequence_id: u32) -> anyhow::Result<NodeDescriptor<'_>> {
        let node = SequencerNode {
            sequence_id,
            ..Default::default()
        };
        self.add_node_internal(
            NodeType::Sequencer,
            NodeDesigner {
                hidden: true,
                ..Default::default()
            },
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

    fn get_node_history_ref(
        &self,
        node: NodePath,
    ) -> anyhow::Result<Option<Arc<NonEmptyPinboard<Vec<f64>>>>> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetNodePreviewRef(node, tx))?;

        let value = rx.recv()?;

        Ok(value)
    }

    fn get_node(&self, path: &NodePath) -> Option<NodeDescriptor> {
        let designer = self.access.designer.read();
        self.access
            .nodes
            .iter()
            .map(|entry| entry.key().clone())
            .find(|node_path| node_path == path)
            .map(|path| self.get_descriptor(path, &designer))
    }

    fn update_node(&self, path: NodePath, config: Node) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::UpdateNode(path, config, tx))?;

        rx.recv()?
    }

    fn update_node_position(&self, path: NodePath, position: NodePosition) -> anyhow::Result<()> {
        let mut nodes = self.access.designer.read();
        if let Some(designer) = nodes.get_mut(&path) {
            designer.position = position;
        } // TODO: else return err?
        self.access.designer.set(nodes);

        Ok(())
    }

    fn delete_node(&self, path: NodePath) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::DeleteNode(path, tx))?;
        rx.recv()?;

        Ok(())
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

    fn get_clock_snapshot_ref(&self) -> Arc<NonEmptyPinboard<ClockSnapshot>> {
        self.access.clock_snapshot.clone()
    }

    fn get_connections(&self) -> Vec<Connection> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::GetConnections(tx)).unwrap();

        rx.recv().unwrap()
    }

    fn add_sacn_connection(&self, name: String) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender.send(ApiCommand::AddSacnConnection(name, tx))?;

        rx.recv()?
    }

    fn add_artnet_connection(
        &self,
        name: String,
        host: String,
        port: Option<u16>,
    ) -> anyhow::Result<()> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::AddArtnetConnection(name, (host, port), tx))?;

        rx.recv()?
    }

    fn get_dmx_monitor(&self, output_id: String) -> anyhow::Result<HashMap<u16, [u8; 512]>> {
        let (tx, rx) = flume::bounded(1);
        self.sender
            .send(ApiCommand::GetDmxMonitor(output_id, tx))
            .unwrap();

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

    fn update_layout<Cb: FnOnce(&mut Layout)>(&self, layout_id: String, update: Cb) {
        let mut layouts = self.access.layouts.read();
        if let Some(layout) = layouts.iter_mut().find(|layout| layout.id == layout_id) {
            update(layout);
        }
        self.access.layouts.set(layouts);
    }
}
