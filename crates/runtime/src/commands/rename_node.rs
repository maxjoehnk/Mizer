use serde::{Deserialize, Serialize};

use crate::Pipeline;
use mizer_commander::{Command, Ref, RefMut};
use mizer_layouts::{Layout, LayoutStorage};
use mizer_node::NodePath;
use mizer_nodes::{ContainerNode, Node};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RenameNodeCommand {
    pub path: NodePath,
    pub new_name: NodePath,
}

impl<'a> Command<'a> for RenameNodeCommand {
    type Dependencies = (RefMut<Pipeline>, Ref<LayoutStorage>);
    type State = (Vec<(NodePath, Node)>, Vec<(NodePath, NodePath)>);
    type Result = ();

    fn label(&self) -> String {
        format!("Renaming Node '{}' to '{}'", self.path, self.new_name)
    }

    fn apply(
        &self,
        (pipeline, layout_storage): (&mut Pipeline, &LayoutStorage),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        pipeline.rename_node(&self.path, self.new_name.clone())?;
        let mut layouts = layout_storage.read();
        let renamed_children = self.rename_container_children(&mut layouts, pipeline)?;
        let previous_containers = self.rename_node_in_containers(pipeline)?;
        self.rename_node_in_layouts(&mut layouts, &self.path, &self.new_name);
        layout_storage.set(layouts);

        Ok(((), (previous_containers, renamed_children)))
    }

    fn revert(
        &self,
        (pipeline, layout_storage): (&mut Pipeline, &LayoutStorage),
        (container_commands, renamed_children): Self::State,
    ) -> anyhow::Result<()> {
        pipeline.rename_node(&self.new_name, self.path.clone())?;
        let mut layouts = layout_storage.read();
        for (path, container) in container_commands {
            pipeline.update_node(&path, container)?;
        }
        self.rename_node_in_layouts(&mut layouts, &self.new_name, &self.path);
        self.update_container_children(pipeline, &self.path, renamed_children.iter().map(|(path, _)| path.clone()).collect());
        for (old_path, new_path) in renamed_children {
            self.rename_node_in_layouts(&mut layouts, &new_path, &old_path);
            pipeline.rename_node(&new_path, old_path)?;
        }
        layout_storage.set(layouts);

        Ok(())
    }
}

impl RenameNodeCommand {
    fn rename_node_in_layouts(
        &self,
        layouts: &mut Vec<Layout>,
        from: &NodePath,
        to: &NodePath,
    ) {
        for layout in layouts {
            for control in &mut layout.controls {
                if let mizer_layouts::ControlType::Node { path } = &mut control.control_type {
                    if path == from {
                        *path = to.clone();
                    }
                }
            }
        }
    }

    /// Update the reference to the renamed node in the parent container
    fn rename_node_in_containers(
        &self,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<Vec<(NodePath, Node)>> {
        let mut update_node_commands = Vec::new();
        for (path, container) in
            pipeline.find_nodes::<ContainerNode>(|_path, node| node.nodes.contains(&self.path))
        {
            let new_config = ContainerNode {
                nodes: container
                    .nodes
                    .iter()
                    .map(|p| {
                        if p == &self.path {
                            self.new_name.clone()
                        } else {
                            p.clone()
                        }
                    })
                    .collect(),
            };
            update_node_commands.push((path.clone(), new_config));
        }

        update_node_commands
            .into_iter()
            .map(|(path, node)| {
                let previous = pipeline.update_node(&path, node.into());

                previous.map(|previous| (path, previous))
            })
            .collect()
    }

    /// Renames all children of a container to now have the updated prefix
    fn rename_container_children(
        &self,
        layouts: &mut Vec<Layout>,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<Vec<(NodePath, NodePath)>> {
        let Some(container) = pipeline.get_node::<ContainerNode>(&self.new_name) else {
            return Ok(Default::default());
        };
        let paths = container.nodes.clone();
        let mut renamed_paths = Vec::new();
        for path in paths {
            if path.starts_with(&self.path) {
                let new_path = path.replace_prefix(&self.path, &self.new_name);
                pipeline.rename_node(&path, new_path.clone())?;
                self.rename_node_in_layouts(layouts, &path, &new_path);
                renamed_paths.push((path, new_path));
            }
        }
        self.update_container_children(pipeline, &self.new_name, renamed_paths.iter().map(|(_, path)| path.clone()).collect());

        Ok(renamed_paths)
    }

    fn update_container_children(&self, pipeline: &mut Pipeline, container: &NodePath, children: Vec<NodePath>) {
        if let Some(container) = pipeline.get_node_mut::<ContainerNode>(&container) {
            container.nodes = children;
        }
    }
}
