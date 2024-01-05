use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct RgbWgpuPipeline {
    node_pipeline: NodePipeline,
}

impl RgbWgpuPipeline {
    pub fn new(context: &WgpuContext, initial: &[f32]) -> anyhow::Result<Self> {
        let node_pipeline = NodePipelineBuilder::new(context, "RGB Texture")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .uniform("Color Buffer", bytemuck::cast_slice(initial))
            .build()?;

        Ok(Self { node_pipeline })
    }

    pub fn write_params(&self, context: &WgpuContext, red: f32, green: f32, blue: f32) {
        profiling::scope!("RgbWgpuPipeline::write_params");
        self.node_pipeline
            .write_uniform(context, 0, bytemuck::cast_slice(&[red, green, blue]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        source: &TextureView,
        target: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("RgbWgpuPipeline::render");
        self.node_pipeline.render(context, &[source], target)
    }
}
