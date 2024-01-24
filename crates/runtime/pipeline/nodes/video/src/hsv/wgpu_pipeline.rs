use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct HsvWgpuPipeline {
    pipeline: NodePipeline,
}

impl HsvWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let pipeline = NodePipelineBuilder::new(context, "HSV Texture")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .uniform(
                "HSV Color Buffer",
                bytemuck::cast_slice(&[360.0f32, 1.0, 1.0]),
            )
            .build()?;

        Ok(Self { pipeline })
    }

    pub fn write_hsv_uniform(&self, context: &WgpuContext, hue: f32, saturation: f32, value: f32) {
        profiling::scope!("HSVWgpuPipeline::write_params");
        self.pipeline
            .write_uniform(context, 0, bytemuck::cast_slice(&[hue, saturation, value]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("HSVWgpuPipeline::render");
        self.pipeline.render(context, &[source], target)
    }
}
