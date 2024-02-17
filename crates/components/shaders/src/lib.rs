use mizer_wgpu::wgpu::ShaderModuleDescriptor;
pub use module::ShaderModule;
pub use registry::ShaderRegistry;
use std::fmt::Debug;

mod module;
mod registry;

pub trait Shader: Debug {
    fn shader_type(&self) -> &'static str;
    fn fragment(&self) -> ShaderModuleDescriptor;
    fn vertex(&self) -> ShaderModuleDescriptor;
    fn name(&self) -> String;
    fn id(&self) -> String;
    fn inputs(&self) -> Vec<ShaderInput>;
    fn categories(&self) -> Vec<String>;
}

#[derive(Debug)]
pub struct ShaderInput {
    pub name: String,
    pub label: Option<String>,
    pub ty: ShaderInputType,
}

#[derive(Debug, Clone)]
pub enum ShaderInputType {
    Bool { default: Option<bool> },
    Long { default: Option<i64> },
    Float { default: Option<f64> },
    Color,
    Image,
}
