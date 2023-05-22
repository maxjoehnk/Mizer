use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_execution_planner::ExecutionPlanner;
use mizer_node::{NodePath, NodeType};
use mizer_nodes::{ContainerNode, Node, NodeDowncast};
use mizer_util::HashMapExtension;

use crate::pipeline_access::PipelineAccess;

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RenameNodeCommand {
    pub path: NodePath,
    pub new_name: NodePath,
}

impl<'a> Command<'a> for RenameNodeCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = Vec<(NodePath, Node)>;
    type Result = ();

    fn label(&self) -> String {
        format!("Renaming Node '{}' to '{}'", self.path, self.new_name)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        rename_designer_nodes(pipeline, &self.path, &self.new_name)?;
        rename_nodes(pipeline, &self.path, &self.new_name)?;
        rename_nodes_view(pipeline, &self.path, &self.new_name)?;
        rename_links(pipeline, &self.path, &self.new_name)?;
        planner.rename_node(&self.path, self.new_name.clone());
        let previous_containers = self.rename_node_in_containers(pipeline)?;

        Ok(((), previous_containers))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        container_commands: Self::State,
    ) -> anyhow::Result<()> {
        rename_designer_nodes(pipeline, &self.new_name, &self.path)?;
        rename_nodes(pipeline, &self.new_name, &self.path)?;
        rename_nodes_view(pipeline, &self.new_name, &self.path)?;
        rename_links(pipeline, &self.new_name, &self.path)?;
        planner.rename_node(&self.new_name, self.path.clone());
        for (path, container) in container_commands {
            pipeline.apply_node_config(&path, container)?;
        }

        Ok(())
    }
}

fn rename_designer_nodes(
    pipeline: &mut PipelineAccess,
    from: &NodePath,
    to: &NodePath,
) -> anyhow::Result<()> {
    let mut nodes = pipeline.designer.read();
    nodes
        .rename_key(from, to.clone())
        .then_some(())
        .ok_or_else(|| anyhow::anyhow!("Unknown node {}", from))?;
    pipeline.designer.set(nodes);

    Ok(())
}

fn rename_nodes(
    pipeline: &mut PipelineAccess,
    from: &NodePath,
    to: &NodePath,
) -> anyhow::Result<()> {
    pipeline
        .nodes
        .rename_key(from, to.clone())
        .then_some(())
        .ok_or_else(|| anyhow::anyhow!("Unknown node {}", from))?;

    Ok(())
}

fn rename_nodes_view(
    pipeline: &mut PipelineAccess,
    from: &NodePath,
    to: &NodePath,
) -> anyhow::Result<()> {
    let (_, node) = pipeline
        .nodes_view
        .remove(from)
        .ok_or_else(|| anyhow::anyhow!("Unknown node {}", from))?;
    pipeline.nodes_view.insert(to.clone(), node);

    Ok(())
}

fn rename_links(
    pipeline: &mut PipelineAccess,
    from: &NodePath,
    to: &NodePath,
) -> anyhow::Result<()> {
    let mut links = pipeline.links.read();
    for link in links.iter_mut() {
        if &link.source == from {
            link.source = to.clone();
        }
        if &link.target == from {
            link.target = to.clone();
        }
    }
    pipeline.links.set(links);

    Ok(())
}

impl RenameNodeCommand {
    fn rename_node_in_containers(
        &self,
        pipeline: &mut PipelineAccess,
    ) -> anyhow::Result<Vec<(NodePath, Node)>> {
        let mut update_node_commands = Vec::new();
        for (path, node) in pipeline
            .nodes
            .iter()
            .filter(|(_, node)| node.node_type() == NodeType::Container)
        {
            if let Some(mut container) = node.downcast_node::<ContainerNode>(NodeType::Container) {
                let updated_node = container.nodes.iter().position(|p| p == &self.path);
                if let Some(updated_node_index) = updated_node {
                    container.nodes[updated_node_index] = self.new_name.clone();
                    update_node_commands.push((path.clone(), container));
                }
            }
        }

        update_node_commands
            .into_iter()
            .map(|(path, node)| {
                let previous = pipeline.apply_node_config(&path, node.into());

                previous.map(|previous| (path, previous))
            })
            .collect()
    }
}
