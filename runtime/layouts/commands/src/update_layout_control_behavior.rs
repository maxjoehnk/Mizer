use crate::get_control;
use mizer_commander::{Command, Ref};
use mizer_layouts::{ControlBehavior, LayoutStorage};
use serde::{Deserialize, Serialize};
use std::hash::Hash;

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct UpdateLayoutControlBehaviorCommand {
    pub layout_id: String,
    pub control_id: String,
    pub behavior: ControlBehavior,
}

impl<'a> Command<'a> for UpdateLayoutControlBehaviorCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ControlBehavior;
    type Result = ();

    fn label(&self) -> String {
        format!(
            "Change control behavior '{}' in layout '{}'",
            self.control_id, self.layout_id
        )
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, &self.control_id)?;
        let previous = control.behavior;
        control.behavior = self.behavior;
        layout_storage.set(layouts);

        Ok(((), previous))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let control = get_control(&mut layouts, &self.layout_id, &self.control_id)?;
        control.behavior = state;
        layout_storage.set(layouts);

        Ok(())
    }
}
