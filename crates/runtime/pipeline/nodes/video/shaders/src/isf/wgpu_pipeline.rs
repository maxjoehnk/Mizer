use mizer_shaders::{Shader, ShaderInputType};

use mizer_wgpu::{wgpu, NodePipeline, NodePipelineBuilder, TextureView, WgpuContext};

pub struct IsfShaderWgpuPipeline {
    pipeline: NodePipeline,
}

#[derive(Default, Debug, Copy, Clone, bytemuck::Zeroable, bytemuck::Pod)]
#[repr(C)]
pub struct IsfData {
    pub pass_index: i32,
    pub render_size: [f32; 2],
    pub time: f32,
    pub time_delta: f32,
    pub date: [f32; 4],
    pub frame_index: i32,
    pub _padding: [f32; 6],
}

impl IsfShaderWgpuPipeline {
    pub fn new(context: &WgpuContext, shader: &dyn Shader) -> anyhow::Result<Self> {
        let mut pipeline_builder = NodePipelineBuilder::new(context, "Shader Pipeline")
            .fragment_shader(shader.fragment())
            .vertex_shader(shader.vertex())
            .bind_group("ISF Data")
            .buffer(
                bytemuck::cast_slice(&[IsfData::default()]),
                "ISF Data",
                wgpu::ShaderStages::FRAGMENT | wgpu::ShaderStages::VERTEX,
            )
            .build();

        let inputs = shader.inputs();
        println!("inputs: {:?}", inputs);
        for input in &inputs {
            if let ShaderInputType::Image = input.ty {
                pipeline_builder = pipeline_builder.input(input.name.as_str());
            }
        }

        let buffer_length = shader
            .inputs()
            .iter()
            .map(|input| match input.ty {
                ShaderInputType::Bool { .. } => 1,
                ShaderInputType::Long { .. } => 1,
                ShaderInputType::Float { .. } => 1,
                ShaderInputType::Color { .. } => 4,
                ShaderInputType::Image { .. } => 0,
            })
            .sum();

        if buffer_length > 0 {
            let buffer = vec![0u32; buffer_length];

            pipeline_builder = pipeline_builder
                .bind_group("ISF Inputs")
                .buffer(
                    bytemuck::cast_slice(&buffer),
                    "ISF Inputs",
                    wgpu::ShaderStages::FRAGMENT,
                )
                .build();
        }

        let pipeline = pipeline_builder.build()?;

        Ok(Self { pipeline })
    }

    pub fn set_isf_data(&self, context: &WgpuContext, uniforms: IsfData) -> anyhow::Result<()> {
        self.pipeline
            .write_bind_group_buffer(context, 0, 0, bytemuck::cast_slice(&[uniforms]))?;

        Ok(())
    }

    pub fn set_isf_inputs(&self, context: &WgpuContext, data: &[u32]) -> anyhow::Result<()> {
        self.pipeline
            .write_bind_group_buffer(context, 1, 0, bytemuck::cast_slice(data))?;

        Ok(())
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        inputs: &[&wgpu::TextureView],
        target: &TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        self.pipeline.render(context, inputs, target)
    }
}
