use wgpu::util::DeviceExt;

use crate::WgpuContext;

use super::builder::PipelineBindGroupImpl;

#[derive(Debug)]
pub(crate) struct Uniform {
    pub(crate) buffer: wgpu::Buffer,
    bind_group_layout: wgpu::BindGroupLayout,
    pub(crate) bind_group: wgpu::BindGroup,
}

impl Uniform {
    pub(crate) fn new(context: &WgpuContext, initial_value: &[u8], label: &str) -> Self {
        let uniform_bind_group_layout =
            context
                .device
                .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                    entries: &[wgpu::BindGroupLayoutEntry {
                        binding: 0,
                        visibility: wgpu::ShaderStages::FRAGMENT | wgpu::ShaderStages::VERTEX,
                        ty: wgpu::BindingType::Buffer {
                            ty: wgpu::BufferBindingType::Uniform,
                            has_dynamic_offset: false,
                            min_binding_size: None,
                        },
                        count: None,
                    }],
                    label: None,
                });
        let uniform_buffer = context
            .device
            .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                label: Some(label),
                contents: initial_value,
                usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
            });
        let uniform_bind_group = context
            .device
            .create_bind_group(&wgpu::BindGroupDescriptor {
                label: None,
                entries: &[wgpu::BindGroupEntry {
                    binding: 0,
                    resource: uniform_buffer.as_entire_binding(),
                }],
                layout: &uniform_bind_group_layout,
            });

        Self {
            buffer: uniform_buffer,
            bind_group: uniform_bind_group,
            bind_group_layout: uniform_bind_group_layout,
        }
    }
}

impl PipelineBindGroupImpl for Uniform {
    fn layout(&self) -> &wgpu::BindGroupLayout {
        &self.bind_group_layout
    }
}
