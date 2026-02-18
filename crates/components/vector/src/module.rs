use mizer_module::{Module, ModuleContext};
use mizer_wgpu::WgpuContext;

use crate::renderer::VectorWgpuRenderer;

pub struct VectorModule;

mizer_module::module_name!(VectorModule);

impl Module for VectorModule {
    const IS_REQUIRED: bool = false;

    fn register(self, context: &mut impl ModuleContext) -> anyhow::Result<()> {
        let renderer = {
            let wgpu_context = context
                .try_get::<WgpuContext>()
                .ok_or_else(|| anyhow::anyhow!("missing wgpu module"))?;
            VectorWgpuRenderer::new(&wgpu_context)?
        };
        context.provide(renderer);

        Ok(())
    }
}
