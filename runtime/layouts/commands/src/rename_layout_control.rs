use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_layouts::LayoutStorage;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RenameLayoutControlCommand {
    pub layout_id: String,
    pub control_id: String,
    pub name: String,
}

impl<'a> Command<'a> for RenameLayoutControlCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = Option<String>;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Rename control '{}' in layout '{}' to '{}'",
            self.control_id, self.layout_id, self.name
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, &self.control_id)?;
        let previous = control.label.replace(self.name.clone());
        layout_storage.set(layouts);

        Ok(((), previous))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, &self.control_id)?;
        control.label = state;
        layout_storage.set(layouts);

        Ok(())
    }
}
