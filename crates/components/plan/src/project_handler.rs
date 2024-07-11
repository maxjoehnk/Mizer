use mizer_module::{LoadProjectContext, ProjectHandler, ProjectHandlerContext, SaveProjectContext};
use crate::PlanStorage;

pub struct PlanProjectHandler;

impl ProjectHandler for PlanProjectHandler {
    fn get_name(&self) -> &'static str {
        "plans"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        let storage = context.try_get_mut::<PlanStorage>().ok_or_else(|| anyhow::anyhow!("Missing plan storage"))?;
        storage.set(Default::default());

        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        let plans = context.read_file("plans")?;
        let storage = context.try_get_mut::<PlanStorage>().ok_or_else(|| anyhow::anyhow!("Missing plan storage"))?;
        storage.set(plans);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        let storage = context.try_get::<PlanStorage>().ok_or_else(|| anyhow::anyhow!("Missing plan storage"))?;
        let plans = storage.read();
        context.write_file("plans", plans)?;

        Ok(())
    }
}
