use crate::sacn::SacnOutput;
use std::collections::HashMap;
use mizer_processing::{Processor, Injector};
use mizer_module::{Module, Runtime};
use std::ops::Deref;

mod sacn;
mod stub;
mod buffer;

pub trait DmxOutput {
    fn write_single(&self, universe: u16, channel: u8, value: u8);
    fn write_bulk(&self, universe: u16, channel: u8, values: &[u8]);
    fn flush(&self);
}

#[derive(Default)]
pub struct DmxConnectionManager {
    outputs: HashMap<String, Box<dyn DmxOutput>>,
}

impl DmxConnectionManager {
    pub fn new() -> Self {
        let mut manager = DmxConnectionManager::default();
        let output = SacnOutput::new();
        manager.outputs.insert("output".into(), Box::new(output));
        manager
    }

    pub fn get_output(&self, name: &str) -> Option<&dyn DmxOutput> {
        self.outputs.get(name).map(|output| output.deref())
    }

    pub fn flush(&self) {
        for (_, output) in self.outputs.iter() {
            output.flush();
        }
    }
}

struct DmxProcessor;

impl Processor for DmxProcessor {
    fn post_process(&self, injector: &Injector) {
        if let Some(dmx) = injector.get::<DmxConnectionManager>() {
            dmx.flush();
        }
    }
}

pub struct DmxModule;

impl Module for DmxModule {
    fn register(self, runtime: &mut dyn Runtime) -> anyhow::Result<()> {
        let dmx_manager = DmxConnectionManager::new();
        runtime.injector().provide(dmx_manager);
        runtime.add_processor(DmxProcessor.into());

        Ok(())
    }
}
