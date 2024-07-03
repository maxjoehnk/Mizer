use mizer_module::{LoadProjectContext, ProjectHandler, ProjectHandlerContext, SaveProjectContext};
use crate::{Surface, SurfaceRegistry};

pub struct SurfaceProjectHandler; 

impl ProjectHandler for SurfaceProjectHandler {
    fn get_name(&self) -> &'static str {
        "surfaces"
    }

    fn new_project(&mut self, context: &mut impl ProjectHandlerContext) -> anyhow::Result<()> {
        let Some(registry) = context.try_get_mut::<SurfaceRegistry>() else {
            context.report_issue("Unable to load surfaces");
            
            return Ok(());
        };
        registry.clear_surfaces();
        
        Ok(())
    }

    fn load_project(&mut self, context: &mut impl LoadProjectContext) -> anyhow::Result<()> {
        let surfaces = context.read_file::<Vec<Surface>>("surfaces")?;
        let Some(registry) = context.try_get_mut::<SurfaceRegistry>() else {
            context.report_issue("Unable to load surfaces");

            return Ok(());
        };
        registry.clear_surfaces();
        registry.add_surfaces(surfaces);

        Ok(())
    }

    fn save_project(&self, context: &mut impl SaveProjectContext) -> anyhow::Result<()> {
        let Some(registry) = context.try_get_mut::<SurfaceRegistry>() else {
            context.report_issue("Unable to load surfaces");

            return Ok(());
        };
        context.write_file("surfaces", registry.list_surfaces())?;

        Ok(())
    }
}
