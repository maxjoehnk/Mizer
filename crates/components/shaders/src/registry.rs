use crate::Shader;

#[derive(Default)]
pub struct ShaderRegistry {
    shaders: Vec<Box<dyn Shader>>,
}

impl ShaderRegistry {
    pub fn new() -> Self {
        Default::default()
    }

    pub fn add_shader(&mut self, shader: impl Shader + 'static) {
        self.shaders.push(Box::new(shader));
    }

    pub fn get_shader(&self, id: &str) -> Option<&dyn Shader> {
        self.shaders
            .iter()
            .find(|shader| shader.id() == id)
            .map(|shader| shader.as_ref())
    }

    pub fn list_shaders(&self) -> Vec<&dyn Shader> {
        self.shaders.iter().map(|shader| shader.as_ref()).collect()
    }

    pub fn list_shaders_with_type(&self, shader_type: &str) -> Vec<&dyn Shader> {
        self.shaders
            .iter()
            .filter(|shader| shader.shader_type() == shader_type)
            .map(|shader| shader.as_ref())
            .collect()
    }
}
