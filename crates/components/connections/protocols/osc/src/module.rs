use mizer_module::*;

pub struct OscModule;

module_name!(OscModule);

impl Module for OscModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        Ok(())
    }
}
