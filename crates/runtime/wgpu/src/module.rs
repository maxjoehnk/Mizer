use crate::processor::WgpuPipelineProcessor;
use crate::{TextureRegistry, WgpuContext, WgpuPipeline};
use mizer_module::{Module, Runtime};

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
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        let injector = runtime.injector_mut();
        injector.provide(self.context);
        injector.provide(WgpuPipeline::new());
        injector.provide(TextureRegistry::new());
        runtime.add_processor(Box::new(WgpuPipelineProcessor));

        Ok(())
    }
}
