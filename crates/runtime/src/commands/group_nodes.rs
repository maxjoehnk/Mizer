use crate::commands::{AddNodeCommand, RenameNodeCommand};
use mizer_commander::{sub_command, Command, InjectorRef, Ref, RefMut};
use mizer_node::{InjectionScope, NodeDesigner, NodePath, NodePosition, NodeType};
use mizer_nodes::{ContainerNode, Node};
use serde::{Deserialize, Serialize};
use mizer_layouts::LayoutStorage;
use crate::Pipeline;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GroupNodesCommand {
    pub nodes: Vec<NodePath>,
    pub parent: Option<NodePath>,
}

impl<'a> Command<'a> for GroupNodesCommand {
    type Dependencies = (RefMut<Pipeline>, Ref<LayoutStorage>, InjectorRef);
    type State = (sub_command!(AddNodeCommand), Vec<sub_command!(RenameNodeCommand)>);
    type Result = ();

    fn label(&self) -> String {
        format!("Grouping Nodes '{:?}'", self.nodes)
    }

    fn apply(
        &self,
        (pipeline, layout_storage, injector): (&mut Pipeline, &LayoutStorage, InjectionScope),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let positions = pipeline.get_positions(&self.nodes);
        let center = get_center(positions);
        let cmd = AddNodeCommand {
            node_type: NodeType::Container,
            parent: self.parent.clone(),
            node: Some(Node::Container(ContainerNode {
                nodes: self.nodes.clone(),
            })),
            designer: NodeDesigner {
                position: center,
                ..Default::default()
            },
            template: None,
        };
        let (_, container_path) = cmd.apply((pipeline, injector))?;
        let mut rename_command_states = Vec::with_capacity(self.nodes.len());
        for path in &self.nodes {
            let command = RenameNodeCommand {
                path: path.clone(),
                new_name: container_path.join(path),
            };
            let (_, rename_state) = command.apply((pipeline, layout_storage))?;
            rename_command_states.push((command, rename_state));
        }

        Ok(((), ((cmd, container_path), rename_command_states)))
    }

    fn revert(
        &self,
        (pipeline, layout_storage, injector): (&mut Pipeline, &LayoutStorage, InjectionScope),
        (add_node_state, rename_node_states): Self::State,
    ) -> anyhow::Result<()> {
        for (command, state) in rename_node_states {
            command.revert((pipeline, layout_storage), state)?;
        }
        add_node_state.0.revert((pipeline, injector), add_node_state.1)?;

        Ok(())
    }
}

fn get_center(positions: Vec<NodePosition>) -> NodePosition {
    let min_x = positions.iter().map(|pos| pos.x).min_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap()).unwrap_or_default();
    let min_y = positions.iter().map(|pos| pos.y).min_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap()).unwrap_or_default();
    let max_x = positions.iter().map(|pos| pos.x).max_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap()).unwrap_or_default();
    let max_y = positions.iter().map(|pos| pos.y).max_by(|lhs, rhs| lhs.partial_cmp(rhs).unwrap()).unwrap_or_default();

    NodePosition {
        x: center_point(min_x, max_x),
        y: center_point(min_y, max_y),
    }
}

fn center_point(min: f64, max: f64) -> f64 {
    min + (max - min) / 2.0
}
