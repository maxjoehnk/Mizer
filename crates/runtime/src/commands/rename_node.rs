use serde::{Deserialize, Serialize};

use crate::Pipeline;
use mizer_commander::{Command, RefMut};
use mizer_node::NodePath;
use mizer_nodes::{ContainerNode, Node};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RenameNodeCommand {
    pub path: NodePath,
    pub new_name: NodePath,
}

impl<'a> Command<'a> for RenameNodeCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = Vec<(NodePath, Node)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Renaming Node '{}' to '{}'", self.path, self.new_name)
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        pipeline.rename_node(&self.path, self.new_name.clone())?;
        let previous_containers = self.rename_node_in_containers(pipeline)?;

        Ok(((), previous_containers))
    }

    fn revert(
        &self,
        pipeline: &mut Pipeline,
        container_commands: Self::State,
    ) -> anyhow::Result<()> {
        pipeline.rename_node(&self.new_name, self.path.clone())?;
        for (path, container) in container_commands {
            pipeline.update_node(&path, container)?;
        }

        Ok(())
    }
}

impl RenameNodeCommand {
    fn rename_node_in_containers(
        &self,
        pipeline: &mut Pipeline,
    ) -> anyhow::Result<Vec<(NodePath, Node)>> {
        let mut update_node_commands = Vec::new();
        for (path, container) in
            pipeline.find_nodes::<ContainerNode>(|node| node.nodes.contains(&self.path))
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
}
