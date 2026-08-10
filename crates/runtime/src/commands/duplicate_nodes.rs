use crate::commands::add_path_to_container;
use crate::Pipeline;
use indexmap::IndexSet;
use itertools::Itertools;
use mizer_commander::{Command, RefMut};
use mizer_node::{NodeLink, NodePath};
use mizer_nodes::ContainerNode;
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DuplicateNodesCommand {
    pub paths: Vec<NodePath>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for DuplicateNodesCommand {
    type Dependencies = RefMut<Pipeline>;
    type State = (Vec<NodePath>, Vec<NodeLink>);
    type Result = Vec<NodePath>;

    fn label(&self) -> String {
        format!("Duplicate Nodes {:?}", &self.paths)
    }

    fn apply(&self, pipeline: &mut Pipeline) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut paths = self.paths.iter().cloned().collect::<IndexSet<_>>();

        let mut new_paths = Vec::with_capacity(self.paths.len());
        let mut new_links = Vec::new();

        for path in &paths {
            let new_path = pipeline.duplicate_node(path, self.parent.as_ref())?;
            add_path_to_container(pipeline, self.parent.as_ref(), &new_path)?;
            new_paths.push(new_path.clone());
        }

        let containers = pipeline.find_nodes::<ContainerNode>(|path, _| new_paths.contains(path)).into_iter().map(|(path, container)| (path.clone(), container.clone())).collect::<Vec<_>>();

        for (parent_path, container) in containers {
            if let Some(container_mut) = pipeline.get_node_mut::<ContainerNode>(&parent_path) {
                container_mut.nodes.clear();
            }
            for path in &container.nodes {
                let new_path = pipeline.duplicate_node(path, Some(&parent_path))?;
                add_path_to_container(pipeline, Some(&parent_path), &new_path)?;
                paths.insert(path.clone());
                new_paths.push(new_path.clone());
            }
        }


        let links = pipeline.list_links();
        let mut links: HashMap<_, _> = links
            .filter(|link| paths.contains(&link.source) && paths.contains(&link.target))
            .cloned()
            .chunk_by(|link| link.source.clone())
            .into_iter()
            .map(|(path, links)| (path, links.collect::<Vec<_>>()))
            .collect();
        for path in &paths {
            let links = links.remove(path).unwrap_or_default();
            for link in links {
                if !paths.contains(&link.target) {
                    continue;
                }
                let new_source = paths.iter().position(|p| p == &link.source).unwrap();
                let new_target = paths.iter().position(|p| p == &link.target).unwrap();
                let new_link = NodeLink {
                    source: new_paths[new_source].clone(),
                    target: new_paths[new_target].clone(),
                    source_port: link.source_port.clone(),
                    target_port: link.target_port.clone(),
                    local: link.local,
                    port_type: link.port_type,
                };
                pipeline.add_link(new_link.clone())?;
                new_links.push(new_link);
            }
        }

        Ok((new_paths.clone(), (new_paths, new_links)))
    }

    fn revert(&self, pipeline: &mut Pipeline, (nodes, links): Self::State) -> anyhow::Result<()> {
        for link in links {
            pipeline.delete_link(&link);
        }
        for node in nodes {
            pipeline.delete_node(&node);
        }

        Ok(())
    }
}
