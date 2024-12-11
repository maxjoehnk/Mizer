use std::fmt::Debug;
use std::str::FromStr;
use mizer_command_executor::*;
use mizer_docs::get_node_template_description;
use mizer_node::{NodePath, NodeType, PortId};
use mizer_runtime::{NodeMetadataRef, NodePreviewRef};

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

        let nodes = self.runtime.execute_query(ListNodesQuery).unwrap();
        let links = self.runtime.execute_query(ListLinksQuery).unwrap();
        let comments = self.runtime.execute_query(ListCommentsQuery).unwrap();
        res.comments = comments.into_iter().map(Into::into).collect();

        for node in nodes.iter() {
            let node: Node = node.clone().into();
            res.all_nodes.push(node);
        }

        let (container_nodes, non_container_nodes) = nodes
            .into_iter()
            .partition::<Vec<_>, _>(|node| node.node_type == NodeType::Container);

        let (mut child_nodes, standalone_nodes) = non_container_nodes
            .into_iter()
            .partition::<Vec<_>, _>(|node| {
                container_nodes
                    .iter()
                    .any(|n| n.children.contains(&node.path))
            });

        for node in standalone_nodes {
            let node: Node = node.into();
            res.nodes.push(node);
        }
        for node in container_nodes {
            let children = node
                .children
                .iter()
                .filter_map(|path| {
                    child_nodes
                        .iter()
                        .position(|node| &node.path == path)
                        .map(|index| child_nodes.remove(index))
                })
                .map(Node::from)
                .collect();
            let mut node: Node = node.into();
            node.children = children;
            res.nodes.push(node);
        }
        for channel in links {
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
        let nodes = self.runtime.execute_query(ListAvailableNodesQuery).unwrap();
        let nodes = nodes
            .into_iter()
            .map(|node| {
                let description = node
                    .description
                    .map(|desc| desc.to_string())
                    .unwrap_or_default();
                let settings = node
                    .settings
                    .into_iter()
                    .map(|(setting, description)| NodeSettingDescription {
                        name: setting.to_string(),
                        description: description.to_string(),
                    })
                    .collect::<Vec<_>>();

                AvailableNode {
                    name: node.name,
                    category: NodeCategory::from(node.category) as i32,
                    templates: node
                        .templates
                        .into_iter()
                        .map(|template| NodeTemplate {
                            description: get_node_template_description(
                                &node.node_type_name,
                                template.name.as_ref(),
                            )
                            .map(|desc| desc.to_string()),
                            name: template.name.to_string(),
                        })
                        .collect::<Vec<_>>(),
                    r#type: node.node_type_name,
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
        let node = self
            .runtime
            .execute_query(GetNodeQuery {
                path: NodePath(path),
            })
            .unwrap()?;

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
            template: request.template,
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

    #[tracing::instrument(skip(self))]
    #[profiling::function]
    pub fn add_comment(&self, request: AddCommentRequest) -> anyhow::Result<()> {
        let position = request.position.as_ref().unwrap();

        let cmd = AddCommentCommand {
            position: mizer_node::NodePosition {
                x: position.x,
                y: position.y,
            },
            width: request.width,
            height: request.height,
            parent: request.parent.map(NodePath::from),
        };
        self.runtime.run_command(cmd)?;

        Ok(())
    }

    pub fn update_comment(&self, request: UpdateCommentRequest) -> anyhow::Result<()> {
        let cmd = UpdateCommentCommand {
            id: mizer_node::NodeCommentId::from_str(&request.id)?,
            color: request.color.and_then(|color| (color as u8).try_into().ok()),
            label: request.label,
            show_background: request.show_background,
            show_border: request.show_border,
        };
        self.runtime.run_command(cmd)?;

        Ok(())
    }

    pub fn delete_comment(&self, comment_id: mizer_node::NodeCommentId) -> anyhow::Result<()> {
        self.runtime.run_command(DeleteCommentCommand { comment_id })?;

        Ok(())
    }
}
