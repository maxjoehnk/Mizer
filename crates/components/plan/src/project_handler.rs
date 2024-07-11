use mizer_module::*;
use crate::PlanStorage;

pub struct PlanProjectHandler;

impl ProjectHandler for PlanProjectHandler {
    fn get_name(&self) -> &'static str {
        "plans"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext, injector: &mut dyn InjectDynMut) -> anyhow::Result<()> {
        let storage = injector.try_inject::<PlanStorage>().ok_or_else(|| anyhow::anyhow!("Missing plan storage"))?;
        storage.set(Default::default());

        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext, injector: &mut dyn InjectDynMut) -> anyhow::Result<()> {
        let plans = context.read_file("plans")?;
        let storage = injector.try_inject::<PlanStorage>().ok_or_else(|| anyhow::anyhow!("Missing plan storage"))?;
        storage.set(plans);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext, injector: &dyn InjectDyn) -> anyhow::Result<()> {
        let storage = injector.try_inject::<PlanStorage>().ok_or_else(|| anyhow::anyhow!("Missing plan storage"))?;
        let plans = storage.read();
        context.write_file("plans", plans)?;

        Ok(())
    }
}
