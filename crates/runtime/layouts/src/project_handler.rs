use mizer_module::{LoadProjectContext, ProjectHandler, ProjectHandlerContext, SaveProjectContext};
use crate::{Layout, LayoutStorage};

pub struct LayoutProjectHandler;

impl ProjectHandler for LayoutProjectHandler {
    fn get_name(&self) -> &'static str {
        "layouts"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        let storage = context.try_get_mut::<LayoutStorage>().ok_or_else(|| anyhow::anyhow!("Missing layout storage"))?;
        storage.set(vec![Layout {
            id: "Default".into(),
            controls: Vec::new(),
        }]);

        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        let plans = context.read_file("layouts")?;
        let storage = context.try_get_mut::<LayoutStorage>().ok_or_else(|| anyhow::anyhow!("Missing layout storage"))?;
        storage.set(plans);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        let storage = context.try_get_mut::<LayoutStorage>().ok_or_else(|| anyhow::anyhow!("Missing layout storage"))?;
        let plans = storage.read();
        context.write_file("layouts", plans)?;

        Ok(())
    }
}
