use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct LumaKeyWgpuPipeline {
    pipeline: NodePipeline,
}

impl LumaKeyWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let pipeline = NodePipelineBuilder::new(context, "Luma Key")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .uniform("Luma Key Threshold Buffer", bytemuck::cast_slice(&[1.0f32]))
            .build()?;

        Ok(Self { pipeline })
    }

    pub fn write_params(&self, context: &WgpuContext, threshold: f32) {
        profiling::scope!("LumaKeyWgpuPipeline::write_params");
        self.pipeline
            .write_uniform(context, 0, bytemuck::cast_slice(&[threshold]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("LumaKeyWgpuPipeline::render");
        self.pipeline.render(context, &[source], target)
    }
}
