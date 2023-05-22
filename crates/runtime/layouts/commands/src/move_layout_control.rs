use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlId, ControlPosition, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct MoveLayoutControlCommand {
    pub layout_id: String,
    pub control_id: ControlId,
    pub position: ControlPosition,
}

impl<'a> Command<'a> for MoveLayoutControlCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ControlPosition;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Move control '{}' in layout '{}'",
            self.control_id, self.layout_id
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        let previous = control.position;
        control.position = self.position;
        layout_storage.set(layouts);

        Ok(((), previous))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        control.position = state;
        layout_storage.set(layouts);

        Ok(())
    }
}
