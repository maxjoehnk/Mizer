use crate::pipeline::{NodeState, Pipeline};
use mizer_commander::{Command, Ref, RefMut};
use mizer_layouts::{ControlConfig, ControlType, LayoutStorage};
use mizer_node::{NodeLink, NodePath};
use mizer_nodes::{ContainerNode, Node};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DeleteNodesCommand {
    pub paths: Vec<NodePath>,
}

impl<'a> Command<'a> for DeleteNodesCommand {
    type Dependencies = (RefMut<Pipeline>, Ref<LayoutStorage>);
    type State = Vec<(
        NodeState,
        Vec<NodeLink>,
        HashMap<String, Vec<ControlConfig>>,
        Vec<(NodePath, Node)>,
    )>;
    type Result = ();

    fn label(&self) -> String {
        format!("Delete Nodes {:?}", self.paths)
    }

    fn apply(
        &self,
        (pipeline, layout_storage): (&mut Pipeline, &LayoutStorage),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut state = Vec::with_capacity(self.paths.len());
        for path in &self.paths {
            let Some((node_state, links)) = pipeline.delete_node(path) else {
                continue;
            };

            let mut layouts = layout_storage.read();
            let mut controls = HashMap::new();
            for layout in &mut layouts {
                let (matching, non_matching) =
                    layout.controls.clone().into_iter().partition(|control| {
                        matches!(&control.control_type, ControlType::Node { path: p } if p == path)
                    });
                layout.controls = non_matching;
                controls.insert(layout.id.clone(), matching);
            }
            layout_storage.set(layouts);
            let update_node_commands = self.remove_node_from_containers(pipeline, path)?;

            let entry = (node_state, links, controls, update_node_commands);
            state.push(entry);
        }

        Ok(((), state))
    }

    fn revert(
        &self,
        (pipeline, layout_storage): (&mut Pipeline, &LayoutStorage),
        state: Self::State,
    ) -> anyhow::Result<()> {
        for (path, (node_state, links, mut controls, container_commands)) in
            self.paths.iter().zip(state)
        {
            pipeline.reinsert_node(path.clone(), node_state);
            for link in links {
                pipeline.add_link(link.clone())?;
            }
            let mut layouts = layout_storage.read();
            for layout in &mut layouts {
                let mut controls = controls.remove(&layout.id).unwrap_or_default();
                layout.controls.append(&mut controls);
            }
            layout_storage.set(layouts);
            for (path, container) in container_commands {
                pipeline.update_node(&path, container)?;
            }
        }

        Ok(())
    }
}

impl DeleteNodesCommand {
    fn remove_node_from_containers(
        &self,
        pipeline: &mut Pipeline,
        node_path: &NodePath,
    ) -> anyhow::Result<Vec<(NodePath, Node)>> {
        let mut update_node_commands = Vec::new();
        for (path, container) in
            pipeline.find_nodes::<ContainerNode>(|node| node.nodes.contains(node_path))
        {
            let container = ContainerNode {
                nodes: container
                    .nodes
                    .iter()
                    .filter(|p| p != &node_path)
                    .cloned()
                    .collect(),
            };
            update_node_commands.push((path.clone(), container))
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

#[cfg(test)]
mod tests {
    use crate::commands::DeleteNodesCommand;
    use crate::pipeline::Pipeline;
    use mizer_commander::Command;
    use mizer_layouts::{
        ControlConfig, ControlDecorations, ControlPosition, ControlSize, ControlType, Layout,
        LayoutStorage,
    };
    use mizer_node::*;
    use mizer_ports::PortType;
    use pinboard::NonEmptyPinboard;

    #[test]
    fn delete_node_should_remove_the_connected_links() {
        let injector = Injector::new();
        let mut pipeline = Pipeline::new();
        let layout_storage = LayoutStorage::new(NonEmptyPinboard::new(Default::default()));
        let node1 = pipeline
            .add_node(
                &injector,
                NodeType::Fader,
                Default::default(),
                Default::default(),
                Default::default(),
            )
            .unwrap();
        let node2 = pipeline
            .add_node(
                &injector,
                NodeType::Fader,
                Default::default(),
                Default::default(),
                Default::default(),
            )
            .unwrap();
        let path1 = node1.path;
        let path2 = node2.path;
        pipeline
            .add_link(NodeLink {
                source: path1.clone(),
                source_port: "Output".into(),
                target: path2,
                target_port: "Input".into(),
                port_type: PortType::Single,
                local: true,
            })
            .unwrap();
        let cmd = DeleteNodesCommand { paths: vec![path1] };

        cmd.apply((&mut pipeline, &layout_storage)).unwrap();

        let links = pipeline.list_links().collect::<Vec<_>>();
        assert!(links.is_empty());
    }

    #[test]
    fn delete_node_should_remove_layout_controls() {
        let injector = Injector::new();
        let mut pipeline = Pipeline::new();
        let layout_storage = LayoutStorage::new(NonEmptyPinboard::new(Default::default()));
        let descriptor = pipeline
            .add_node(
                &injector,
                NodeType::Fader,
                Default::default(),
                Default::default(),
                Default::default(),
            )
            .unwrap();
        let path = descriptor.path;
        let mut layouts = layout_storage.read();
        layouts.push(Layout {
            id: "".into(),
            controls: vec![ControlConfig {
                id: Default::default(),
                control_type: ControlType::Node { path: path.clone() },
                position: ControlPosition::default(),
                label: None,
                decoration: ControlDecorations::default(),
                size: ControlSize {
                    width: 1,
                    height: 1,
                },
                behavior: Default::default(),
            }],
        });
        layout_storage.set(layouts);
        let cmd = DeleteNodesCommand { paths: vec![path] };

        cmd.apply((&mut pipeline, &layout_storage)).unwrap();

        let layouts = layout_storage.read();
        assert!(layouts[0].controls.is_empty());
    }
}
