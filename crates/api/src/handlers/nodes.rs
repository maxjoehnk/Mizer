use std::fmt::Debug;

use mizer_command_executor::*;
use mizer_docs::{get_node_description, list_node_settings};
use mizer_node::{NodePath, NodeType, PortId};
use mizer_nodes::{ContainerNode, NodeDowncast};
use mizer_runtime::{NodeMetadataRef, NodePreviewRef};

use crate::mappings::nodes::map_node_descriptor_with_config;
use crate::proto::nodes::*;
use crate::RuntimeApi;

#[derive(Clone)]
pub struct NodesHandler<R: RuntimeApi> {
    runtime: R,
}

impl<R: RuntimeApi> NodesHandler<R> {
    pub fn new(runtime: R) -> Self {
        Self { runtime }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_nodes(&self) -> Nodes {
        let mut res = Nodes::default();

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
                r#type: Some(node_config::Type::ContainerConfig(config)),
            };
            let node = map_node_descriptor_with_config(node, config);
            res.nodes.push(node);
        }
        for channel in self.runtime.links() {
            res.channels.push(NodeConnection {
                source_node: channel.source.to_string(),
                source_port: Some(Port {
                    protocol: ChannelProtocol::from(channel.port_type) as i32,
                    name: channel.source_port.to_string(),
                    multiple: false,
                }),
                target_node: channel.target.to_string(),
                target_port: Some(Port {
                    protocol: ChannelProtocol::from(channel.port_type) as i32,
                    name: channel.target_port.to_string(),
                    multiple: false,
                }),
                protocol: ChannelProtocol::from(channel.port_type) as i32,
            });
        }

        res
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_available_nodes(&self) -> AvailableNodes {
        let node_types = enum_iterator::all::<NodeType>();
        let nodes = node_types
            .into_iter()
            .filter(|node_type| node_type != &NodeType::TestSink)
            .map(|node_type| {
                let node: mizer_nodes::Node = node_type.into();
                let details = node.details();
                let node_type_name = node_type.get_name();
                let description = get_node_description(&node_type_name)
                    .map(|desc| desc.to_string())
                    .unwrap_or_default();
                let settings = list_node_settings(&node_type_name)
                    .map(|settings| {
                        settings
                            .map(|(setting, description)| NodeSettingDescription {
                                name: setting.to_string(),
                                description: description.to_string(),
                            })
                            .collect::<Vec<_>>()
                    })
                    .unwrap_or_default();

                AvailableNode {
                    name: details.node_type_name,
                    category: NodeCategory::from(details.category) as i32,
                    r#type: node_type_name,
                    description,
                    settings,
                }
            })
            .collect();

        AvailableNodes { nodes }
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_node(&self, path: String) -> Option<Node> {
        let node = self.runtime.get_node(&NodePath(path))?;

        Some(node.into())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_node(&self, request: AddNodeRequest) -> Node {
        let position = request.position.as_ref().unwrap();
        let designer = mizer_node::NodeDesigner {
            position: mizer_node::NodePosition {
                x: position.x,
                y: position.y,
            },
            scale: 1.,
            hidden: false,
            color: None,
        };

        let cmd = AddNodeCommand {
            designer,
            node_type: request.r#type.try_into().unwrap(),
            node: None,
            parent: request.parent.map(NodePath::from),
        };
        let descriptor = self.runtime.run_command(cmd).unwrap();

        descriptor.into()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_link(&self, link: NodeConnection) -> anyhow::Result<()> {
        self.runtime
            .run_command(AddLinkCommand { link: link.into() })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn remove_link(&self, link: NodeConnection) -> anyhow::Result<()> {
        self.runtime
            .run_command(RemoveLinkCommand { link: link.into() })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn write_control_value(&self, control: WriteControl) -> anyhow::Result<()> {
        self.runtime
            .write_node_port(control.path.into(), control.port.into(), control.value)?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_node_preview_ref(&self, path: String) -> anyhow::Result<Option<NodePreviewRef>> {
        self.runtime.get_node_preview_ref(path.into())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn get_node_metadata_ref(&self) -> anyhow::Result<NodeMetadataRef> {
        self.runtime.get_node_metadata_ref()
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_node_setting(&self, request: UpdateNodeSettingRequest) -> anyhow::Result<()> {
        self.runtime.run_command(UpdateNodeSettingCommand {
            path: request.path.into(),
            setting: request.setting.unwrap().into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn update_node_color(&self, request: UpdateNodeColorRequest) -> anyhow::Result<()> {
        self.runtime.run_command(UpdateNodeColorCommand {
            path: request.path.into(),
            color: request
                .color
                .and_then(|color| (color as u8).try_into().ok()),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn move_nodes(&self, request: MoveNodesRequest) -> anyhow::Result<()> {
        self.runtime.run_command(MoveNodesCommand {
            movements: request
                .nodes
                .into_iter()
                .map(|request| NodeMovement {
                    path: request.path.into(),
                    position: request.position.unwrap().into(),
                })
                .collect(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn show_node(&self, request: ShowNodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(ShowNodeCommand {
            path: request.path.into(),
            position: request.position.unwrap().into(),
            parent: request.parent.map(NodePath::from),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn rename_node(&self, request: RenameNodeRequest) -> anyhow::Result<()> {
        self.runtime.run_command(RenameNodeCommand {
            path: request.path.into(),
            new_name: request.new_name.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn hide_node(&self, path: NodePath) -> anyhow::Result<()> {
        self.runtime.run_command(HideNodeCommand { path })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn delete_nodes(&self, paths: Vec<NodePath>) -> anyhow::Result<()> {
        self.runtime.run_command(DeleteNodesCommand { paths })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn disconnect_ports(&self, path: NodePath) -> anyhow::Result<()> {
        self.runtime.run_command(DisconnectPortsCommand { path })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn disconnect_port(
        &self,
        path: impl Into<NodePath> + Debug,
        port: impl Into<PortId> + Debug,
    ) -> anyhow::Result<()> {
        self.runtime.run_command(DisconnectPortCommand {
            path: path.into(),
            port: port.into(),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn duplicate_nodes(&self, request: DuplicateNodesRequest) -> anyhow::Result<Vec<NodePath>> {
        let paths = self.runtime.run_command(DuplicateNodesCommand {
            paths: request.paths.into_iter().map(NodePath::from).collect(),
            parent: request.parent.map(NodePath::from),
        })?;

        Ok(paths)
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn group_nodes(&self, request: GroupNodesRequest) -> anyhow::Result<()> {
        self.runtime.run_command(GroupNodesCommand {
            nodes: request.nodes.into_iter().map(NodePath::from).collect(),
            parent: request.parent.map(NodePath::from),
        })?;

        Ok(())
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn open_nodes_view(&self) {
        self.runtime.open_nodes_view();
    }

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn close_nodes_view(&self) {
        self.runtime.close_nodes_view();
    }
}
