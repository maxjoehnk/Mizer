use serde::{Deserialize, Serialize};

use mizer_commander::{Command, RefMut};
use mizer_execution_planner::ExecutionPlanner;
use mizer_node::NodePath;
use mizer_util::HashMapExtension;

use crate::pipeline_access::PipelineAccess;

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RenameNodeCommand {
    pub path: NodePath,
    pub new_name: NodePath,
}

impl<'a> Command<'a> for RenameNodeCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = ();
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

        Ok(((), ()))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        _: Self::State,
    ) -> anyhow::Result<()> {
        rename_designer_nodes(pipeline, &self.new_name, &self.path)?;
        rename_nodes(pipeline, &self.new_name, &self.path)?;
        rename_nodes_view(pipeline, &self.new_name, &self.path)?;
        rename_links(pipeline, &self.new_name, &self.path)?;
        planner.rename_node(&self.new_name, self.path.clone());

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
