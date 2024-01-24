use cgmath::{Matrix4, SquareMatrix};

use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct TransformWgpuPipeline {
    node_pipeline: NodePipeline,
}

impl TransformWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let identity: [[f32; 4]; 4] = Matrix4::<f32>::identity().into();
        let node_pipeline = NodePipelineBuilder::new(context, "Transform")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .uniform(
                "Transform Identity Matrix",
                bytemuck::cast_slice(&[identity]),
            )
            .build()?;

        Ok(Self { node_pipeline })
    }

    pub fn write_params(&self, context: &WgpuContext, matrix: [[f32; 4]; 4]) {
        profiling::scope!("TransformWgpuPipeline::write_params");
        self.node_pipeline
            .write_uniform(context, 0, bytemuck::cast_slice(&[matrix]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("TransformWgpuPipeline::render");
        self.node_pipeline.render(context, &[source], target)
    }
}
