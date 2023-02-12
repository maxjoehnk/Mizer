use crate::update_layout;
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlConfig, ControlPosition, ControlSize, LayoutStorage};
use mizer_node::{NodePath, NodeType};
use mizer_runtime::pipeline_access::PipelineAccess;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct AddLayoutControlCommand {
    pub layout_id: String,
    pub path: NodePath,
    pub position: ControlPosition,
}

impl<'a> Command<'a> for AddLayoutControlCommand {
    type Dependencies = (Ref<LayoutStorage>, Ref<PipelineAccess>);
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Add control '{}' to Layout '{}'", self.path, self.layout_id)
    }

    fn apply(
        &self,
        (layout_storage, pipeline_access): (&LayoutStorage, &PipelineAccess),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let node = pipeline_access
            .nodes_view
            .get(&self.path)
            .ok_or_else(|| anyhow::anyhow!("Unknown node {}", self.path))?;
        let size = get_default_size_for_node_type(node.node_type());
        update_layout(layout_storage, &self.layout_id, |layout| {
            layout.controls.push(ControlConfig {
                node: self.path.clone(),
                label: None,
                position: self.position,
                size,
                decoration: Default::default(),
                behavior: Default::default(),
            });

            Ok(())
        })?;

        Ok(((), ()))
    }

    fn revert(
        &self,
        (layout_storage, _): (&LayoutStorage, &PipelineAccess),
        _: Self::State,
    ) -> anyhow::Result<()> {
        update_layout(layout_storage, &self.layout_id, |layout| {
            layout.controls.retain(|control| control.node != self.path);

            Ok(())
        })?;

        Ok(())
    }
}

fn get_default_size_for_node_type(node_type: NodeType) -> ControlSize {
    match node_type {
        NodeType::Fader => ControlSize {
            height: 4,
            width: 1,
        },
        NodeType::Button => ControlSize {
            height: 1,
            width: 1,
        },
        NodeType::Sequencer => ControlSize {
            height: 1,
            width: 1,
        },
        _ => ControlSize::default(),
    }
}
