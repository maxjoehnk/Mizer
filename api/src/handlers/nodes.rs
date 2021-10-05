use crate::models::*;
use crate::RuntimeApi;
use mizer_node::NodePath;
use pinboard::NonEmptyPinboard;
use std::sync::Arc;

#[derive(Clone)]
pub struct NodesHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> NodesHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    pub fn get_nodes(&self) -> Nodes {
        let mut res = Nodes::new();

        let nodes = self.runtime.nodes();

        for node in nodes {
            let node: Node = node.into();
            res.nodes.push(node);
        }
        for channel in self.runtime.links() {
            let mut conn = NodeConnection {
                sourceNode: channel.source.to_string(),
                targetNode: channel.target.to_string(),
                protocol: channel.port_type.into(),
                ..Default::default()
            };
            let source_port = Port {
                protocol: channel.port_type.into(),
                name: channel.source_port.to_string(),
                ..Default::default()
            };
            conn.set_sourcePort(source_port);
            let target_port = Port {
                protocol: channel.port_type.into(),
                name: channel.target_port.to_string(),
                ..Default::default()
            };
            conn.set_targetPort(target_port);
            res.channels.push(conn);
        }

        res
    }

    pub fn add_node(&self, request: AddNodeRequest) -> Node {
        let position = request.position.unwrap();
        let designer = mizer_node::NodeDesigner {
            position: mizer_node::NodePosition {
                x: position.x,
                y: position.y,
            },
            scale: 1.,
            hidden: false,
        };

        let node = self
            .runtime
            .add_node(request.field_type.into(), designer)
            .unwrap();

        node.into()
    }

    pub fn add_link(&self, link: NodeConnection) -> anyhow::Result<()> {
        self.runtime.link_nodes(link.into())?;

        Ok(())
    }

    pub fn write_control_value(&self, control: WriteControl) -> anyhow::Result<()> {
        self.runtime
            .write_node_port(control.path.into(), control.port.into(), control.value)?;

        Ok(())
    }

    pub fn get_node_history_ref(&self, path: String) -> anyhow::Result<Option<Arc<NonEmptyPinboard<Vec<f64>>>>> {
        self.runtime.get_node_history_ref(path.into())
    }

    pub fn update_node_property(&self, request: UpdateNodeConfigRequest) -> anyhow::Result<()> {
        self.runtime.update_node(
            request.path.into(),
            request.config.unwrap().field_type.unwrap().into(),
        )?;

        Ok(())
    }

    pub fn move_node(&self, request: MoveNodeRequest) -> anyhow::Result<()> {
        self.runtime.update_node_position(
            request.path.into(),
            request.position.unwrap().into(),
        )?;

        Ok(())
    }

    pub fn delete_node(&self, path: NodePath) -> anyhow::Result<()> {
        self.runtime.delete_node(path)
    }
}
