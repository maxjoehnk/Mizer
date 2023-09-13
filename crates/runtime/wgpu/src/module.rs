use mizer_module::{Module, Runtime};

use crate::processor::WgpuPipelineProcessor;
use crate::{TextureRegistry, WgpuContext, WgpuPipeline};

pub struct WgpuModule {
    context: WgpuContext,
}

impl WgpuModule {
    pub async fn new() -> anyhow::Result<Self> {
        let context = WgpuContext::new().await?;

        Ok(Self { context })
    }
}

impl Module for WgpuModule {
    fn register(self, runtime: &mut impl Runtime) -> anyhow::Result<()> {
        let injector = runtime.injector_mut();
        injector.provide(self.context);
        injector.provide(WgpuPipeline::new());
        injector.provide(TextureRegistry::new());
        runtime.add_processor(WgpuPipelineProcessor);

        Ok(())
    }
}
