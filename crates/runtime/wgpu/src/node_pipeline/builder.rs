use std::borrow::Cow;
use std::ops::Deref;

use anyhow::Context;
use wgpu::util::DeviceExt;
use wgpu::{ShaderModuleDescriptor, ShaderSource};

use super::textures::InputTextures;
use super::uniform::Uniform;
use super::uniforms::{BindGroupBuilder, Uniforms};
use crate::context::StandardShader;
use crate::{NodePipeline, WgpuContext, RECT_INDICES, RECT_VERTICES};

pub struct NodePipelineBuilder<'a> {
    pub(crate) context: &'a WgpuContext,
    pub(crate) label: &'static str,
    shaders: Vec<ShaderModuleBuilder<'a>>,
    pub(crate) bind_groups: Vec<PipelineBindGroup>,
    inputs: Vec<String>,
}

enum ShaderModuleBuilder<'a> {
    Combined(ShaderModuleDescriptor<'a>),
    Vertex(ShaderModuleDescriptor<'a>),
    Fragment(ShaderModuleDescriptor<'a>),
}

enum ShaderModule {
    Combined(wgpu::ShaderModule),
    Seperated {
        vertex: wgpu::ShaderModule,
        fragment: wgpu::ShaderModule,
    },
}

impl StandardShader for ShaderModule {
    fn vertex_shader(&self) -> &wgpu::ShaderModule {
        match self {
            ShaderModule::Combined(shader) => shader,
            ShaderModule::Seperated { vertex, .. } => vertex,
        }
    }

    fn vertex_entry_point(&self) -> &str {
        match self {
            ShaderModule::Combined(_) => "vs_main",
            ShaderModule::Seperated { .. } => "main",
        }
    }

    fn fragment_shader(&self) -> &wgpu::ShaderModule {
        match self {
            ShaderModule::Combined(shader) => shader,
            ShaderModule::Seperated { fragment, .. } => fragment,
        }
    }

    fn fragment_entry_point(&self) -> &str {
        match self {
            ShaderModule::Combined(_) => "fs_main",
            ShaderModule::Seperated { .. } => "main",
        }
    }
}

impl<'a> Deref for ShaderModuleBuilder<'a> {
    type Target = ShaderModuleDescriptor<'a>;

    fn deref(&self) -> &Self::Target {
        match self {
            ShaderModuleBuilder::Combined(shader) => shader,
            ShaderModuleBuilder::Vertex(shader) => shader,
            ShaderModuleBuilder::Fragment(shader) => shader,
        }
    }
}

impl<'a> NodePipelineBuilder<'a> {
    pub fn new(context: &'a WgpuContext, label: &'static str) -> Self {
        Self {
            context,
            label,
            shaders: Default::default(),
            inputs: Default::default(),
            bind_groups: Default::default(),
        }
    }

    pub fn shader(mut self, shader: ShaderModuleDescriptor<'a>) -> Self {
        self.shaders.push(ShaderModuleBuilder::Combined(shader));
        self
    }

    pub fn fragment_shader(mut self, shader: ShaderModuleDescriptor<'a>) -> Self {
        self.shaders.push(ShaderModuleBuilder::Fragment(shader));
        self
    }

    pub fn vertex_shader(mut self, shader: ShaderModuleDescriptor<'a>) -> Self {
        self.shaders.push(ShaderModuleBuilder::Vertex(shader));
        self
    }

    pub fn input(mut self, label: &str) -> Self {
        self.inputs
            .push(format!("{} Input Texture ({label})", self.label));
        self
    }

    pub fn uniform(mut self, label: &str, initial_value: &[u8]) -> Self {
        let uniform = Uniform::new(
            self.context,
            initial_value,
            &format!("{} Uniform Buffer ({})", self.label, label),
        );
        self.bind_groups
            .push(PipelineBindGroup::SingleUniform(uniform));

        self
    }

    pub fn bind_group(self, label: &'static str) -> BindGroupBuilder<'a> {
        BindGroupBuilder::new(self, label)
    }

    pub fn build(mut self) -> anyhow::Result<NodePipeline> {
        if self.shaders.is_empty() {
            anyhow::bail!("No shader provided");
        }

        for shader in self.shaders.iter() {
            Self::validate_shader(shader)?;
        }

        let shader = self.build_shader_module()?;
        println!("inputs: {:?}", self.inputs);
        if !self.inputs.is_empty() {
            let input_textures = InputTextures::new(
                self.context,
                self.inputs,
                &format!("{} Input Textures Bind Group Layout", self.label),
            )?;
            self.bind_groups
                .insert(0, PipelineBindGroup::Textures(input_textures));
        };
        println!("bind_group_layouts: {:#?}", self.bind_groups);
        let bind_group_layouts = self
            .bind_groups
            .iter()
            .map(|bind_group| bind_group.layout())
            .collect::<Vec<_>>();
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
            label: self.label,
            render_pipeline,
            vertex_buffer,
            index_buffer,
            bind_groups: self.bind_groups,
        })
    }

    fn build_shader_module(&mut self) -> anyhow::Result<ShaderModule> {
        let shader = if self.shaders.len() == 1 {
            let shader = self.shaders.pop().unwrap();
            if let ShaderModuleBuilder::Combined(shader) = shader {
                let shader = self.context.device.create_shader_module(shader);
                ShaderModule::Combined(shader)
            } else {
                anyhow::bail!("Missing fragment or vertex shader");
            }
        } else if self.shaders.len() == 2 {
            let vertex = self.shaders.iter().find_map(|shader| {
                if let ShaderModuleBuilder::Vertex(shader) = shader {
                    Some(self.context.device.create_shader_module(shader.clone()))
                } else {
                    None
                }
            });
            let fragment = self.shaders.iter().find_map(|shader| {
                if let ShaderModuleBuilder::Fragment(shader) = shader {
                    Some(self.context.device.create_shader_module(shader.clone()))
                } else {
                    None
                }
            });
            if let (Some(vertex), Some(fragment)) = (vertex, fragment) {
                ShaderModule::Seperated { vertex, fragment }
            } else {
                anyhow::bail!("Missing fragment or vertex shader");
            }
        } else {
            anyhow::bail!("Too many shaders provided");
        };

        Ok(shader)
    }

    fn validate_shader(shader: &ShaderModuleDescriptor) -> Result<(), anyhow::Error> {
        let module = match &shader.source {
            ShaderSource::Glsl { shader, stage, .. } => Cow::Owned(
                naga::front::glsl::Frontend::default()
                    .parse(&naga::front::glsl::Options::from(*stage), shader)
                    .map_err(|err| anyhow::anyhow!("Unable to parse glsl shader {err:?}"))?,
            ),
            ShaderSource::Wgsl(shader) => {
                Cow::Owned(naga::front::wgsl::Frontend::new().parse(shader)?)
            }
            ShaderSource::Naga(module) => module.clone(),
            _ => anyhow::bail!("Unsupported shader source"),
        };

        naga::valid::Validator::new(
            naga::valid::ValidationFlags::all(),
            naga::valid::Capabilities::empty(),
        )
        .validate(&module)
        .context("Validating shader")?;

        Ok(())
    }
}

#[derive(Debug)]
pub enum PipelineBindGroup {
    Textures(InputTextures),
    SingleUniform(Uniform),
    Uniforms(Uniforms),
}

impl PipelineBindGroupImpl for PipelineBindGroup {
    fn layout(&self) -> &wgpu::BindGroupLayout {
        match self {
            PipelineBindGroup::Textures(textures) => textures.layout(),
            PipelineBindGroup::SingleUniform(uniform) => uniform.layout(),
            PipelineBindGroup::Uniforms(uniforms) => uniforms.layout(),
        }
    }
}

impl PipelineBindGroup {
    pub fn bind_group(&self) -> Option<&wgpu::BindGroup> {
        match self {
            PipelineBindGroup::Textures(_) => None,
            PipelineBindGroup::SingleUniform(uniform) => Some(&uniform.bind_group),
            PipelineBindGroup::Uniforms(uniforms) => Some(&uniforms.bind_group),
        }
    }
}

pub trait PipelineBindGroupImpl {
    fn layout(&self) -> &wgpu::BindGroupLayout;
}
