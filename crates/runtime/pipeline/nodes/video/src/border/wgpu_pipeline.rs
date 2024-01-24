use mizer_node::Color;
use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

#[derive(Default, Debug, Clone, Copy, PartialEq, bytemuck::Pod, bytemuck::Zeroable)]
#[repr(C)]
struct BorderSettings {
    pub color: [f32; 4],
    pub widths: [f32; 4],
}

pub struct BorderWgpuPipeline {
    effect_pipeline: NodePipeline,
}

impl BorderWgpuPipeline {
    pub fn new(context: &WgpuContext) -> anyhow::Result<Self> {
        let effect_pipeline = NodePipelineBuilder::new(context, "Border")
            .shader(wgpu::include_wgsl!("shader.wgsl"))
            .input("Source Texture")
            .uniform(
                "Border Settings Buffer",
                bytemuck::cast_slice(&[BorderSettings::default()]),
            )
            .build()?;

        Ok(Self { effect_pipeline })
    }

    pub fn write_params(
        &self,
        context: &WgpuContext,
        color: Color,
        border_width: f64,
        (top, right, bottom, left): (bool, bool, bool, bool),
    ) {
        profiling::scope!("BorderWgpuPipeline::write_params");
        let vertical_width = border_width as f32 / 1080f32;
        let horizontal_width = border_width as f32 / 1920f32;
        let settings = BorderSettings {
            color: [
                color.red as f32,
                color.green as f32,
                color.blue as f32,
                color.alpha as f32,
            ],
            widths: [
                left.then_some(horizontal_width).unwrap_or_default(),
                top.then_some(vertical_width).unwrap_or_default(),
                1f32 - right.then_some(horizontal_width).unwrap_or_default(),
                1f32 - bottom.then_some(vertical_width).unwrap_or_default(),
            ],
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
        profiling::scope!("BorderWgpuPipeline::render");
        self.effect_pipeline.render(context, &[source], target)
    }
}
