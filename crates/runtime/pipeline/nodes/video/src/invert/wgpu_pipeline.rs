use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct InvertWgpuPipeline {
    pipeline: NodePipeline,
}

impl InvertWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let pipeline = NodePipelineBuilder::new(context, "Invert")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .build()?;

        Ok(Self { pipeline })
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("InvertWgpuPipeline::render");
        self.pipeline.render(context, &[source], target)
    }
}
