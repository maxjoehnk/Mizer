use wgpu::util::DeviceExt;

use crate::WgpuContext;

use super::builder::{NodePipelineBuilder, PipelineBindGroup, PipelineBindGroupImpl};

#[derive(Debug)]
pub struct Uniforms {
    bind_group_layout: wgpu::BindGroupLayout,
    pub(crate) bind_group: wgpu::BindGroup,
    buffers: Vec<wgpu::Buffer>,
}

impl Uniforms {
    pub fn write_buffer(
        &self,
        context: &WgpuContext,
        buffer_index: usize,
        data: &[u8],
    ) -> anyhow::Result<()> {
        let Some(buffer) = self.buffers.get(buffer_index) else {
            anyhow::bail!("Buffer index out of range");
        };
        context.queue.write_buffer(buffer, 0, data);

        Ok(())
    }
}

impl PipelineBindGroupImpl for Uniforms {
    fn layout(&self) -> &wgpu::BindGroupLayout {
        &self.bind_group_layout
    }
}

pub struct BindGroupBuilder<'a> {
    pipeline_builder: NodePipelineBuilder<'a>,
    label: String,
    entries: Vec<BufferBindGroupEntry>,
}

struct BufferBindGroupEntry {
    layout_entry: wgpu::BindGroupLayoutEntry,
    buffer: wgpu::Buffer,
}

impl<'a> BindGroupBuilder<'a> {
    pub(crate) fn new(pipeline_builder: NodePipelineBuilder<'a>, label: &'static str) -> Self {
        Self {
            label: format!("{} Bind Group ({})", pipeline_builder.label, label),
            pipeline_builder,
            entries: Vec::new(),
        }
    }

    pub fn buffer(
        mut self,
        initial_value: &[u8],
        label: &str,
        visibility: wgpu::ShaderStages,
    ) -> Self {
        let buffer = self.pipeline_builder.context.device.create_buffer_init(
            &wgpu::util::BufferInitDescriptor {
                label: Some(label),
                contents: initial_value,
                usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
            },
        );
        self.entries.push(BufferBindGroupEntry {
            layout_entry: wgpu::BindGroupLayoutEntry {
                binding: self.entries.len() as u32,
                visibility,
                ty: wgpu::BindingType::Buffer {
                    ty: wgpu::BufferBindingType::Uniform,
                    has_dynamic_offset: false,
                    min_binding_size: None,
                },
                count: None,
            },
            buffer,
        });

        self
    }

    pub fn build(mut self) -> NodePipelineBuilder<'a> {
        let bind_group_layout = self
            .pipeline_builder
            .context
            .device
            .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                entries: &self
                    .entries
                    .iter()
                    .map(|entry| entry.layout_entry)
                    .collect::<Vec<_>>(),
                label: Some(&self.label),
            });
        let bind_group_entries = self
            .entries
            .iter()
            .map(|entry| wgpu::BindGroupEntry {
                binding: entry.layout_entry.binding,
                resource: entry.buffer.as_entire_binding(),
            })
            .collect::<Vec<_>>();

        let bind_group =
            self.pipeline_builder
                .context
                .device
                .create_bind_group(&wgpu::BindGroupDescriptor {
                    layout: &bind_group_layout,
                    entries: &bind_group_entries,
                    label: Some(&self.label),
                });
        let buffers = self.entries.into_iter().map(|entry| entry.buffer).collect();
        self.pipeline_builder
            .bind_groups
            .push(PipelineBindGroup::Uniforms(Uniforms {
                bind_group_layout,
                bind_group,
                buffers,
            }));

        self.pipeline_builder
    }
}
