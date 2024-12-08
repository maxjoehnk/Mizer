use mizer_module::*;
use crate::{Layout, LayoutStorage};

pub struct LayoutProjectHandler;

impl ProjectHandler for LayoutProjectHandler {
    fn get_name(&self) -> &'static str {
        "layouts"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext, injector: &mut dyn InjectDynMut) -> anyhow::Result<()> {
        let storage = injector.try_inject_mut::<LayoutStorage>().ok_or_else(|| anyhow::anyhow!("Missing layout storage"))?;
        storage.set(vec![Layout {
            id: "Default".into(),
            controls: Vec::new(),
        }]);

        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext, injector: &mut dyn InjectDynMut) -> anyhow::Result<()> {
        let plans = context.read_file("layouts")?;
        let storage = injector.try_inject_mut::<LayoutStorage>().ok_or_else(|| anyhow::anyhow!("Missing layout storage"))?;
        storage.set(plans);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext, injector: &dyn InjectDyn) -> anyhow::Result<()> {
        let storage = injector.try_inject::<LayoutStorage>().ok_or_else(|| anyhow::anyhow!("Missing layout storage"))?;
        let plans = storage.read();
        context.write_file("layouts", plans)?;

        Ok(())
    }
}
