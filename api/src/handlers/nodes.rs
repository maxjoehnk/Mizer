use mizer_runtime::RuntimeApi;
use crate::models::*;

#[derive(Clone)]
pub struct NodesHandler {
    runtime: RuntimeApi,
}

impl NodesHandler {
    pub fn new(runtime: RuntimeApi) -> Self {
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
                ..Default::default()
            };
            let source_port = Port {
                protocol: ChannelProtocol::Single,
                name: channel.source_port.to_string(),
                ..Default::default()
            };
            conn.set_sourcePort(source_port);
            let target_port = Port {
                protocol: ChannelProtocol::Single,
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
        self.runtime.write_node_port(control.path.into(), control.port.into(), control.value)?;

        Ok(())
    }
}
