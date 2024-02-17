use self::builder::*;
use crate::{WgpuContext, RECT_INDICES};
pub use builder::NodePipelineBuilder;

mod builder;
mod textures;
mod uniform;
mod uniforms;

pub struct NodePipeline {
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
    bind_groups: Vec<PipelineBindGroup>,
    label: &'static str,
}

impl NodePipeline {
    pub fn write_uniform(&self, context: &WgpuContext, index: usize, data: &[u8]) {
        profiling::scope!("NodePipeline::write_uniform");
        let uniform = self
            .bind_groups
            .iter()
            .filter_map(|bind_group| {
                if let PipelineBindGroup::SingleUniform(uniform) = bind_group {
                    Some(uniform)
                } else {
                    None
                }
            })
            .nth(index);
        if let Some(uniform) = uniform {
            context
                .queue
                .write_buffer(&uniform.buffer, 0, bytemuck::cast_slice(data));
        }
    }

    pub fn write_bind_group_buffer(
        &self,
        context: &WgpuContext,
        bind_group_index: usize,
        buffer_index: usize,
        data: &[u8],
    ) -> anyhow::Result<()> {
        let Some(bind_group) = self
            .bind_groups
            .iter()
            .filter_map(|bind_group| {
                if let PipelineBindGroup::Uniforms(uniforms) = bind_group {
                    Some(uniforms)
                } else {
                    None
                }
            })
            .nth(bind_group_index)
        else {
            anyhow::bail!("Bind group index out of range");
        };

        bind_group.write_buffer(context, buffer_index, data)
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        inputs: &[&wgpu::TextureView],
        target: &wgpu::TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("NodePipeline::render");
        let input_textures = self.bind_groups.iter().find_map(|bind_group| {
            if let PipelineBindGroup::Textures(input_textures) = bind_group {
                Some(input_textures)
            } else {
                None
            }
        });
        let texture_bind_group = if let Some(input_textures) = input_textures {
            anyhow::ensure!(
                inputs.len() == input_textures.len(),
                "Expected {} input textures, got {}",
                input_textures.len(),
                inputs.len()
            );
            Some(input_textures.create_bind_group(context, inputs))
        } else {
            None
        };
        let mut bind_groups = Vec::with_capacity(self.bind_groups.len());
        if let Some(texture_bind_group) = &texture_bind_group {
            bind_groups.push(texture_bind_group);
        }
        for uniform in &self.bind_groups {
            if let Some(bind_group) = uniform.bind_group() {
                bind_groups.push(bind_group);
            }
        }
        let command_buffer_label = format!("{} Render Pass", self.label);
        let mut command_buffer = context.create_command_buffer(&command_buffer_label);
        {
            let mut render_pass = command_buffer.start_render_pass(target);
            render_pass.set_pipeline(&self.render_pipeline);
            render_pass.set_vertex_buffer(0, self.vertex_buffer.slice(..));
            render_pass.set_index_buffer(self.index_buffer.slice(..), wgpu::IndexFormat::Uint16);
            for (index, bind_group) in bind_groups.iter().enumerate() {
                render_pass.set_bind_group(index as u32, bind_group, &[]);
            }
            render_pass.draw_indexed(0..(RECT_INDICES.len() as u32), 0, 0..1);
        }

        Ok(command_buffer.finish())
    }
}
