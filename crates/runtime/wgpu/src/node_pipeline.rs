use crate::{WgpuContext, RECT_INDICES, RECT_VERTICES};
use wgpu::util::DeviceExt;
use wgpu::ShaderModuleDescriptor;

pub struct NodePipeline {
    sampler: wgpu::Sampler,
    input_textures: Vec<InputTexture>,
    render_pipeline: wgpu::RenderPipeline,
    vertex_buffer: wgpu::Buffer,
    index_buffer: wgpu::Buffer,
    uniforms: Vec<Uniform>,
    label: &'static str,
}

impl NodePipeline {
    pub fn write_uniform(&self, context: &WgpuContext, index: usize, data: &[u8]) {
        profiling::scope!("NodePipeline::write_uniform");
        context
            .queue
            .write_buffer(&self.uniforms[index].buffer, 0, bytemuck::cast_slice(data));
    }

    pub fn render(
        &self,
        context: &WgpuContext,
        inputs: &[&wgpu::TextureView],
        target: &wgpu::TextureView,
    ) -> anyhow::Result<wgpu::CommandBuffer> {
        profiling::scope!("NodePipeline::render");
        anyhow::ensure!(
            inputs.len() == self.input_textures.len(),
            "Expected {} input textures, got {}",
            self.input_textures.len(),
            inputs.len()
        );
        let mut texture_bind_groups = Vec::with_capacity(self.input_textures.len());
        for (texture, view) in self.input_textures.iter().zip(inputs) {
            let texture_bind_group = context.create_texture_bind_group(
                &texture.bind_group_layout,
                view,
                &self.sampler,
                &format!("{} Texture Bind Group", self.label),
            );
            texture_bind_groups.push(texture_bind_group);
        }
        let mut bind_groups = Vec::with_capacity(self.input_textures.len() + self.uniforms.len());
        for texture_bind_group in &texture_bind_groups {
            bind_groups.push(texture_bind_group);
        }
        for uniform in &self.uniforms {
            bind_groups.push(&uniform.bind_group);
        }
        let buffer_label = format!("{} Render Pass", self.label);
        let mut command_buffer = context.create_command_buffer(&buffer_label);
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

pub struct NodePipelineBuilder<'a> {
    context: &'a WgpuContext,
    label: &'static str,
    shader: Option<ShaderModuleDescriptor<'a>>,
    uniforms: Vec<Uniform>,
    inputs: Vec<InputTexture>,
}

impl<'a> NodePipelineBuilder<'a> {
    pub fn new(context: &'a WgpuContext, label: &'static str) -> Self {
        Self {
            context,
            label,
            shader: None,
            uniforms: Vec::new(),
            inputs: Vec::new(),
        }
    }

    pub fn shader(mut self, shader: ShaderModuleDescriptor<'a>) -> Self {
        self.shader = Some(shader);
        self
    }

    pub fn input(mut self, label: &str) -> Self {
        self.inputs.push(InputTexture::new(
            self.context,
            &format!("{} Input Texture ({label})", self.label),
        ));
        self
    }

    pub fn uniform(mut self, label: &str, initial_value: &[u8]) -> Self {
        self.uniforms.push(Uniform::new(
            self.context,
            initial_value,
            &format!("{} Uniform Buffer ({})", self.label, label),
            wgpu::ShaderStages::FRAGMENT,
        ));

        self
    }

    pub fn vertex_uniform(mut self, label: &str, initial_value: &[u8]) -> Self {
        self.uniforms.push(Uniform::new(
            self.context,
            initial_value,
            &format!("{} Uniform Buffer ({})", self.label, label),
            wgpu::ShaderStages::VERTEX,
        ));

        self
    }

    pub fn build(self) -> anyhow::Result<NodePipeline> {
        let shader = self
            .shader
            .ok_or_else(|| anyhow::anyhow!("No shader provided"))?;
        let shader = self.context.device.create_shader_module(shader);
        let sampler = self.context.create_sampler();
        let mut bind_group_layouts = vec![];
        for input in &self.inputs {
            bind_group_layouts.push(&input.bind_group_layout);
        }
        for uniform in &self.uniforms {
            bind_group_layouts.push(&uniform.bind_group_layout);
        }
        let render_pipeline = self.context.create_standard_pipeline(
            &bind_group_layouts,
            &shader,
            Some(&format!("{} Pipeline", self.label)),
        );

        let vertex_buffer =
            self.context
                .device
                .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                    label: Some(&format!("{} Vertex Buffer", self.label)),
                    contents: bytemuck::cast_slice(RECT_VERTICES),
                    usage: wgpu::BufferUsages::VERTEX,
                });

        let index_buffer =
            self.context
                .device
                .create_buffer_init(&wgpu::util::BufferInitDescriptor {
                    label: Some(&format!("{} Index Buffer", self.label)),
                    contents: bytemuck::cast_slice(RECT_INDICES),
                    usage: wgpu::BufferUsages::INDEX,
                });

        Ok(NodePipeline {
            sampler,
            label: self.label,
            render_pipeline,
            vertex_buffer,
            index_buffer,
            uniforms: self.uniforms,
            input_textures: self.inputs,
        })
    }
}

struct Uniform {
    buffer: wgpu::Buffer,
    bind_group_layout: wgpu::BindGroupLayout,
    bind_group: wgpu::BindGroup,
}

impl Uniform {
    fn new(
        context: &WgpuContext,
        initial_value: &[u8],
        label: &str,
        stage: wgpu::ShaderStages,
    ) -> Self {
        let uniform_bind_group_layout =
            context
                .device
                .create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
                    entries: &[wgpu::BindGroupLayoutEntry {
                        binding: 0,
                        visibility: stage,
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

struct InputTexture {
    bind_group_layout: wgpu::BindGroupLayout,
}

impl InputTexture {
    fn new(context: &WgpuContext, label: &str) -> Self {
        let bind_group_layout = context.create_texture_bind_group_layout(Some(label));

        Self { bind_group_layout }
    }
}
