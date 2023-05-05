use mizer_commander::{Command, Ref};
use mizer_layouts::{Layout, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, Hash)]
pub struct AddLayoutCommand {
    pub name: String,
}

impl<'a> Command<'a> for AddLayoutCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = ();
    type Result = ();

    fn label(&self) -> String {
        format!("Add Layout '{}'", self.name)
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        layouts.push(Layout {
            id: self.name.clone(),
            controls: Default::default(),
        });
        layout_storage.set(layouts);

        Ok(((), ()))
    }

    fn revert(&self, layout_storage: &LayoutStorage, _: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        layouts.retain(|layout| layout.id != self.name);
        layout_storage.set(layouts);

        Ok(())
    }
}
