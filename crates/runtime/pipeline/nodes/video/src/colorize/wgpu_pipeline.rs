use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct ColorizeTextureWgpuPipeline {
    effect_pipeline: NodePipeline,
}

impl ColorizeTextureWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let effect_pipeline = NodePipelineBuilder::new(context, "Colorize Texture")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .fragment_uniform("Color Buffer", bytemuck::cast_slice(&[1.0f32, 1.0, 1.0]))
            .build()?;

        Ok(Self { effect_pipeline })
    }

    pub fn write_params(&self, context: &WgpuContext, red: f32, green: f32, blue: f32) {
        profiling::scope!("ColorizeTextureWgpuPipeline::write_params");
        self.effect_pipeline
            .write_uniform(context, 0, bytemuck::cast_slice(&[red, green, blue]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("ColorizeTextureWgpuPipeline::render");
        self.effect_pipeline.render(context, &[source], target)
    }
}
