use std::collections::HashMap;

pub use crate::inputs::*;
pub use crate::module::DmxModule;
pub use crate::outputs::*;

mod buffer;
pub mod commands;
mod inputs;
mod module;
mod outputs;
mod processor;

#[derive(Default)]
pub struct DmxConnectionManager {
    outputs: HashMap<String, DmxOutputConnection>,
    inputs: HashMap<String, DmxInputConnection>,
}

impl DmxConnectionManager {
    pub fn new() -> Self {
        DmxConnectionManager::default()
    }

    pub fn add_output(&mut self, id: String, output: impl Into<DmxOutputConnection>) {
        self.outputs.insert(id, output.into());
    }

    pub fn get_output(&self, name: &str) -> Option<&DmxOutputConnection> {
        self.outputs.get(name)
    }

    pub fn get_output_mut(&mut self, name: &str) -> Option<&mut DmxOutputConnection> {
        self.outputs.get_mut(name)
    }

    pub fn flush(&self) {
        for (_, output) in self.outputs.iter() {
            output.flush();
        }
    }

    pub fn list_outputs(&self) -> Vec<(&String, &DmxOutputConnection)> {
        self.outputs.iter().collect()
    }

    pub fn delete_output(&mut self, id: &str) -> Option<DmxOutputConnection> {
        self.outputs.remove(id)
    }

    pub fn clear(&mut self) {
        self.outputs.clear();
    }

    pub fn add_input(&mut self, id: String, input: impl Into<DmxInputConnection>) {
        self.inputs.insert(id, input.into());
    }

    pub fn get_input(&self, name: &str) -> Option<&DmxInputConnection> {
        self.inputs.get(name)
    }

    pub fn get_input_mut(&mut self, name: &str) -> Option<&mut DmxInputConnection> {
        self.inputs.get_mut(name)
    }

    pub fn list_inputs(&self) -> Vec<(&String, &DmxInputConnection)> {
        self.inputs.iter().collect()
    }

    pub fn delete_input(&mut self, id: &str) -> Option<DmxInputConnection> {
        self.inputs.remove(id)
    }
}
