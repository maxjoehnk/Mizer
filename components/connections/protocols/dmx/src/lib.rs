use std::collections::HashMap;
use std::ops::Deref;

use mizer_module::{Module, Runtime};
use mizer_processing::{Injector, Processor};

pub use crate::sacn::SacnOutput;
pub use crate::artnet::ArtnetOutput;

mod buffer;
mod sacn;
mod stub;
mod artnet;

pub trait DmxOutput {
    fn name(&self) -> String;
    fn write_single(&self, universe: u16, channel: u8, value: u8);
    fn write_bulk(&self, universe: u16, channel: u8, values: &[u8]);
    fn flush(&self);
    fn read_buffer(&self) -> HashMap<u16, [u8; 512]>;
}

#[derive(Default)]
pub struct DmxConnectionManager {
    outputs: HashMap<String, Box<dyn DmxOutput>>,
}

impl DmxConnectionManager {
    pub fn new() -> Self {
        DmxConnectionManager::default()
    }

    pub fn add_output(&mut self, id: String, output: impl DmxOutput + 'static) {
        self.outputs.insert(id, Box::new(output));
    }

    pub fn get_output(&self, name: &str) -> Option<&dyn DmxOutput> {
        self.outputs.get(name).map(|output| output.deref())
    }

    pub fn flush(&self) {
        for (_, output) in self.outputs.iter() {
            output.flush();
        }
    }

    pub fn list_outputs<'a>(&'a self) -> Vec<(&'a String, &'a Box<dyn DmxOutput>)> {
        self.outputs.iter().collect()
    }

    pub fn clear(&mut self) {
        self.outputs.clear();
    }
}

struct DmxProcessor;

impl Processor for DmxProcessor {
    fn post_process(&self, injector: &Injector) {
        profiling::scope!("DmxProcessor::post_process");
        if let Some(dmx) = injector.get::<DmxConnectionManager>() {
            dmx.flush();
        }
    }
}

pub struct DmxModule;

impl Module for DmxModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        log::debug!("Registering...");
        let dmx_manager = DmxConnectionManager::new();
        runtime.injector_mut().provide(dmx_manager);
        runtime.add_processor(DmxProcessor.into());

        Ok(())
    }
}
