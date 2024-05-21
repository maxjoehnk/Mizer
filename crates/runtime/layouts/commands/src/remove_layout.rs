use mizer_commander::{Command, Ref};
use mizer_layouts::{Layout, LayoutStorage};
use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct RemoveLayoutCommand {
    pub id: String,
}

impl<'a> Command<'a> for RemoveLayoutCommand {
    type Dependencies = Ref<LayoutStorage>;
    type State = Layout;
    type Result = ();

    fn label(&self) -> String {
        format!("Remove Layout '{}'", self.id)
    }

    fn apply(&self, layout_storage: &LayoutStorage) -> anyhow::Result<(Self::Result, Self::State)> {
        let mut layouts = layout_storage.read();
        let index = layouts
            .iter()
            .position(|p| p.id == self.id)
            .ok_or_else(|| anyhow::anyhow!("Unknown layout {}", &self.id))?;
        let layout = layouts.remove(index);
        layout_storage.set(layouts);

        Ok(((), layout))
    }

    fn revert(&self, layout_storage: &LayoutStorage, state: Self::State) -> anyhow::Result<()> {
        let mut layouts = layout_storage.read();
        layouts.push(state);
        layout_storage.set(layouts);

        Ok(())
    }
}
