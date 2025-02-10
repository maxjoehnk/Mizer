use crate::{Surface, SurfaceRegistry};
use mizer_module::*;

pub struct SurfaceProjectHandler;

impl ProjectHandler for SurfaceProjectHandler {
    fn get_name(&self) -> &'static str {
        "surfaces"
    }

    fn new_project(
        &mut self,
        context: &mut impl ProjectHandlerContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let Some(registry) = injector.try_inject::<SurfaceRegistry>() else {
            context.report_issue("Unable to load surfaces");

            return Ok(());
        };
        registry.clear_surfaces();

        Ok(())
    }

    fn load_project(
        &mut self,
        context: &mut impl LoadProjectContext,
        injector: &mut dyn InjectDynMut,
    ) -> anyhow::Result<()> {
        let surfaces = context.read_file::<Vec<Surface>>("surfaces")?;
        let Some(registry) = injector.try_inject::<SurfaceRegistry>() else {
            context.report_issue("Unable to load surfaces");

            return Ok(());
        };
        registry.clear_surfaces();
        registry.add_surfaces(surfaces);

        Ok(())
    }

    fn save_project(
        &self,
        context: &mut impl SaveProjectContext,
        injector: &dyn InjectDyn,
    ) -> anyhow::Result<()> {
        let Some(registry) = injector.try_inject::<SurfaceRegistry>() else {
            context.report_issue("Unable to load surfaces");

            return Ok(());
        };
        context.write_file("surfaces", registry.list_surfaces())?;

        Ok(())
    }
}
