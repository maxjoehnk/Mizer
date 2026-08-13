use crate::get_layout;
use mizer_commander::{Command, Ref};
use mizer_layouts::LayoutStorage;
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct DuplicateLayoutCommand {
    pub id: String,
    pub name: String,
}

impl<'a> Command<'a> for DuplicateLayoutCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = String;
    type Result = ();

    fn label(&self) -> String {
        format!("Duplicate Layout '{}' to '{}'", self.id, self.name)
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let layout = get_layout(&mut layouts, &self.id)?;
        let mut new_layout = layout.clone();
        new_layout.id = self.name.clone();
        layouts.push(new_layout);
        layout_storage.set(layouts);

        Ok(((), self.name.clone()))
    }

    fn revert(&self, layout_storage: &LayoutStorage, id: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        let index = layouts
            .iter()
            .position(|p| p.id == id)
            .ok_or_else(|| anyhow::anyhow!("Unknown layout {}", &id))?;
        layouts.remove(index);
        layout_storage.set(layouts);

        Ok(())
    }
}
