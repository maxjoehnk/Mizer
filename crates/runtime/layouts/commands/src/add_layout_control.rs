use crate::update_layout;
use mizer_commander::{Command, Ref};
use mizer_layouts::{
    ControlConfig, ControlId, ControlPosition, ControlSize, ControlType, LayoutStorage,
};
use mizer_node::NodeType;
use mizer_runtime::pipeline_access::PipelineAccess;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct AddLayoutControlCommand {
    pub layout_id: String,
    pub control_type: ControlType,
    pub position: ControlPosition,
}

impl<'a> Command<'a> for AddLayoutControlCommand {
    type Dependencies = (Ref<LayoutStorage>, Ref<PipelineAccess>);
    type State = ControlId;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Add control '{:?}' to Layout '{}'",
            self.control_type, self.layout_id
        )
    }

    fn apply(
        &self,
        (layout_storage, pipeline_access): (&LayoutStorage, &PipelineAccess),
    ) -> anyhow::Result<(Self::Result, Self::State)> {
        let size = if let ControlType::Node { path: node } = &self.control_type {
            let node = pipeline_access
                .nodes_view
                .get(node)
                .ok_or_else(|| anyhow::anyhow!("Unknown node {node}"))?;
            get_default_size_for_node_type(node.node_type())
        } else {
            ControlSize::default()
        };
        let control_id = ControlId::new();
        update_layout(layout_storage, &self.layout_id, |layout| {
            layout.controls.push(ControlConfig {
                id: control_id,
                control_type: self.control_type.clone(),
                label: None,
                position: self.position,
                size,
                decoration: Default::default(),
                behavior: Default::default(),
            });

            Ok(())
        })?;

        Ok(((), control_id))
    }

    fn revert(
        &self,
        (layout_storage, _): (&LayoutStorage, &PipelineAccess),
        control_id: Self::State,
    ) -> anyhow::Result<()> {
        update_layout(layout_storage, &self.layout_id, |layout| {
            layout.controls.retain(|control| control.id != control_id);

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
        _ => ControlSize::default(),
    }
}
