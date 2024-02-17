use crate::loader::IsfLoader;
use mizer_module::*;
use mizer_shaders::ShaderRegistry;

pub struct IsfShaderModule;

module_name!(IsfShaderModule);

impl Module for IsfShaderModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let registry = context
            .try_get_mut::<ShaderRegistry>()
            .ok_or_else(|| anyhow::anyhow!("Missing shader module"))?;

        if let Err(err) = IsfLoader::load_dir(registry, "crates/components/shaders/isf/.shaders") {
            tracing::error!("err while loading shaders: {}", err);
        }

        Ok(())
    }
}
