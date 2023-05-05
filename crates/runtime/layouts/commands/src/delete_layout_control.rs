use crate::{get_layout, update_layout};
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlConfig, LayoutStorage};
use mizer_node::NodePath;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct DeleteLayoutControlCommand {
    pub layout_id: String,
    pub control_id: NodePath,
}

impl<'a> Command<'a> for DeleteLayoutControlCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ControlConfig;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Delete control '{}' from Layout '{}'",
            self.control_id, self.layout_id
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let layout = get_layout(&mut layouts, &self.layout_id)?;
        let control_index = layout
            .controls
            .iter()
            .position(|c| c.node == self.control_id)
            .ok_or_else(|| anyhow::anyhow!(""))?;
        let control = layout.controls.remove(control_index);
        layout_storage.set(layouts);

        Ok(((), control))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        update_layout(layout_storage, &self.layout_id, |layout| {
            layout.controls.push(state);

            Ok(())
        })?;

        Ok(())
    }
}
