use crate::registry::ShaderRegistry;
use mizer_module::*;

pub struct ShaderModule;

module_name!(ShaderModule);

impl Module for ShaderModule {
    const IS_REQUIRED: bool = false;

    fn register(self, runtime: &mut impl ModuleContext) -> anyhow::Result<()> {
        runtime.provide(ShaderRegistry::new());

        Ok(())
    }
}
