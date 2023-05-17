use enum_dispatch::enum_dispatch;
use std::collections::HashMap;

use mizer_module::{Module, Runtime};
use mizer_processing::*;

pub use crate::artnet::ArtnetOutput;
pub use crate::sacn::SacnOutput;

mod artnet;
mod buffer;
pub mod commands;
mod sacn;

#[enum_dispatch(DmxConnection)]
pub trait DmxOutput {
    fn name(&self) -> String;
    fn write_single(&self, universe: u16, channel: u16, value: u8);
    fn write_bulk(&self, universe: u16, channel: u16, values: &[u8]);
    fn flush(&self);
    fn read_buffer(&self) -> HashMap<u16, [u8; 512]>;
}

#[enum_dispatch]
pub enum DmxConnection {
    Artnet(ArtnetOutput),
    Sacn(SacnOutput),
}

#[derive(Default)]
pub struct DmxConnectionManager {
    outputs: HashMap<String, DmxConnection>,
}

impl DmxConnectionManager {
    pub fn new() -> Self {
        DmxConnectionManager::default()
    }

    pub fn add_output(&mut self, id: String, output: impl Into<DmxConnection>) {
        self.outputs.insert(id, output.into());
    }

    pub fn get_output(&self, name: &str) -> Option<&DmxConnection> {
        self.outputs.get(name)
    }

    pub fn get_output_mut(&mut self, name: &str) -> Option<&mut DmxConnection> {
        self.outputs.get_mut(name)
    }

    pub fn flush(&self) {
        for (_, output) in self.outputs.iter() {
            output.flush();
        }
    }

    pub fn list_outputs(&self) -> Vec<(&String, &DmxConnection)> {
        self.outputs.iter().collect()
    }

    pub fn delete_output(&mut self, id: &str) -> Option<DmxConnection> {
        self.outputs.remove(id)
    }

    pub fn clear(&mut self) {
        self.outputs.clear();
    }
}

#[derive(Debug)]
struct DmxProcessor;

impl Processor for DmxProcessor {
    #[tracing::instrument]
    fn post_process(&mut self, injector: &Injector, _: ClockFrame) {
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