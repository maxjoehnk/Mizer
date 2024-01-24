use wgpu::util::DeviceExt;

use mizer_wgpu::{wgpu, TextureView, WgpuContext, RECT_INDICES, RECT_VERTICES};

pub struct OutputWgpuPipeline {
    sampler: wgpu::Sampler,
    texture_bind_group_layout: wgpu::BindGroupLayout,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
}

impl OutputWgpuPipeline {
    pub fn new(context: &WgpuContext) -> Self {
        let sampler = context.create_sampler();
        let texture_bind_group_layout =
            context.create_texture_bind_group_layout(Some("Output Texture Bind Group"));
        let shader = context
            .device
            .create_shader_module(wgpu::include_wgsl!("shader.wgsl"));
        let render_pipeline = context.create_standard_pipeline(
            &[&texture_bind_group_layout],
            &shader,
            Some("Output Pipeline"),
        );

        let vertex_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Output Vertex Buffer"),
                contents: bytemuck::cast_slice(RECT_VERTICES),
                usage: wgpu::BufferUsages::VERTEX,
            });

        let index_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some("Output Index Buffer"),
                contents: bytemuck::cast_slice(RECT_INDICES),
                usage: wgpu::BufferUsages::INDEX,
            });

        Self {
            sampler,
            texture_bind_group_layout,
            render_pipeline,
            vertex_buffer,
            index_buffer,
        }
    }

    pub fn render_input(
        &self,
        context: &WgpuContext,
        target: &TextureView,
        source: &TextureView,
    ) -> wgpu::CommandBuffer {
        profiling::scope!("OutputWgpuPipeline::render_input");
        let texture_bind_group = context.create_texture_bind_group(
            &self.texture_bind_group_layout,
            source,
            &self.sampler,
            "Output Texture Bind Group",
        );
        let mut command_buffer = context.create_command_buffer("Output Render Pass");
        {
            let mut render_pass = command_buffer.start_render_pass(target);
            render_pass.set_pipeline(&self.render_pipeline);
            render_pass.set_vertex_buffer(0, self.vertex_buffer.slice(..));
            render_pass.set_index_buffer(self.index_buffer.slice(..), wgpu::IndexFormat::Uint16);
            render_pass.set_bind_group(0, &texture_bind_group, &[]);
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        command_buffer.finish()
    }

    pub(crate) fn clear(&self, context: &WgpuContext, target: &TextureView) -> wgpu::CommandBuffer {
        profiling::scope!("OutputWgpuPipeline::clear");
        let mut command_buffer = context.create_command_buffer("Output Clear Render Pass");
        {
            command_buffer.start_render_pass(target);
        }

        command_buffer.finish()
    }
}
