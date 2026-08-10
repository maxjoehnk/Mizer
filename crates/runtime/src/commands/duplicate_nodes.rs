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
            .sorted_by_cached_key(|link| link.source.clone())
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

#[cfg(test)]
mod tests {
    use crate::commands::{DuplicateNodesCommand, StaticNodeDescriptor};
    use crate::Pipeline;
    use itertools::Itertools;
    use mizer_commander::Command;
    use mizer_node::*;

    #[test]
    fn links_missing_when_duplicating() -> anyhow::Result<()> {
        let injector = Injector::new();
        let mut pipeline = Pipeline::new();
        let button_0 = pipeline.add(&injector, NodeType::Button)?;
        let button_1 = pipeline.add(&injector, NodeType::Button)?;
        let oscillator_0 = pipeline.add(&injector, NodeType::Oscillator)?;
        let oscillator_1 = pipeline.add(&injector, NodeType::Oscillator)?;
        let merge_0 = pipeline.add(&injector, NodeType::Merge)?;
        let merge_1 = pipeline.add(&injector, NodeType::Merge)?;
        let merge_2 = pipeline.add(&injector, NodeType::Merge)?;
        pipeline.link(&button_0, &merge_0, "Output", "Inputs")?;
        pipeline.link(&oscillator_1, &merge_0, "Value", "Inputs")?;
        pipeline.link(&oscillator_0, &merge_0, "Value", "Inputs")?;
        pipeline.link(&button_1, &merge_0, "Output", "Inputs")?;
        pipeline.link(&button_0, &merge_1, "Output", "Inputs")?;
        pipeline.link(&button_1, &merge_1, "Output", "Inputs")?;
        pipeline.link(&merge_1, &oscillator_0, "Output", "Max")?;
        pipeline.link(&button_0, &merge_2, "Output", "Inputs")?;
        pipeline.link(&button_1, &merge_2, "Output", "Inputs")?;
        pipeline.link(&merge_2, &oscillator_1, "Output", "Max")?;
        let cmd = DuplicateNodesCommand {
            parent: None,
            paths: vec![
                button_0.path.clone(),
                button_1.path.clone(),
                merge_0.path.clone(),
                merge_1.path.clone(),
                merge_2.path.clone(),
                oscillator_0.path.clone(),
                oscillator_1.path.clone(),
            ]
        };

        let _ = cmd.apply(&mut pipeline)?;

        pipeline.assert_contains_link("/button-2", "/merge-4", "Output", "Inputs");
        pipeline.assert_contains_link("/button-2", "/merge-5", "Output", "Inputs");
        pipeline.assert_contains_link("/button-3", "/merge-4", "Output", "Inputs");
        pipeline.assert_contains_link("/button-3", "/merge-5", "Output", "Inputs");
        pipeline.assert_contains_link("/merge-4", "/oscillator-2", "Output", "Max");
        pipeline.assert_contains_link("/merge-5", "/oscillator-3", "Output", "Max");
        pipeline.assert_contains_link("/button-2", "/merge-3", "Output", "Inputs");
        pipeline.assert_contains_link("/button-3", "/merge-3", "Output", "Inputs");
        pipeline.assert_contains_link("/oscillator-2", "/merge-3", "Value", "Inputs");
        pipeline.assert_contains_link("/oscillator-3", "/merge-3", "Value", "Inputs");
        Ok(())
    }

    trait PipelineTestExtensions {
        fn add(&mut self, injector: &Injector, node_type: NodeType) -> anyhow::Result<StaticNodeDescriptor>;
        fn link(&mut self, source: &StaticNodeDescriptor, target: &StaticNodeDescriptor, source_port: &str, target_port: &str) -> anyhow::Result<()>;
        fn assert_contains_link(&self, source: &str, target: &str, source_port: &str, target_port: &str);
    }

    impl PipelineTestExtensions for Pipeline {
        fn add(&mut self, injector: &Injector, node_type: NodeType) -> anyhow::Result<StaticNodeDescriptor> {
            self.add_node(injector, node_type, Default::default(), Default::default(), Default::default())
        }
        fn link(&mut self, source: &StaticNodeDescriptor, target: &StaticNodeDescriptor, source_port: &str, target_port: &str) -> anyhow::Result<()> {
            self.add_link(NodeLink { source: source.path.clone(), target: target.path.clone(), source_port: PortId::from(source_port), target_port: PortId::from(target_port), local: true, port_type: PortType::Single })?;

            Ok(())
        }

        fn assert_contains_link(&self, source: &str, target: &str, source_port: &str, target_port: &str) {
            let result = self.list_links().contains(&NodeLink {
                source: NodePath::from(source),
                target: NodePath::from(target),
                source_port: PortId::from(source_port),
                target_port: PortId::from(target_port),
                local: true,
                port_type: PortType::Single,
            });
            assert!(result, "Link not found: source={}, target={}, source_port={}, target_port={}", source, target, source_port, target_port);
        }
    }
}
