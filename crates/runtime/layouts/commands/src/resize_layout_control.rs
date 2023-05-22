use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlId, ControlSize, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct ResizeLayoutControlCommand {
    pub layout_id: String,
    pub control_id: ControlId,
    pub size: ControlSize,
}

impl<'a> Command<'a> for ResizeLayoutControlCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ControlSize;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Resize control '{}' in layout '{}'",
            self.control_id, self.layout_id
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        let previous = control.size;
        control.size = self.size;
        layout_storage.set(layouts);

        Ok(((), previous))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        control.size = state;
        layout_storage.set(layouts);

        Ok(())
    }
}
