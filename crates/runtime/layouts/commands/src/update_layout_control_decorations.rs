use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlDecorations, ControlId, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct UpdateLayoutControlDecorationsCommand {
    pub layout_id: String,
    pub control_id: ControlId,
    pub decorations: ControlDecorations,
}

impl<'a> Command<'a> for UpdateLayoutControlDecorationsCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ControlDecorations;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Change control decoration '{}' in layout '{}'",
            self.control_id, self.layout_id
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        let previous = control.decoration.clone();
        control.decoration = self.decorations.clone();
        layout_storage.set(layouts);

        Ok(((), previous))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, self.control_id)?;
        control.decoration = state;
        layout_storage.set(layouts);

        Ok(())
    }
}
