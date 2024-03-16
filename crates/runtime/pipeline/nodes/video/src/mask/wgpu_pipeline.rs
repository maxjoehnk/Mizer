use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct TextureMaskWgpuPipeline {
    effect_pipeline: NodePipeline,
}

impl TextureMaskWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let effect_pipeline = NodePipelineBuilder::new(context, "Texture Mask")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .input("Mask Texture")
            .fragment_uniform(
                "Texture Mask Threshold Buffer",
                bytemuck::cast_slice(&[1.0f32]),
            )
            .build()?;

        Ok(Self { effect_pipeline })
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
        mask: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("TextureMaskWgpuPipeline::render");
        self.effect_pipeline
            .render(context, &[source, mask], target)
    }
}
