use super::builder::PipelineBindGroupImpl;
use crate::WgpuContext;

#[derive(Debug)]
pub struct InputTextures {
    bind_group_layout: wgpu::BindGroupLayout,
    sampler: wgpu::Sampler,
    textures: Vec<String>,
}

impl InputTextures {
    pub fn new(context: &WgpuContext, textures: Vec<String>, label: &str) -> anyhow::Result<Self> {
        let sampler = context.create_sampler();
        let mut entries = Vec::with_capacity(textures.len() + 1);
        entries.push(wgpu::BindGroupLayoutEntry {
            binding: 0,
            visibility: wgpu::ShaderStages::FRAGMENT,
            ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
            count: None,
        });
        for (i, _label) in textures.iter().enumerate() {
            entries.push(wgpu::BindGroupLayoutEntry {
                binding: (i + 1) as u32,
                visibility: wgpu::ShaderStages::FRAGMENT,
                ty: wgpu::BindingType::Texture {
                    multisampled: false,
                    view_dimension: wgpu::TextureViewDimension::D2,
                    sample_type: wgpu::TextureSampleType::Float { filterable: true },
                },
                count: None,
            });
        }

        let bind_group_layout =
            context
                .device
                .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                    entries: &entries,
                    label: Some(label),
                });

        Ok(Self {
            sampler,
            bind_group_layout,
            textures,
        })
    }

    pub fn create_bind_group(
        &self,
        context: &WgpuContext,
        views: &[&wgpu::TextureView],
    ) -> wgpu::BindGroup {
        let mut entries = Vec::with_capacity(self.textures.len() + 1);
        entries.push(wgpu::BindGroupEntry {
            binding: 0,
            resource: wgpu::BindingResource::Sampler(&self.sampler),
        });
        for (i, view) in views.iter().enumerate() {
            entries.push(wgpu::BindGroupEntry {
                binding: (i + 1) as u32,
                resource: wgpu::BindingResource::TextureView(view),
            });
        }
        context
            .device
            .create_bind_group(&wgpu::BindGroupDescriptor {
                layout: &self.bind_group_layout,
                entries: &entries,
                label: Some("Input Textures Bind Group"),
            })
    }

    pub fn len(&self) -> usize {
        self.textures.len()
    }
}

impl PipelineBindGroupImpl for InputTextures {
    fn layout(&self) -> &wgpu::BindGroupLayout {
        &self.bind_group_layout
    }
}
