use std::collections::HashMap;
use std::ops::Deref;

use anyhow::anyhow;
use chrono::{Datelike, Timelike};
use itertools::Itertools;
use serde::{Deserialize, Serialize};

use mizer_isf_shaders::{IsfShader, ISF_SHADER_TYPE};
use mizer_node::*;
use mizer_shaders::{Shader, ShaderInput, ShaderInputType, ShaderRegistry};
use mizer_wgpu::{wgpu, TextureHandle, TextureRegistry, WgpuContext, WgpuPipeline};

use super::wgpu_pipeline::{IsfData, IsfShaderWgpuPipeline};

const OUTPUT_PORT: &str = "Output";

const SHADER_SETTING: &str = "Shader";

#[derive(Default, Debug, Clone, Deserialize, Serialize, PartialEq)]
pub struct IsfShaderNode {
    pub shader: String,
    #[serde(default)]
    pub controls: HashMap<String, ShaderControl>,
}

#[derive(Debug, Clone, Deserialize, Serialize, PartialEq)]
pub enum ShaderControl {
    Bool(bool),
    Float(f64),
    Long(i64),
}

impl IsfShaderNode {
    fn get_selected_shader<'a>(
        &'a self,
        shader_registry: &'a ShaderRegistry,
    ) -> Option<&'a dyn Shader> {
        shader_registry.get_shader(&self.shader)
    }

    fn get_shader_inputs(&self, shader_registry: &ShaderRegistry) -> Vec<ShaderInput> {
        if let Some(shader) = self.get_selected_shader(shader_registry) {
            shader.inputs()
        } else {
            vec![]
        }
    }
}

impl ConfigurableNode for IsfShaderNode {
    fn settings(&self, injector: &Injector) -> Vec<NodeSetting> {
        let shader_registry = injector.get::<ShaderRegistry>();
        if shader_registry.is_none() {
            return vec![];
        }
        let shader_registry = shader_registry.unwrap();
        let shaders = shader_registry.list_shaders_with_type(ISF_SHADER_TYPE);
        let categories = shaders
            .iter()
            .flat_map(|shader| shader.categories())
            .unique()
            .sorted()
            .map(|category| SelectVariant::Group {
                children: shaders
                    .iter()
                    .filter_map(|shader| {
                        if shader.categories().contains(&category) {
                            Some(SelectVariant::Item {
                                label: shader.name().into(),
                                value: shader.id().into(),
                            })
                        } else {
                            None
                        }
                    })
                    .sorted_by_key(|variant| variant.label())
                    .collect(),
                label: category.into(),
            })
            .collect::<Vec<_>>();

        let inputs = self.get_shader_inputs(shader_registry);
        let mut shader_settings: Vec<_> = inputs
            .into_iter()
            .filter_map(|input| match input.ty {
                ShaderInputType::Bool { default } => {
                    let value = self
                        .controls
                        .get(&input.name)
                        .map(|control| match control {
                            ShaderControl::Bool(value) => *value,
                            _ => Default::default(),
                        })
                        .or(default)
                        .unwrap_or_default();

                    let mut setting = setting!(input.name, value);
                    if let Some(label) = input.label {
                        setting = setting.label(label);
                    }
                    Some(setting)
                }
                ShaderInputType::Float { default } => {
                    let value = self
                        .controls
                        .get(&input.name)
                        .map(|control| match control {
                            ShaderControl::Float(value) => *value,
                            _ => Default::default(),
                        })
                        .or(default)
                        .unwrap_or_default();

                    let mut setting = setting!(input.name, value);
                    if let Some(label) = input.label {
                        setting = setting.label(label);
                    }
                    Some(setting)
                }
                ShaderInputType::Long { default } => {
                    let value = self
                        .controls
                        .get(&input.name)
                        .map(|control| match control {
                            ShaderControl::Long(value) => *value,
                            _ => Default::default(),
                        })
                        .or(default)
                        .unwrap_or_default();

                    let mut setting = setting!(input.name, value);
                    if let Some(label) = input.label {
                        setting = setting.label(label);
                    }
                    Some(setting)
                }
                _ => None,
            })
            .collect();

        shader_settings.insert(0, setting!(select SHADER_SETTING, &self.shader, categories));

        shader_settings
    }

    fn update_setting(&mut self, setting: NodeSetting) -> anyhow::Result<()> {
        update!(select setting, SHADER_SETTING, self.shader, |value: String| {
            self.controls.clear();

            // Using try_into here because the closure requires a result as return type
            #[allow(clippy::useless_conversion)]
            value.try_into()
        });
        if let Some(control) = self.controls.get_mut(setting.id.as_ref()) {
            match control {
                ShaderControl::Bool(value) => update!(bool setting, setting.id, *value),
                ShaderControl::Float(value) => update!(float setting, setting.id, *value),
                ShaderControl::Long(value) => update!(int setting, setting.id, *value),
            }
        } else {
            match setting.value {
                NodeSettingValue::Bool { value, .. } => {
                    self.controls
                        .insert(setting.id.to_string(), ShaderControl::Bool(value));
                }
                NodeSettingValue::Float { value, .. } => {
                    self.controls
                        .insert(setting.id.to_string(), ShaderControl::Float(value));
                }
                NodeSettingValue::Int { value, .. } => {
                    self.controls
                        .insert(setting.id.to_string(), ShaderControl::Long(value));
                }
                _ => {}
            }
        }

        update_fallback!(setting)
    }
}

impl PipelineNode for IsfShaderNode {
    fn details(&self) -> NodeDetails {
        NodeDetails {
            node_type_name: "ISF Shader".into(),
            preview_type: PreviewType::Texture,
            category: NodeCategory::Video,
        }
    }

    fn list_ports(&self, injector: &Injector) -> Vec<(PortId, PortMetadata)> {
        let mut ports = vec![output_port!(OUTPUT_PORT, PortType::Texture)];
        if let Some(shader_registry) = injector.get::<ShaderRegistry>() {
            self.get_shader_inputs(shader_registry)
                .into_iter()
                .for_each(|input| match input.ty {
                    ShaderInputType::Bool { .. } => {
                        ports.push(input_port!(input.name, PortType::Single));
                    }
                    ShaderInputType::Float { .. } => {
                        ports.push(input_port!(input.name, PortType::Single));
                    }
                    ShaderInputType::Long { .. } => {
                        ports.push(input_port!(input.name, PortType::Single));
                    }
                    ShaderInputType::Image => {
                        ports.push(input_port!(input.name, PortType::Texture));
                    }
                    ShaderInputType::Color => {
                        ports.push(input_port!(input.name, PortType::Color));
                    }
                    _ => {}
                });
        }

        ports
    }

    fn node_type(&self) -> NodeType {
        NodeType::IsfShader
    }
}

impl ProcessingNode for IsfShaderNode {
    type State = Option<ShaderState>;

    fn process(&self, context: &impl NodeContext, state: &mut Self::State) -> anyhow::Result<()> {
        let wgpu_context = context.inject::<WgpuContext>().unwrap();
        let wgpu_pipeline = context.inject::<WgpuPipeline>().unwrap();
        let texture_registry = context.inject::<TextureRegistry>().unwrap();
        let shader_registry = context.inject::<ShaderRegistry>().unwrap();
        let Some(shader) = self.get_selected_shader(shader_registry) else {
            return Ok(());
        };
        if state.is_none() {
            *state = Some(ShaderState::new(wgpu_context, texture_registry, shader)?);
        }
        let state = state.as_mut().unwrap();
        if state.shader != self.shader {
            state.change_shader(wgpu_context, shader)?;
        }
        state.write_isf_data(context, wgpu_context)?;
        let shader_inputs = self.get_shader_inputs(shader_registry);
        let inputs = shader_inputs
            .iter()
            .flat_map(|input| match input.ty {
                ShaderInputType::Bool { default } => {
                    let value = self
                        .read_bool_control(context, input.name.as_str(), default)
                        .unwrap_or_default();

                    vec![value as u32]
                }
                ShaderInputType::Float { default } => {
                    let value = self
                        .read_float_control(context, input.name.as_str(), default)
                        .unwrap_or_default();

                    vec![(value as f32).to_bits()]
                }
                ShaderInputType::Long { default } => {
                    let value = self
                        .read_long_control(context, input.name.as_str(), default)
                        .unwrap_or_default();

                    vec![(value as i32) as u32]
                }
                ShaderInputType::Color => {
                    let value = context
                        .color_input(input.name.as_str())
                        .read()
                        .unwrap_or_default();

                    vec![
                        (value.red as f32).to_bits(),
                        (value.green as f32).to_bits(),
                        (value.blue as f32).to_bits(),
                        (value.alpha as f32).to_bits(),
                    ]
                }
                ShaderInputType::Image => Vec::default(),
            })
            .collect::<Vec<_>>();
        state.write_isf_inputs(wgpu_context, &inputs)?;
        let input_textures = shader_inputs
            .iter()
            .filter_map(|input| match input.ty {
                ShaderInputType::Image => context.read_texture(input.name.as_str()),
                _ => None,
            })
            .collect::<Vec<_>>();
        let views = input_textures
            .iter()
            .map(|texture| texture.deref())
            .collect::<Vec<&wgpu::TextureView>>();
        let output = texture_registry
            .get(&state.target_texture)
            .ok_or_else(|| anyhow!("Missing target texture"))?;
        let stage = state
            .pipeline
            .render(wgpu_context, views.as_slice(), &output)?;

        wgpu_pipeline.add_stage(stage);

        context.write_port(OUTPUT_PORT, state.target_texture);

        Ok(())
    }

    fn create_state(&self) -> Self::State {
        Default::default()
    }
}

impl IsfShaderNode {
    fn get_bool(&self, name: &str) -> Option<bool> {
        self.controls.get(name).and_then(|control| match control {
            ShaderControl::Bool(value) => Some(*value),
            _ => None,
        })
    }

    fn read_bool_control(
        &self,
        context: &impl NodeContext,
        name: &str,
        default: Option<bool>,
    ) -> Option<bool> {
        context
            .single_input(name)
            .read()
            .map(|input| input > 0f64)
            .or_else(|| self.get_bool(name))
            .or(default)
    }

    fn get_float(&self, name: &str) -> Option<f64> {
        self.controls.get(name).and_then(|control| match control {
            ShaderControl::Float(value) => Some(*value),
            _ => None,
        })
    }

    fn read_float_control(
        &self,
        context: &impl NodeContext,
        name: &str,
        default: Option<f64>,
    ) -> Option<f64> {
        context
            .single_input(name)
            .read()
            .or_else(|| self.get_float(name))
            .or(default)
    }

    fn get_long(&self, name: &str) -> Option<i64> {
        self.controls.get(name).and_then(|control| match control {
            ShaderControl::Long(value) => Some(*value),
            _ => None,
        })
    }

    fn read_long_control(
        &self,
        context: &impl NodeContext,
        name: &str,
        default: Option<i64>,
    ) -> Option<i64> {
        context
            .single_input(name)
            .read()
            .map(|input| input.round() as i64)
            .or_else(|| self.get_long(name))
            .or(default)
    }
}

pub struct ShaderState {
    shader: String,
    pipeline: IsfShaderWgpuPipeline,
    target_texture: TextureHandle,
    frame_index: usize,
}

impl ShaderState {
    fn new(
        wgpu_context: &WgpuContext,
        texture_registry: &TextureRegistry,
        shader: &dyn Shader,
    ) -> anyhow::Result<Self> {
        Ok(Self {
            shader: shader.id(),
            pipeline: IsfShaderWgpuPipeline::new(wgpu_context, shader)?,
            target_texture: texture_registry.register(
                wgpu_context,
                1920,
                1080,
                Some("Shader Target Texture"),
            ),
            frame_index: 0,
        })
    }

    fn change_shader(&mut self, context: &WgpuContext, shader: &dyn Shader) -> anyhow::Result<()> {
        tracing::debug!("Changing shader to {}", shader.id());
        self.pipeline = IsfShaderWgpuPipeline::new(context, shader)?;
        self.shader = shader.id();

        Ok(())
    }

    fn write_isf_data(
        &self,
        context: &impl NodeContext,
        wgpu_context: &WgpuContext,
    ) -> anyhow::Result<()> {
        let uniforms = self.get_uniforms(context);
        self.pipeline.set_isf_data(wgpu_context, uniforms)?;

        Ok(())
    }

    fn get_uniforms(&self, context: &impl NodeContext) -> IsfData {
        let frame = context.clock();
        let date = chrono::Utc::now();
        let year = date.year() as f32;
        let month = date.month() as f32;
        let day = date.day() as f32;
        let seconds = date.num_seconds_from_midnight() as f32;

        IsfData {
            pass_index: 0,
            render_size: [1920.0, 1080.0],
            time: frame.frame as f32,
            time_delta: frame.delta as f32,
            date: [year, month, day, seconds],
            frame_index: self.frame_index as i32,
            _padding: [0.0; 6],
        }
    }

    fn write_isf_inputs(&self, wgpu_context: &WgpuContext, data: &[u32]) -> anyhow::Result<()> {
        self.pipeline.set_isf_inputs(wgpu_context, data)?;

        Ok(())
    }
}
