use mizer_module::*;

use crate::processor::WgpuPipelineProcessor;
use crate::{TextureRegistry, WgpuContext, WgpuPipeline};

pub struct WgpuModule;

module_name!(WgpuModule);

impl Module for WgpuModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let wgpu_context = context.block_on(WgpuContext::new())?;

        context.provide(wgpu_context);
        context.provide(WgpuPipeline::new());
        context.provide(TextureRegistry::new());
        context.add_processor(WgpuPipelineProcessor);

        Ok(())
    }
}
