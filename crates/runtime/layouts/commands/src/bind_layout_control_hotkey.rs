use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlId, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct BindLayoutControlHotkeyCommand {
    pub layout_id: String,
    pub control_id: ControlId,
    pub hotkey: Option<String>,
}

impl<'a> Command<'a> for BindLayoutControlHotkeyCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = Option<String>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Bind hotkey '{:?}' for control '{}' in layout '{}'",
            self.hotkey, self.control_id, self.layout_id
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        let previous = control.hotkey.clone();
        control.hotkey = self.hotkey.clone();
        layout_storage.set(layouts);

        Ok(((), previous))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        control.hotkey = state;
        layout_storage.set(layouts);

        Ok(())
    }
}
