use crate::mappings::nodes::map_node_descriptor_with_config;
use crate::models::nodes::*;
use crate::RuntimeApi;
use mizer_command_executor::*;
use mizer_node::{NodePath, NodePreviewRef, NodeType};
use mizer_nodes::{ContainerNode, NodeDowncast};
use mizer_runtime::NodeMetadataRef;
use protobuf::{EnumOrUnknown, MessageField};

#[derive(Clone)]
pub struct NodesHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> NodesHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    pub fn get_nodes(&self) -> Nodes {
        let mut res = Nodes::new();

        for node in self.runtime.nodes() {
            let node: Node = node.into();
            res.all_nodes.push(node);
        }

        let nodes = self.runtime.nodes();

        let (container_nodes, non_container_nodes) = nodes
            .into_iter()
            .partition::<Vec<_>, _>(|node| node.node_type() == NodeType::Container);
        let container_nodes = container_nodes
            .into_iter()
            .map(|node| {
                node.downcast_node::<ContainerNode>(NodeType::Container)
                    .map(|c| (c, node))
                    .unwrap()
            })
            .collect::<Vec<_>>();

        let (mut child_nodes, standalone_nodes) = non_container_nodes
            .into_iter()
            .partition::<Vec<_>, _>(|node| {
                container_nodes
                    .iter()
                    .any(|(c, _)| c.nodes.contains(&node.path))
            });

        for node in standalone_nodes {
            let node: Node = node.into();
            res.nodes.push(node);
        }
        for (container_node, node) in container_nodes {
            let children = container_node
                .nodes
                .into_iter()
                .filter_map(|path| {
                    child_nodes
                        .iter()
                        .position(|node| node.path == path)
                        .map(|index| child_nodes.remove(index))
                })
                .map(Node::from)
                .collect();
            let config = ContainerNodeConfig {
                nodes: children,
                ..Default::default()
            };
            let config = NodeConfig {
                type_: Some(node_config::Type::ContainerConfig(config)),
                ..Default::default()
            };
            let node = map_node_descriptor_with_config(node, config);
            res.nodes.push(node);
        }
        for channel in self.runtime.links() {
            res.channels.push(NodeConnection {
                source_node: channel.source.to_string(),
                source_port: MessageField::some(Port {
                    protocol: EnumOrUnknown::new(channel.port_type.into()),
                    name: channel.source_port.to_string(),
                    ..Default::default()
                }),
                target_node: channel.target.to_string(),
                target_port: MessageField::some(Port {
                    protocol: EnumOrUnknown::new(channel.port_type.into()),
                    name: channel.target_port.to_string(),
                    ..Default::default()
                }),
                protocol: EnumOrUnknown::new(channel.port_type.into()),
                ..Default::default()
            });
        }

        res
    }

    #[tracing::instrument(skip(self))]
    pub fn get_node(&self, path: String) -> Option<Node> {
        let node = self.runtime.get_node(&NodePath(path))?;

        Some(node.into())
    }

    #[tracing::instrument(skip(self))]
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

        let cmd = AddNodeCommand {
            designer,
            node_type: request.type_.unwrap().into(),
            node: None,
            parent: request.parent.map(NodePath::from),
        };
        let descriptor = self.runtime.run_command(cmd).unwrap();

        descriptor.into()
    }

    #[tracing::instrument(skip(self))]
    pub fn add_link(&self, link: NodeConnection) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddLinkCommand { link: link.into() })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn remove_link(&self, link: NodeConnection) -> anyhow::Result<()> {
        self.runtime
            .run_command(RemoveLinkCommand { link: link.into() })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn write_control_value(&self, control: WriteControl) -> anyhow::Result<()> {
        self.runtime
            .write_node_port(control.path.into(), control.port.into(), control.value)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn get_node_preview_ref(&self, path: String) -> anyhow::Result<Option<NodePreviewRef>> {
        self.runtime.get_node_preview_ref(path.into())
    }

    #[tracing::instrument(skip(self))]
    pub fn get_node_metadata_ref(&self) -> anyhow::Result<NodeMetadataRef> {
        self.runtime.get_node_metadata_ref()
    }

    #[tracing::instrument(skip(self))]
    pub fn update_node_property(&self, request: UpdateNodeConfigRequest) -> anyhow::Result<()> {
        self.runtime.run_command(UpdateNodeCommand {
            path: request.path.into(),
            config: request.config.unwrap().type_.unwrap().into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn move_node(&self, request: MoveNodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(MoveNodeCommand {
            path: request.path.into(),
            position: request.position.unwrap().into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn show_node(&self, request: ShowNodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(ShowNodeCommand {
            path: request.path.into(),
            position: request.position.unwrap().into(),
            parent: request.parent.map(NodePath::from),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn rename_node(&self, request: RenameNodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(RenameNodeCommand {
            path: request.path.into(),
            new_name: request.new_name.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn hide_node(&self, path: NodePath) -> anyhow::Result<()> {
        self.runtime.run_command(HideNodeCommand { path })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn delete_node(&self, path: NodePath) -> anyhow::Result<()> {
        self.runtime.run_command(DeleteNodeCommand { path })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn disconnect_ports(&self, path: NodePath) -> anyhow::Result<()> {
        self.runtime.run_command(DisconnectPortsCommand { path })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn duplicate_node(&self, request: DuplicateNodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(DuplicateNodeCommand {
            path: request.path.into(),
            parent: request.parent.map(NodePath::from),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    pub fn group_nodes(&self, request: GroupNodesRequest) -> anyhow::Result<()> {
        self.runtime.run_command(GroupNodesCommand {
            nodes: request.nodes.into_iter().map(NodePath::from).collect(),
            parent: request.parent.map(NodePath::from),
        })?;

        Ok(())
    }
}
