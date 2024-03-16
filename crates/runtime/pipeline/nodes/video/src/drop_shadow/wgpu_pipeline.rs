use mizer_node::Color;
use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

#[derive(Default, Debug, Clone, Copy, PartialEq, bytemuck::Pod, bytemuck::Zeroable)]
#[repr(C)]
struct ShadowSettings {
    pub color: [f32; 4],
    pub offsets: [f32; 2],
    pub _padding: [f32; 2],
}

pub struct DropShadowWgpuPipeline {
    effect_pipeline: NodePipeline,
}

impl DropShadowWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let effect_pipeline = NodePipelineBuilder::new(context, "Drop Shadow")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .uniform(
                "Drop Shadow Settings Buffer",
                bytemuck::cast_slice(&[ShadowSettings::default()]),
            )
            .build()?;

        Ok(Self { effect_pipeline })
    }

    pub fn write_params(
        &self,
        context: &WgpuContext,
        color: Color,
        (x_offset, y_offset): (f64, f64),
    ) {
        profiling::scope!("DropShadowWgpuPipeline::write_params");
        let settings = ShadowSettings {
            color: [
                color.red as f32,
                color.green as f32,
                color.blue as f32,
                color.alpha as f32,
            ],
            _padding: Default::default(),
            offsets: [x_offset as f32, y_offset as f32],
        };
        self.effect_pipeline
            .write_uniform(context, 0, bytemuck::cast_slice(&[settings]));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("DropShadowWgpuPipeline::render");
        self.effect_pipeline.render(context, &[source], target)
    }
}
