use std::collections::HashMap;
use itertools::Itertools;
use super::StaticNodeDescriptor;
use crate::commands::add_path_to_container;
use crate::pipeline_access::PipelineAccess;
use mizer_commander::{Command, RefMut};
use mizer_execution_planner::{ExecutionNode, ExecutionPlanner};
use mizer_node::{NodeLink, NodePath};
use mizer_nodes::NodeDowncast;
use serde::{Deserialize, Serialize};
use mizer_pipeline::NodePortReader;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DuplicateNodesCommand {
    pub paths: Vec<NodePath>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for DuplicateNodesCommand {
    type Dependencies = (RefMut<PipelineAccess>, RefMut<ExecutionPlanner>);
    type State = (Vec<NodePath>, Vec<NodeLink>);
    type Result = Vec<StaticNodeDescriptor>;

    fn label(&self) -> String {
        format!("Duplicate Nodes {:?}", &self.paths)
    }

    fn apply(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut new_paths = Vec::with_capacity(self.paths.len());
        let mut new_links = Vec::new();
        let mut descriptors = Vec::with_capacity(self.paths.len());
        for path in &self.paths {
            let designer = pipeline
                .designer
                .read()
                .get(path)
                .cloned()
                .unwrap_or_default();
            let new_path = pipeline.duplicate_node(path)?;
            planner.add_node(ExecutionNode {
                path: new_path.clone(),
                attached_executor: None,
            });
            add_path_to_container(pipeline, self.parent.as_ref(), &new_path)?;

            let node = pipeline.nodes_view.get(&new_path).unwrap();
            let details = node.value().details();

            let descriptor = StaticNodeDescriptor {
                node_type: node.node_type(),
                path: new_path.clone(),
                designer,
                details,
                ports: pipeline.list_ports(path).unwrap_or_default(),
                settings: pipeline.get_settings(path).unwrap_or_default(),
                config: node.downcast(),
            };
            descriptors.push(descriptor);
            new_paths.push(new_path.clone());
        }
        
        let links = pipeline.links.read();
        let mut links: HashMap<_, _> = links.into_iter()
            .group_by(|link| link.source.clone())
            .into_iter()
            .map(|(path, links)| (path, links.collect::<Vec<_>>()))
            .collect();
        for path in &self.paths {
            let links = links.remove(path).unwrap_or_default();
            for link in links {
                if !self.paths.contains(&link.target) {
                    continue;
                }
                let new_source = self.paths.iter().position(|p| p == &link.source).unwrap();
                let new_target = self.paths.iter().position(|p| p == &link.target).unwrap();
                let new_link = NodeLink {
                    source: new_paths[new_source].clone(),
                    target: new_paths[new_target].clone(),
                    source_port: link.source_port.clone(),
                    target_port: link.target_port.clone(),
                    local: link.local,
                    port_type: link.port_type,
                };
                planner.add_link(new_link.clone());
                pipeline.add_link(new_link.clone())?;
                new_links.push(new_link);
            }
        }

        Ok((descriptors, (new_paths, new_links)))
    }

    fn revert(
        &self,
        (pipeline, planner): (&mut PipelineAccess, &mut ExecutionPlanner),
        (nodes, links): Self::State,
    ) -> anyhow::Result<()> {
        for link in links {
            planner.remove_link(&link);
            pipeline.remove_link(&link);
        }
        for node in nodes {
            planner.remove_node(&node);
            pipeline.delete_node(node)?;
        }

        Ok(())
    }
}
