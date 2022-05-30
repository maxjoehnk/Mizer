use crate::update_layout;
use mizer_commander::{Command, Ref};
use mizer_layouts::LayoutStorage;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct RenameLayoutCommand {
    pub id: String,
    pub name: String,
}

impl<'a> Command<'a> for RenameLayoutCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Rename Layout '{}' to '{}'", self.id, self.name)
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        update_layout(layout_storage, &self.id, |layout| {
            layout.id = self.name.clone();

            Ok(())
        })?;

        Ok(((), ()))
    }

    fn revert(&self, layout_storage: &LayoutStorage, _: Self::State) -> anyhow::Result<()> {
        update_layout(layout_storage, &self.name, |layout| {
            layout.id = self.id.clone();

            Ok(())
        })?;

        Ok(())
    }
}
